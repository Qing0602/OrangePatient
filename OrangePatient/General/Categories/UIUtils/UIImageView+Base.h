//
//  UIImageView+Love.h
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//



@interface UIImageView (Love)

@end


@interface UIImageView (UIImageView_FaceAwareFill)

//Ask the image to perform an "Aspect Fill" but centering the image to the detected faces
//Not the simple center of the image
- (void) faceAwareFill;

//If showFaces == YES a red rectangle is draw over the detected faces (useful for debugging)
- (void) faceAwareFillShowFaces:(BOOL) showFaces;

@end