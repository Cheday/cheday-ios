//
//  VolonteerAbstractChooseTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 12.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerAbstractChooseTableViewController.h"
#import "UIAlertController+SimpleAlert.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
extern DDLogLevel ddLogLevel;

@interface VolonteerAbstractChooseTableViewController ()

@property(nonatomic, strong) PFQuery *currentQuery;
@property(nonatomic, strong) NSArray *objects;

-(IBAction)onRefresh:(id)sender;

@end

@implementation VolonteerAbstractChooseTableViewController

-(NSMutableSet *)selectedObjects
{
    return [_selectedObjects mutableCopy];
}

-(void)setSelectedObjects:(NSMutableSet *)selectedObjects
{
    _selectedObjects = [selectedObjects mutableCopy];
    [_selectedObjects enumerateObjectsUsingBlock:^(id<Selecting>  _Nonnull obj, BOOL * _Nonnull stop) {
        obj.selected = YES;
    }];
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
    self.currentQuery = [self query];
    
    self.currentQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    __block int refreshingCount;
    if(self.currentQuery.cachePolicy == kPFCachePolicyCacheThenNetwork)
    {
        refreshingCount = 2;
    }else
    {
        refreshingCount = 1;
    }
    __weak __typeof(self) weakSelf = self;
    [self.currentQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        refreshingCount--;
        if(refreshingCount == 0)
        {
            [weakSelf.refreshControl endRefreshing];
            [weakSelf performSelector:@selector(setRefreshControl:)
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
                                            fromViewController:weakSelf];
        }else
        {
            NSMutableArray *newObjects = [objects mutableCopy];
            //Заменяем пришедшие объекты, ранее выбранными.
            [weakSelf.selectedObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSUInteger index = [newObjects indexOfObject:obj];
                if(index != NSNotFound)
                {
                    [newObjects replaceObjectAtIndex:index
                                          withObject:obj];
                }else
                {
                    DDLogWarn(@"Selected objects contain object which not recieved from server");
                    //TODO: Подумать, что делать если выбранный объект больше не приходит с сервера
                }
            }];
            weakSelf.objects = [newObjects copy];
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        if(refreshingCount == 0)
        {
            //Analytics will be here
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
    [self willChangeValueForKey:@"selectedObjects"];
    id<Selecting> selectedObject = _objects[indexPath.row];
    
    if(selectedObject.selected)
    {
        selectedObject.selected = NO;
        [_selectedObjects removeObject:selectedObject];
        [self.delegate chooseTableViewController:self didDeselectObject:selectedObject];
    }else
    {
        selectedObject.selected = YES;
        [_selectedObjects addObject:selectedObject];
        [self.delegate chooseTableViewController:self didSelectObject:selectedObject];
    }
    [self didChangeValueForKey:@"selectedObjects"];
}

@end
