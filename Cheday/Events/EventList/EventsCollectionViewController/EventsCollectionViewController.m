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

@interface EventsCollectionViewController ()

@property(nonatomic, strong) NSArray *objects;
@property(nonatomic, strong) PFQuery *currentQuery;

@end

@implementation EventsCollectionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
