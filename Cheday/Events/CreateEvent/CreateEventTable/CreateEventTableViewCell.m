//
//  CreateEventTableViewCell.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 30.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventTableViewCell.h"

@interface CreateEventTableViewCell ()

@property(nonatomic, strong) NSString *placeholderText;
@property(nonatomic, strong) UIColor *placeholderTextColor;
@property(nonatomic, strong) UIColor *iconImageViewOriginalTintColor;

@property(nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property(nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation CreateEventTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.placeholderText = self.titleLabel.text;
    self.placeholderTextColor = self.titleLabel.textColor;
    self.iconImageViewOriginalTintColor = self.iconImageView.tintColor;
}

-(void)setFilledString:(NSString *)filledString
{
    _filledString = filledString;
    if(_filledString)
    {
        self.titleLabel.text = _filledString;
        self.titleLabel.textColor = [UIColor blackColor];
        self.iconImageView.tintColor = [UIColor colorWithRed:0.31
                                                       green:0.57
                                                        blue:0.87
                                                       alpha:1.00];
    }else
    {
        self.titleLabel.text = self.placeholderText;
        self.titleLabel.textColor = self.placeholderTextColor;
        self.iconImageView.tintColor = self.iconImageViewOriginalTintColor;
    }
}

@end
