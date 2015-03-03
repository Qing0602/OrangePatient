//
//  LoveUtils.h
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#ifndef iLove_LoveUtils_h
#define iLove_LoveUtils_h

#import "BaseFDUtils.h"
#import "BaseUIUtils.h"


// from Bee_framework,thanks 
#undef	LOVE_SINGLETON_INTER
#define LOVE_SINGLETON_INTER( __class ) \
        + (__class *)sharedInstance;

#undef	LOVE_SINGLETON_IMPL                
#define LOVE_SINGLETON_IMPL( __class ) \
        + (__class *)sharedInstance \
        { \
           static dispatch_once_t once; \
           static __class * __singleton__; \
           dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
           return __singleton__; \
        }


#endif
