//
//  VolonteerFormTableView.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 10.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerFormTableView.h"

@interface VolonteerFormTableView ()



@end

@implementation VolonteerFormTableView

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect frame = self.tableHeaderView.frame;
    if(ABS(frame.size.height - size.height)>FLT_EPSILON)
    {
        frame.size = size;
        self.tableHeaderView.frame = frame;
        //reset header view to not everlap with first cell
        self.tableHeaderView = self.tableHeaderView;
    }
}

@end
