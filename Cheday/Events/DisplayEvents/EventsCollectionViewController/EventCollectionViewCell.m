//
//  EventCollectionViewCell.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 13.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>

@interface EventCollectionViewCell ()

@property(nonatomic, weak) IBOutlet UIImageView *imageView;
@property(nonatomic, weak) IBOutlet UILabel *titleLabel;
@property(nonatomic, weak) IBOutlet UILabel *ownerNameLabel;

@end

@implementation EventCollectionViewCell

-(void)setEvent:(Event *)event
{
    _event = event;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:event.image.url] placeholderImage:[UIImage new]];
    self.titleLabel.text = event.title;
    self.ownerNameLabel.text = event.owner.fullName;
}

@end
