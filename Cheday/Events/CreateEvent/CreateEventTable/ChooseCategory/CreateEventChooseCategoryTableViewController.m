//
//  CreateEventChooseCategoryTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 29.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventChooseCategoryTableViewController.h"
#import "EventCategory.h"
#import "EventCategory+Selecting.h"

@interface CreateEventChooseCategoryTableViewController ()

@end

@implementation CreateEventChooseCategoryTableViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreateEventChooseCategoryTableViewCell"
                                                            forIndexPath:indexPath];
    EventCategory *category = _objects[indexPath.row];
    cell.textLabel.text = category.name;
    if(category.selected)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{    
    [self.delegate chooseTableViewController:self didSelectObject:_objects[indexPath.row]];
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
