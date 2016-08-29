//
//  CreateEventChooseCategoryTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 29.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventChooseCategoryTableViewController.h"
#import "EventCategory.h"

@interface CreateEventChooseCategoryTableViewController ()

@end

@implementation CreateEventChooseCategoryTableViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreateEventChooseCategoryTableViewCell"
                                                            forIndexPath:indexPath];
    EventCategory *category = _objects[indexPath.row];
    cell.textLabel.text = category.name;
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedObjects addObject:_objects[indexPath.row]];
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    

}

@end
