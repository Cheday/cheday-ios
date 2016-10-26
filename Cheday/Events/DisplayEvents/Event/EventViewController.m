//
//  EventViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 19.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventViewController.h"
#import "EventView.h"

@interface EventViewController ()

@property(nonatomic, strong) EventView *view;

@end

@implementation EventViewController

@dynamic view;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.event = self.event;
    [PFObject fetchAllIfNeededInBackground:@[self.event.category]
                                     block:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                                         self.view.event = self.event;
                                     }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)phoneButtonTouchUpInside:(UIButton *)sender {
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
