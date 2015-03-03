//
//

#import "UIApplication+Base.h"

@implementation UIApplication (Base)

@end



@implementation UIApplication (NetworkActivity)

static NSInteger networkOperationCount;

+ (void)startNetworkActivity {
    networkOperationCount++;
    [[UIApplication sharedApplication] updateNetworkActivityIndicator];
}

+ (void)finishNetworkActivity {
    networkOperationCount--;
    [[UIApplication sharedApplication] updateNetworkActivityIndicator];
}

- (void)updateNetworkActivityIndicator {
    [self setNetworkActivityIndicatorVisible:(networkOperationCount > 0 ? TRUE : FALSE)];
}

@end