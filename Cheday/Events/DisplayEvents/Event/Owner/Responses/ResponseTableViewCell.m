//
//  ResponseTableViewCell.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 08.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ResponseTableViewCell.h"
#import <AFNetworking/AFNetworking.h>

@interface ResponseTableViewCell ()

@property(nonatomic, weak) IBOutlet UIImageView *userImageView;
@property(nonatomic, weak) IBOutlet UILabel *userFullNameLabel;
@property(nonatomic, weak) IBOutlet UIButton *assignButton;

@end

@implementation ResponseTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //self.assignButton.layer.cornerRadius = 8.0;
}

-(void)setEventParticipation:(EventParticipation *)eventParticipation
{
    _eventParticipation = eventParticipation;
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:_eventParticipation.user.photoURLString]
                       placeholderImage:[UIImage imageNamed:@"ProfilePirate"]];
    self.userFullNameLabel.text = _eventParticipation.user.fullName;
    
}

-(IBAction)assignButtonTouchUpInside:(id)sender
{
    [self.delegate responseTableViewCellAssignButtonTap:self];
}

@end
