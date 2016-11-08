//
//  ResponsesTableViewController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 04.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventVCProtocol.h"

@interface ResponsesTableViewController : UITableViewController
<EventVCProtocol>

@property(nonatomic, strong) Event *event;

@end
