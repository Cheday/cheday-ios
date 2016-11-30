//
//  ResponsesTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 04.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ResponsesTableViewController.h"
#import "ResponseTableViewCell.h"
#import <Parse/Parse.h>
#import "EventParticipation.h"
#import "SimpleAlertController.h"

@interface ResponsesTableViewController ()
<ResponseTableViewCellDelegate>

@property(nonatomic, strong) NSArray *objects;
@property(nonatomic, strong) PFQuery *currentQuery;

@end

@implementation ResponsesTableViewController

-(void)setEvent:(Event *)event
{
    _event = event;
    
    self.currentQuery = [EventParticipation query];
    [self.currentQuery whereKey:@"event" equalTo:_event];
    self.currentQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [self.currentQuery includeKey:@"user"];
    __weak __typeof(self) weakSelf = self;
    [self.currentQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error)
        {
            if(error.code == kPFErrorCacheMiss)
            {
                return;
            }
            SimpleAlertController *alertController = [SimpleAlertController alertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                                                             message:error.localizedDescription];
            [weakSelf presentViewController:alertController
                                   animated:YES
                                 completion:nil];
        }else
        {
            weakSelf.objects = objects;
            if(weakSelf.isViewLoaded)
            {
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    }];
}

-(void)dealloc
{
    [self.currentQuery cancel];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResponseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResponseTableViewCell" forIndexPath:indexPath];
    
    cell.eventParticipation = self.objects[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)responseTableViewCellAssignButtonTap:(ResponseTableViewCell *)cell
{
    //[self.currentQuery clearCachedResult];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    EventParticipation *eventParticipation = self.objects[indexPath.row];
    eventParticipation.state = kEventParticipationStateAcceptedByOwner;
    __weak __typeof(self) weakSelf = self;
    [eventParticipation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded == NO)
        {
            SimpleAlertController *alertController = [SimpleAlertController alertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                                                             message:error.localizedDescription];
            [weakSelf presentViewController:alertController
                                   animated:YES
                                 completion:nil];
        }
    }];
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
