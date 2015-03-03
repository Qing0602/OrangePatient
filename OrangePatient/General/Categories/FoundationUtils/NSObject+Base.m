//
//

#import "NSObject+Base.h"
#import <objc/runtime.h>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation NSObject (weak)

+(id)weak:(id) source{
    __weak __typeof(&*source)weakSelf = source;
    return weakSelf;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CKVOBlockHelper : NSObject
@property (readonly, nonatomic, strong) NSMutableDictionary *blocksForIdentifier;
+ (CKVOBlockHelper *)helperForObject:(id)inObject create:(BOOL)inCreate;
- (id)initWithObject:(id)inObject;
- (id)keyForKeyPath:(NSString *)inKeyPath identifier:(NSString *)inIdentifier;
- (NSString *)keypathForKey:(id)inKey;
- (id)canonicalKeyForKey:(id)inKey;
@end

#pragma mark -

@implementation NSObject (NSObject_KVOBlock)

static void *KVO;

- (id)addKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions handler:(KVOBlock)inHandler;
{
    return([self addKVOBlockForKeyPath:inKeyPath options:inOptions identifier:NULL handler:inHandler]);
}

- (id)addKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions identifier:(NSString *)inIdentifier handler:(KVOBlock)inHandler;
{
    NSParameterAssert(inHandler);
    NSParameterAssert(inKeyPath);
    
    if (inIdentifier == NULL)
    {
        CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef theUUIDString = CFUUIDCreateString(kCFAllocatorDefault, theUUID);
        inIdentifier = (__bridge_transfer NSString *)theUUIDString;
        CFRelease(theUUID);
    }
    
    CKVOBlockHelper *theHelper = [CKVOBlockHelper helperForObject:self create:YES];
    
    id theKey = [theHelper keyForKeyPath:inKeyPath identifier:inIdentifier];
    
    if ([theHelper.blocksForIdentifier objectForKey:theKey] != NULL)
    {
        void *theContext = (__bridge void *)[theHelper canonicalKeyForKey:theKey];
        [self removeObserver:theHelper forKeyPath:inKeyPath context:theContext];
    }
    
    [theHelper.blocksForIdentifier setObject:[inHandler copy] forKey:theKey];
    
    void *theContext = (__bridge void *)[theHelper canonicalKeyForKey:theKey];
    [self addObserver:theHelper forKeyPath:inKeyPath options:inOptions context:theContext];
    
    return(theKey);
}

- (id)addOneShotKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions handler:(KVOBlock)inHandler
{
    __block id theToken = NULL;
    KVOBlock theBlock = ^(NSString *keyPath, id object, NSDictionary *change) {
        inHandler(keyPath, object, change);
        [self removeKVOBlockForToken:theToken];
    };
    
    theToken = [self addKVOBlockForKeyPath:inKeyPath options:inOptions handler:theBlock];
    return(theToken);
}

- (id)addOneShotKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions identifier:(NSString *)inIdentifier handler:(KVOBlock)inHandler
{
    __block id theToken = NULL;
    KVOBlock theBlock = ^(NSString *keyPath, id object, NSDictionary *change) {
        inHandler(keyPath, object, change);
        [self removeKVOBlockForToken:theToken];
    };
    
    theToken = [self addKVOBlockForKeyPath:inKeyPath options:inOptions identifier:inIdentifier handler:theBlock];
    return(theToken);
}

- (void)removeKVOBlockForToken:(id)inToken
{
    CKVOBlockHelper *theHelper = [CKVOBlockHelper helperForObject:self create:NO];
    
    if (theHelper == NULL)
    {
        return;
    }
    
    void *theContext = (__bridge void *)[theHelper canonicalKeyForKey:inToken];
    NSString *theKeyPath = [theHelper keypathForKey:inToken];
    [self removeObserver:theHelper forKeyPath:theKeyPath context:theContext];
    
    [theHelper.blocksForIdentifier removeObjectForKey:inToken];
    
    if (theHelper.blocksForIdentifier.count == 0)
    {
        objc_setAssociatedObject(self, &KVO, NULL, OBJC_ASSOCIATION_RETAIN);
    }
}

- (void)removeKVOBlockForKeyPath:(NSString *)inKeyPath identifier:(NSString *)inIdentifier
{
    NSParameterAssert(inKeyPath);
    NSParameterAssert(inIdentifier);
    
    CKVOBlockHelper *theHelper = [CKVOBlockHelper helperForObject:self create:NO];
    
    id theKey = [theHelper keyForKeyPath:inKeyPath identifier:inIdentifier];
    
    [self removeKVOBlockForToken:theKey];
}

- (NSArray *)allKVOObservers
{
    CKVOBlockHelper *theHelper = objc_getAssociatedObject(self, &KVO);
    return([theHelper.blocksForIdentifier allKeys]);
}

@end

#pragma mark -

@interface CKVOBlockHelper ()
@property (readonly, nonatomic, weak) id observedObject;
@end

#pragma mark -

@implementation CKVOBlockHelper

@synthesize blocksForIdentifier;
@synthesize observedObject;

+ (CKVOBlockHelper *)helperForObject:(id)inObject create:(BOOL)inCreate
{
    CKVOBlockHelper *theHelper = objc_getAssociatedObject(inObject, &KVO);
    if (theHelper == NULL && inCreate == YES)
    {
        theHelper = [[CKVOBlockHelper alloc] initWithObject:inObject];
        
        objc_setAssociatedObject(inObject, &KVO, theHelper, OBJC_ASSOCIATION_RETAIN);
    }
    return(theHelper);
}

- (id)initWithObject:(id)inObject
{
	if ((self = [super init]) != NULL)
    {
        observedObject = inObject;
        blocksForIdentifier = [[NSMutableDictionary alloc] init];
    }
	return(self);
}

- (void)dealloc
{
    [blocksForIdentifier enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *theKeypath = [key objectAtIndex:0];
        [observedObject removeObserver:self forKeyPath:theKeypath context:(__bridge void *)key];
    }];
}

