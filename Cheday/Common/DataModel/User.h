//
//  User.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 26.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser
<PFSubclassing>

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong, readonly) NSString *fullName;
@property(nonatomic, strong, readonly) NSString *photoURLString;

@property(nonatomic, strong) NSString *twitterID;
@property(nonatomic, strong) NSString *twitterName;
@property(nonatomic, strong) NSString *twitterPhotoURLString;

@property(nonatomic, strong) NSString *facebookID;
@property(nonatomic, strong) NSString *facebookName;
@property(nonatomic, strong) NSString *facebookPhotoURLString;

@property(nonatomic, strong) NSNumber *wantToVolonteer;
@property(nonatomic, strong) NSArray *preferredEventCategories;
@property(nonatomic, strong) NSArray *preferredVolonteerRoles;
@property(nonatomic, strong) NSArray *preferredVolonteerDays;

@end
