//
//  WeekDayEqualityProxy.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 23.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeekDay.h"
#import "EqualityProxyProtocol.h"

@interface WeekDayEqualityProxy : NSProxy
<EqualityProxyProtocol>
{
    WeekDay *_instance;
}

@property(nonatomic, strong, readonly) id instance;

-(instancetype) initWithWeekDay:(WeekDay*)weekDay;
+(instancetype) proxyWithWeekDay:(WeekDay*)weekDay;

@end
