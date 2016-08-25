//
//  VolonteerRoleEqualityProxy.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 23.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolonteerRole.h"
#import "EqualityProxyProtocol.h"

@interface VolonteerRoleEqualityProxy : NSProxy
<EqualityProxyProtocol>
{
    VolonteerRole *_instance;
}

@property(nonatomic, strong, readonly) id instance;

-(instancetype) initWithVolonteerRole:(VolonteerRole*)volonteerRole;
+(instancetype) proxyWithVolonteerRole:(VolonteerRole*)volonteerRole;

@end
