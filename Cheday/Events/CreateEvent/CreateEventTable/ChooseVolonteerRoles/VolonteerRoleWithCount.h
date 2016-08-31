//
//  VolonteerRoleWithCount.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 31.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolonteerRole.h"

@interface VolonteerRoleWithCount : NSObject

@property(nonatomic, strong) VolonteerRole *volonteerRole;
@property(nonatomic) NSInteger count;

//-(NSDictionary*) dictionaryRepresentation;

@end
