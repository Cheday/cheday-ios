//
//  EventCollectionViewCell.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 13.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) Event *event;

@end