- (NSString *)debugDescription
{
    return([NSString stringWithFormat:@"%@ (%@, %@, %@)", [self description], self.observedObject, self.blocksForIdentifier, [self.observedObject observationInfo]]);
}

- (id)keyForKeyPath:(NSString *)inKeyPath identifier:(NSString *)inIdentifier
{
    return([NSArray arrayWithObjects:inKeyPath, inIdentifier, NULL]);
}

- (NSString *)keypathForKey:(id)inKey
{
    return([inKey objectAtIndex:0]);
}

- (id)canonicalKeyForKey:(id)inKey
{
    NSArray *theKeys = [self.blocksForIdentifier allKeys];
    NSUInteger theIndex = [theKeys indexOfObject:inKey];
    NSAssert(theIndex != NSNotFound, @"KVOBlock never registered");
    NSArray *theKey = [theKeys objectAtIndex:theIndex];
    return(theKey);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
{
    NSParameterAssert(context);
    
    NSArray *theKey = (__bridge NSArray *)context;
    
    KVOBlock theBlock = [self.blocksForIdentifier objectForKey:theKey];
    if (theBlock == NULL)
    {
        NSLog(@"Warning: Could not find block for key: %@", theKey);
    }
    else
    {
        theBlock(keyPath, object, change);
    }
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


#import <objc/runtime.h>
#import <objc/message.h>


static NSString const *NSObjectKVOSFObserversArrayKey = @"NSObjectKVOSFObserversArrayKey";
static NSString const *NSObjectKVOSFObserversAllowMethodForwardingKey = @"NSObjectKVOSFObserversAllowMethodForwardingKey";

static NSString *NSObjectKVOSFObserversAddSelector = @"sf_original_addObserver:forKeyPath:options:context:";
static NSString *NSObjectKVOSFObserversRemoveSelector = @"sf_original_removeObserver:forKeyPath:";
static NSString *NSObjectKVOSFObserversRemoveSpecificSelector = @"sf_original_removeObserver:forKeyPath:context:";

