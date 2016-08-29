//
//  VolonteerChooseDatesTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerChooseDatesTableViewController.h"
#import "WeekDay.h"

@implementation VolonteerChooseDatesTableViewController

-(PFQuery *)query
{
    return [WeekDay query];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    WeekDay *weekDay = _objects[indexPath.row];
    cell.textLabel.text = weekDay.name;
    return cell;
}

@end
