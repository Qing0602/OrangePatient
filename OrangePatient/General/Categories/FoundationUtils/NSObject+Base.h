//
//  NSObject+Love.h
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface NSObject (weak)

+(id)weak:(id) source;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

typedef void (^KVOBlock)(NSString *keyPath, id object, NSDictionary *change);

@interface NSObject (NSObject_KVOBlock)

- (id)addKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions handler:(KVOBlock)inHandler;
- (id)addKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions identifier:(NSString *)inIdentifier handler:(KVOBlock)inHandler;

/// One shot blocks remove themselves after they've been fired once.
- (id)addOneShotKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions handler:(KVOBlock)inHandler;
- (id)addOneShotKVOBlockForKeyPath:(NSString *)inKeyPath options:(NSKeyValueObservingOptions)inOptions identifier:(NSString *)inIdentifier handler:(KVOBlock)inHandler;

- (void)removeKVOBlockForToken:(id)inToken;
- (void)removeKVOBlockForKeyPath:(NSString *)inKeyPath identifier:(NSString *)inIdentifier;

- (NSArray *)allKVOObservers;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


