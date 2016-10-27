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

@property (weak, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actionButtonActivityIndicator;
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
    
    [self.ownerImageView setImageWithURL:[NSURL URLWithString:_event.owner.photoURLString]
                        placeholderImage:[UIImage imageNamed:@"ProfilePirate"]];
    self.ownerNameLabel.text = _event.owner.fullName;
    
    if([_event.owner isEqual:[User currentUser]])
    {
        [self.actionButton setTitle:NSLocalizedString(@"ЗАВЕРШИТЬ МЕРОПРИЯТИЕ", nil)
                           forState:UIControlStateNormal];
    }else
    {
        [self.actionButton setTitle:NSLocalizedString(@"ХОЧУ УЧАСТВОВАТЬ", nil)
                           forState:UIControlStateNormal];
    }
}

@end
