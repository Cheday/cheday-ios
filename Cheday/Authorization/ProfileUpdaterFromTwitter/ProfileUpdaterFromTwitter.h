//
//  ProfileUpdaterFromTwitter.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 04.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ProfileUpdaterFromTwitter : NSObject

+(void) updateUser:(User*)user completion:(void (^)(User* user, NSError* error))completionBlock;

@end
