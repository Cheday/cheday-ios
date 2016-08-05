//
//  ProfileNameAndPhotoViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 28.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ProfileNameAndPhotoViewController.h"
@import AFNetworking;

@interface ProfileNameAndPhotoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation ProfileNameAndPhotoViewController

-(void)setUser:(User *)user
{
    _user = user;
    if(self.isViewLoaded)
    {
        [self setUserToView];
    }
}

-(void) setUserToView
{
    self.nameLabel.text = self.user.fullName;
    
    [self.photoImageView setImageWithURL:[NSURL URLWithString:self.user.photoURLString]
                        placeholderImage:[UIImage imageNamed:@"ProfilePirate"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUserToView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
