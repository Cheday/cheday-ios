//
//  ResponseTableViewCell.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 08.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventParticipation.h"

@protocol ResponseTableViewCellDelegate;

@interface ResponseTableViewCell : UITableViewCell

@property(nonatomic, weak) id<ResponseTableViewCellDelegate> delegate;
@property(nonatomic, strong) EventParticipation *eventParticipation;

@end

@protocol ResponseTableViewCellDelegate <NSObject>

-(void) responseTableViewCellAssignButtonTap:(ResponseTableViewCell*)cell;

@end
