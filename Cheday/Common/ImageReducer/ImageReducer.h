//
//  ImageReducer.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 07.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageReducer : NSObject

-(UIImage*) reduceImage:(UIImage*)image toSize:(CGSize)size;

@end
