//
//

#import "UIView+Base.h"
#import <QuartzCore/QuartzCore.h>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation UIView (Debug)

-(NSArray *) allSubviewsForView: (UIView *) view{
    
	NSMutableArray *subviews = [NSMutableArray array];
	[subviews addObject: view];
    
	for( UIView *subview in view.subviews ){
		[subviews addObjectsFromArray: [self allSubviewsForView: subview]];
	}
	return [NSArray arrayWithArray: subviews];
}

-(NSArray *) allSubviews{
	return [self allSubviewsForView: self];
}


-(void)showDebugRect:(BOOL) show_{
    
    for( UIView *view in [self allSubviews]){
        
		//view.clipsToBounds = YES;
		view.layer.borderWidth = 1.0f;
        
        if (show_) {
            view.layer.borderColor = [[UIColor redColor] CGColor];
        }else {
            view.layer.borderColor = [[UIColor clearColor] CGColor];
        }
	}
}

@end
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation UIView (remove)

-(void)removeAllSubviews{
    for (UIView *sub in [self subviews]) {
        [sub removeFromSuperview];
    }
}
@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation UIView (responder)

- (UIView *)findFirstResponder {
    if (self.isFirstResponder) return self;
    
    for (UIView *subView in self.subviews) {
        if ([subView findFirstResponder]) return subView;
    }
    return nil;
}

- (BOOL)findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder])
            return YES;
    }
    return NO;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation UIView (fade)

-(void)fade{
    CATransition * transition = [CATransition animation];
    [transition setDuration:0.2f];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [transition setType:kCATransitionFade];
    [self.layer addAnimation:transition forKey:@"fade"];
}

@end
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

@implementation UIView (Recursion)

- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView* subview in self.subviews ) {
        BOOL stop = NO;
        if( recurse( subview, &stop ) ) {
            return [subview findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    
    return nil;
}

@end
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


@implementation UIView (RoundedCorners)

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size {
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer* maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
}

@end
