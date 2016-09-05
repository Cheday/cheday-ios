//
//  CreateEventChooseVolonteerRolesTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 31.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventChooseVolonteerRolesTableViewController.h"
#import "CreateEventChooseVolonteerRolesTableViewCell.h"

@interface CreateEventChooseVolonteerRolesTableViewController ()
<CreateEventChooseVolonteerRolesTableViewCellDelegate>

@end

@implementation CreateEventChooseVolonteerRolesTableViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateEventChooseVolonteerRolesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreateEventChooseVolonteerRoleTableViewCell" forIndexPath:indexPath];
    cell.volonteerRole = _objects[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)createEventChooseVolonteerRolesTableViewCell:(CreateEventChooseVolonteerRolesTableViewCell *)cell didChangeVolonteerCount:(NSInteger)count
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    VolonteerRole *volonteerRole = _objects[indexPath.row];
    NSInteger oldCount = volonteerRole.count;
    volonteerRole.count = count;
    if((oldCount == 0) && (volonteerRole.count > 0))
    {
        [self.delegate chooseTableViewController:self didSelectObject:volonteerRole];
    }
    if(count == 0)
    {
        [self.delegate chooseTableViewController:self didDeselectObject:volonteerRole];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
