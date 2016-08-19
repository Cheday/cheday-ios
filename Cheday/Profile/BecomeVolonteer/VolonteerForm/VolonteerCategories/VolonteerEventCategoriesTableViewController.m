//
//  VolonteerEventCategoriesTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 11.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerEventCategoriesTableViewController.h"
#import "EventCategory+Selecting.h"

@interface VolonteerEventCategoriesTableViewController ()

@end

@implementation VolonteerEventCategoriesTableViewController

-(PFQuery *)query
{
    return [EventCategory query];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    EventCategory *category = _objects[indexPath.row];
    cell.textLabel.text = category.name;
    return cell;
}

@end
