//
//  CDRoundedTextField.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "RoundedTextField.h"

@implementation RoundedTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.bounds.size.height/2;
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x += self.bounds.size.height/2-self.leftView.bounds.size.width/3;
    return rect;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    rect.size.width -= self.bounds.size.height/2 + 2*self.leftView.bounds.size.width/3;
    return rect;
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

@end
