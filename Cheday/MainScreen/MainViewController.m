//
//  MainViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 28.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "MainViewController.h"
@import AFNetworking;
@import CocoaLumberjack;
extern DDLogLevel ddLogLevel;
#import "BecomeVolonteerViewController.h"
#import "ContentRefreshing.h"

#import "LoginViewController.h"

@interface MainViewController ()
<LoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *becomeVolonteerButton;
@property (weak, nonatomic) IBOutlet UIButton *createEventButton;

@property(weak, nonatomic) UIViewController<ContentRefreshing> *nearEventsViewController;

@end

@implementation MainViewController

//Temp
- (IBAction)onLogout:(UIBarButtonItem *)sender {
    [User logOutInBackground];
    LoginViewController *authVC = [[UIStoryboard storyboardWithName:@"Authorization" bundle:nil] instantiateInitialViewController];
    authVC.delegate = self;
    [self presentViewController:authVC animated:YES completion:nil];
}

-(void)loginViewControllerDidLogin:(LoginViewController *)loginViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.user = [User currentUser];
}

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserToView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MainShowBecomeVolonteer"])
    {
        /*
        BecomeVolonteerViewController *vc = segue.destinationViewController;
        UINavigationController *navController = segue.destinationViewController;
        vc = navController.viewControllers[0];
        vc.user = self.user;
         */
    }else if([segue.identifier isEqualToString:@"MainEmbedNearEvents"])
    {
        self.nearEventsViewController = segue.destinationViewController;
    }
}

-(IBAction) unwindFromBecomeVolonteerViewController:(UIStoryboardSegue*)segue
{
    
}

-(IBAction) unwindFromCreateEventViewController:(UIStoryboardSegue*)segue
{
    [self.nearEventsViewController refreshContent];
}

@end
