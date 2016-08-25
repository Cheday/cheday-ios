//
//  EventCategoryEqualityProxy.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 23.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventCategory.h"
#import "EqualityProxyProtocol.h"

@interface EventCategoryEqualityProxy : NSProxy
<EqualityProxyProtocol>
{
    EventCategory *_instance;
}

@property(nonatomic, strong, readonly) id instance;

-(instancetype) initWithEventCategory:(EventCategory*)eventCategory;
+(instancetype) proxyWithEventCategory:(EventCategory*)eventCategory;

@end
