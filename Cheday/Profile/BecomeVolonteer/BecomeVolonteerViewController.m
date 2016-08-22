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

@interface BecomeVolonteerViewController ()
<BEMCheckBoxDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet BEMCheckBox *iWantBeVolonteerSwitch;
@property (weak, nonatomic) VolonteerFormTableViewController *volonteerFormViewController;

@end

@implementation BecomeVolonteerViewController

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
//    [self.photoImageView setImageWithURL:[NSURL URLWithString:self.user.photoURLString]
//                        placeholderImage:[UIImage imageNamed:@"ProfilePirate"]];
    [self.photoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.user.photoURLString]]
                               placeholderImage:[UIImage imageNamed:@"ProfilePirate"]
                                        success:nil
                                        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                            DDLogError(@"%@", error);
                                        }];
    if(self.user.wantToVolonteer)
    {
        self.iWantBeVolonteerSwitch.on = [self.user.wantToVolonteer boolValue];
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
    self.user.wantToVolonteer = @(self.iWantBeVolonteerSwitch.on);
    self.user.preferredEventCategories = self.volonteerFormViewController.selectedPreferredEventCategories.allObjects;
    self.user.preferredVolonteerRoles = self.volonteerFormViewController.selectedPreferredVolonteerRoles.allObjects;
    self.user.preferredVolonteerDays = self.volonteerFormViewController.selectedPreferredDates.allObjects;
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            [self performSegueWithIdentifier:@"BecomeVolonteerUnwind" sender:self];
        }else
        {
            [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                       message:error.localizedDescription
                                            fromViewController:self];
        }
    }];
}

@end
