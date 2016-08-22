//
//  CDRoundedButton.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "RoundedButton.h"

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


@end
