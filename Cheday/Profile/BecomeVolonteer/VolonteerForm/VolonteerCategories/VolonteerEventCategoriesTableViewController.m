//
//  VolonteerEventCategoriesTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 11.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerEventCategoriesTableViewController.h"
#import "VolonteerEventCategoryTableViewCell.h"
#import "EventCategory+Selected.h"

@interface VolonteerEventCategoriesTableViewController ()

@end

@implementation VolonteerEventCategoriesTableViewController

-(PFQuery *)query
{
    return [EventCategory query];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VolonteerEventCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VolonteerEventCategoryTableViewCell"
                                                            forIndexPath:indexPath];
    cell.eventCategory = _objects[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCategory *eventCategory = _objects[indexPath.row];
    eventCategory.selected = YES;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCategory *eventCategory = _objects[indexPath.row];
    eventCategory.selected = NO;
}




@end
