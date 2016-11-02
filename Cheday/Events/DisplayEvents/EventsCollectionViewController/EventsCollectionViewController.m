//
//  EventsCollectionViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 11.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventsCollectionViewController.h"
#import "EventCollectionViewCell.h"
#import "SimpleAlertController.h"
#import "EventVCProtocol.h"

@interface EventsCollectionViewController ()

@property(nonatomic, strong) NSArray *objects;
@property(nonatomic, strong) PFQuery *currentQuery;

@end

@implementation EventsCollectionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshContent];
}

-(void)refreshContent
{
    self.currentQuery = [Event query];
    
    self.currentQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [self.currentQuery includeKey:@"owner"];
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
            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    }];
}

-(void)dealloc
{
    [self.currentQuery cancel];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"EventsCollectionShowEventForOwner"] ||
       [segue.identifier isEqualToString:@"EventsCollectionShowEventForVolonteer"])
    {
        NSIndexPath *selectedIndexPath = self.collectionView.indexPathsForSelectedItems.firstObject;
        Event *event = self.objects[selectedIndexPath.item];
        UIViewController<EventVCProtocol> *vc = segue.destinationViewController;
        vc.event = event;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCollectionViewCell" forIndexPath:indexPath];
    cell.event = self.objects[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Event *event = self.objects[indexPath.row];
    if([event.owner isEqual:[User currentUser]])
    {
        [self performSegueWithIdentifier:@"EventsCollectionShowEventForOwner"
                                  sender:self];
    }else
    {
        [self performSegueWithIdentifier:@"EventsCollectionShowEventForVolonteer"
                                  sender:self];
    }
}

@end
