//
//  ImageReducer.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 07.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ImageReducer.h"
#import <AVFoundation/AVFoundation.h>

@implementation ImageReducer

-(UIImage *)reduceImage:(UIImage *)image toSize:(CGSize)requiredSize
{
    UIImage *resultImage = nil;
    if((image.size.width > requiredSize.width) && (image.size.height > requiredSize.height))
    {
        CGRect rect = AVMakeRectWithAspectRatioInsideRect(image.size, CGRectMake(0, 0, requiredSize.width, requiredSize.height));
        rect.origin = CGPointZero;
        rect = CGRectIntegral(rect);
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1.0);
        [image drawInRect:rect];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
        resultImage = image;
    }
    return resultImage;
}

@end
