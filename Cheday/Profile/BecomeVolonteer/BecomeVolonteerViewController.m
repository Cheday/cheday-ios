//
//  BecomeVolonteerViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 08.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "BecomeVolonteerViewController.h"
#import "BEMCheckBox/BEMCheckBox.h"
@import AFNetworking;
@import CocoaLumberjack;
extern DDLogLevel ddLogLevel;
#import "VolonteerForm/VolonteerFormTableViewController.h"
#import "UIAlertController+SimpleAlert.h"
#import "User.h"

@interface BecomeVolonteerViewController ()
<BEMCheckBoxDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet BEMCheckBox *iWantBeVolonteerSwitch;
@property (weak, nonatomic) VolonteerFormTableViewController *volonteerFormViewController;

@end

@implementation BecomeVolonteerViewController

-(void) setUserToView
{
    User *user = [User currentUser];
    self.nameLabel.text = user.fullName;
//    [self.photoImageView setImageWithURL:[NSURL URLWithString:self.user.photoURLString]
//                        placeholderImage:[UIImage imageNamed:@"ProfilePirate"]];
    [self.photoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:user.photoURLString]]
                               placeholderImage:[UIImage imageNamed:@"ProfilePirate"]
                                        success:nil
                                        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                            DDLogError(@"%@", error);
                                        }];
    if(user.wantToVolonteer)
    {
        self.iWantBeVolonteerSwitch.on = [user.wantToVolonteer boolValue];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iWantBeVolonteerSwitch.onAnimationType = BEMAnimationTypeBounce;
    self.iWantBeVolonteerSwitch.offAnimationType = BEMAnimationTypeBounce;
    
    [self setUserToView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"BecomeVolonteerEmbedVolonteerForm"])
    {
        self.volonteerFormViewController = segue.destinationViewController;
    }
}

-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    //self.user.wantToVolonteer = @(checkBox.on);
}

- (IBAction)onSave:(UIButton *)sender {
    User *user = [User currentUser];
    user.wantToVolonteer = @(self.iWantBeVolonteerSwitch.on);
    user.preferredEventCategories = self.volonteerFormViewController.selectedPreferredEventCategories.allObjects;
    user.preferredVolonteerRoles = self.volonteerFormViewController.selectedPreferredVolonteerRoles.allObjects;
    user.preferredVolonteerDays = self.volonteerFormViewController.selectedPreferredDates.allObjects;
    DDLogDebug(@"Save user: %@", user);
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            [self performSegueWithIdentifier:@"BecomeVolonteerUnwind" sender:self];
            DDLogDebug(@"User saved");
        }else
        {
            [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                       message:error.localizedDescription
                                            fromViewController:self];
        }
    }];
}

@end
