//
//  CDRoundedButton.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "RoundedButton.h"

@interface RoundedButton ()

@property(nonatomic, strong) UIColor *currentBackgroundColor;
@property(nonatomic, strong) UIColor *originalBackgroundColor;

@end

@implementation RoundedButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.bounds.size.height/2;
        [self addObserver:self
               forKeyPath:@"bounds"
                  options:NSKeyValueObservingOptionNew
                  context:(__bridge void * _Nullable)(self)];
    }
    return self;
}

-(void)dealloc
{
    [self removeObserver:self
              forKeyPath:@"bounds"
                 context:(__bridge void * _Nullable)(self)];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context
{
    if(context == (__bridge void * _Nullable)(self) && object == self && [keyPath isEqualToString:@"bounds"])
    {
        self.layer.cornerRadius = self.bounds.size.height/2;
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.currentBackgroundColor = self.originalBackgroundColor = self.backgroundColor;
    self.enabled = self.enabled;
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if(highlighted)
    {
        self.backgroundColor = self.highlightedBackgroundColor;
    }else
    {
        self.backgroundColor = self.currentBackgroundColor;
    }
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if(enabled)
    {
        self.backgroundColor = self.originalBackgroundColor;
    }else
    {
        self.backgroundColor = self.disabledBackgroundColor;
    }
    self.currentBackgroundColor = self.backgroundColor;
}

@end
