//
//  CreateEventChooseVolonteerRolesTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 31.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventChooseVolonteerRolesTableViewController.h"
#import "CreateEventChooseVolonteerRolesTableViewCell.h"
#import "VolonteerRole.h"

@interface CreateEventChooseVolonteerRolesTableViewController ()

@end

@implementation CreateEventChooseVolonteerRolesTableViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateEventChooseVolonteerRolesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreateEventChooseVolonteerRoleTableViewCell"
                                                            forIndexPath:indexPath];
    cell.volonteerRole = _objects[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
