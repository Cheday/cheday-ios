//
//  EventVCProtocol.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 02.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@protocol EventVCProtocol <NSObject>

@property(nonatomic, strong) Event *event;

@end
