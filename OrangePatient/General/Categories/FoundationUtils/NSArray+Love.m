//
//  NSArray+Love.m
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import "NSArray+Love.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation NSArray (accessors)
@dynamic first, last;

- (id)first {
    
    if ([self count]>0)
        return [self objectAtIndex:0];

    return nil;
}

- (id)last {
    
    if ([self count]>0)
        return [self lastObject];
 
    return nil;
}

- (void)each:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)eachWithIndex:(void (^)(id object, int index))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}
@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation NSMutableArray (Love)

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////