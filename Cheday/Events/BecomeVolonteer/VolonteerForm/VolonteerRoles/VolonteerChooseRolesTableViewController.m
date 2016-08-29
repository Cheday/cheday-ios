//
//  VolonteerRolesChooseTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 19.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerChooseRolesTableViewController.h"
#import "VolonteerRole.h"

@implementation VolonteerChooseRolesTableViewController

-(PFQuery *)query
{
    return [VolonteerRole query];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    VolonteerRole *role = _objects[indexPath.row];
    cell.textLabel.text = role.name;
    return cell;
}

@end
