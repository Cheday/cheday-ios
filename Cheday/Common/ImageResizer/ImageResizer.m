//
//  ImageResizer.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 07.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ImageResizer.h"

@implementation ImageResizer

-(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
