//
//  VolonteerAbstractChooseTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 12.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerAbstractChooseTableViewController.h"
#import "UIAlertController+SimpleAlert.h"
#import "EqualityProxyFactory.h"

@interface VolonteerAbstractChooseTableViewController ()

@property(nonatomic, strong) NSMutableSet *equalityProxiesForSelectedObjects;;
@property(nonatomic, strong) EqualityProxyFactory *equalityProxyFactory;

-(IBAction)onRefresh:(id)sender;

@end

@implementation VolonteerAbstractChooseTableViewController

-(NSSet *)selectedObjects
{
    if(_selectedObjects == nil)
    {
        _selectedObjects = [NSMutableSet new];
    }
    return _selectedObjects;
}

-(NSMutableSet *)equalityProxiesForSelectedObjects
{
    if(_equalityProxiesForSelectedObjects == nil)
    {
        _equalityProxiesForSelectedObjects = [NSMutableSet new];
    }
    return _equalityProxiesForSelectedObjects;
}

-(void)setSelectedObjects:(NSMutableSet *)selectedObjects
{
    _selectedObjects = selectedObjects;
    self.equalityProxiesForSelectedObjects = [NSMutableSet setWithArray:[self.equalityProxyFactory proxyArrayForObjectsArray:selectedObjects.allObjects]];
}

-(EqualityProxyFactory *)equalityProxyFactory
{
    if(_equalityProxyFactory == nil)
    {
        _equalityProxyFactory = [EqualityProxyFactory new];
    }
    return _equalityProxyFactory;
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
    [PFObject fetchAllIfNeededInBackground:self.selectedObjects.allObjects
                                     block:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                                        [self onRefresh:nil]; 
                                     }];
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
                obj.selected = [self.equalityProxiesForSelectedObjects containsObject:[self.equalityProxyFactory proxyForObject:obj]];
            }];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

-(void)volonteerChooseTableViewCellDidDeselectCheckbox:(VolonteerChooseTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id<Selecting> selectedObject = _objects[indexPath.row];
    id selectedProxy = [self.equalityProxyFactory proxyForObject:selectedObject];
    if([self.equalityProxiesForSelectedObjects containsObject:selectedProxy] == NO)
    {
        selectedObject.selected = YES;
        [self.equalityProxiesForSelectedObjects addObject:[self.equalityProxyFactory proxyForObject:selectedObject]];
        [self.selectedObjects addObject:selectedObject];
    }else
    {
        selectedObject.selected = NO;
        id<EqualityProxyProtocol> savedProxy = [self.equalityProxiesForSelectedObjects member:selectedProxy];
        [self.equalityProxiesForSelectedObjects removeObject:savedProxy];
        [self.selectedObjects removeObject:savedProxy.instance];
    }
}

@end
