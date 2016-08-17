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

@interface BecomeVolonteerViewController ()
<BEMCheckBoxDelegate, VolonteerFormTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet BEMCheckBox *iWantBeVolonteerSwitch;

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
        VolonteerFormTableViewController *volonterFormTVC = segue.destinationViewController;
        volonterFormTVC.delegate = self;
    }
}

-(void)volonteerFromTVCDidSelectCategories:(VolonteerFormTableViewController *)volonteerTVC
{
    [self performSegueWithIdentifier:@"BecomeVolonteerShowChooseCategories" sender:self];
}

-(void)volonteerFromTVCDidSelectRoles:(VolonteerFormTableViewController *)volonteerTVC
{
    [self performSegueWithIdentifier:@"BecomeVolonteerShowChooseRole" sender:self];
}

-(void)volonteerFromTVCDidSelectDates:(VolonteerFormTableViewController *)volonteerTVC
{
    [self performSegueWithIdentifier:@"BecomeVolonteerShowChooseDate" sender:self];
}

-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    self.user.wantToVolonteer = @(checkBox.on);
}

- (IBAction)onSave:(UIButton *)sender {
    
}

@end
