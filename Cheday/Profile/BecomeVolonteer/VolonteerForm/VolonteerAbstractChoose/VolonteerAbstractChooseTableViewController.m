//
//  VolonteerAbstractChooseTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 12.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerAbstractChooseTableViewController.h"
#import "UIAlertController+SimpleAlert.h"

@implementation VolonteerAbstractChooseTableViewController

-(NSSet *)selectedObjects
{
    if(_selectedObjects == nil)
    {
        @synchronized (self) {
            if(_selectedObjects == nil)
            {
                _selectedObjects = [NSMutableSet new];
            }
        }
    }
    return _selectedObjects;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self refreshData];
}

-(void) refreshData
{
    [self.refreshControl beginRefreshing];
    [self onRefresh:nil];
}

-(PFQuery *)query
{
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"You should override -query method"
                                 userInfo:nil];
}

-(void)onRefresh:(id)sender
{
    PFQuery *query = [self query];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    __block int refreshingCount;
    if(query.cachePolicy == kPFCachePolicyCacheThenNetwork)
    {
        refreshingCount = 2;
    }else
    {
        refreshingCount = 1;
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        refreshingCount--;
        if(refreshingCount == 0)
        {
            [self.refreshControl endRefreshing];
            [self performSelector:@selector(setRefreshControl:)
                       withObject:nil
                       afterDelay:0];
        }
        if(error)
        {
            if(error.code == kPFErrorCacheMiss)
            {
                return;
            }
            [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                       message:error.localizedDescription
                                            fromViewController:self];
        }else
        {
            _objects = objects;
            [_objects enumerateObjectsUsingBlock:^(id<Selecting>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.selected = [self.selectedObjects containsObject:obj];
            }];
            [self.tableView reloadData];    
        }
        
        if(refreshingCount == 0)
        {
            //Analytics will be here
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VolonteerChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VolonteerChooseTableViewCell"
                                                                                forIndexPath:indexPath];
    cell.selectableObject = _objects[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)volonteerChooseTableViewCellDidSelectCheckbox:(VolonteerChooseTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

-(void)volonteerChooseTableViewCellDidDeselectCheckbox:(VolonteerChooseTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self tableView:self.tableView didDeselectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<Selecting> selectableObject = _objects[indexPath.row];
    selectableObject.selected = YES;
    [self.selectedObjects addObject:selectableObject];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<Selecting> selectableObject = _objects[indexPath.row];
    selectableObject.selected = NO;
    [self.selectedObjects removeObject:selectableObject];
}

@end
