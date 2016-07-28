//
//  RoundImageView.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 28.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "RoundImageView.h"

@implementation RoundImageView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.masksToBounds = YES;
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
        self.layer.cornerRadius = MIN(self.bounds.size.height, self.bounds.size.width)/2;
    }
}

@end
