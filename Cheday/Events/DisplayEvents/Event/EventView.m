//
//  EventView.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 20.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventView.h"
#import <AFNetworking/AFNetworking.h>

@interface EventView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdLabel;

@end

@implementation EventView

-(void)setEvent:(Event *)event
{
    _event = event;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:_event.image.url]];
    self.eventNameLabel.text = _event.title;
    if([_event.category isDataAvailable])
    {
        self.categoryLabel.text = _event.category.name;
    }
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:_event.startDate
                                                         dateStyle:NSDateFormatterMediumStyle
                                                         timeStyle:NSDateFormatterShortStyle];
    self.detailsLabel.text = _event.details;
    NSString *formattedCreateDateString = [NSDateFormatter localizedStringFromDate:_event.createdAt
                                                                         dateStyle:NSDateFormatterMediumStyle
                                                                         timeStyle:NSDateFormatterShortStyle];
    self.createdLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Создано:", nil), formattedCreateDateString];
}

@end
