//
//  CDRoundedButton.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CDRoundedButton.h"

@interface CDRoundedButton ()

@property(nonatomic, strong) UIColor *nonHighlightedBackgroundColor;

@end

@implementation CDRoundedButton

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.nonHighlightedBackgroundColor = self.backgroundColor;
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if(highlighted)
    {
        self.backgroundColor = self.highlightedBackgroundColor;
    }else
    {
        self.backgroundColor = self.nonHighlightedBackgroundColor;
    }
}

@end
