//
//  MyOrderCell.m
//  DTE
//
//  Created by Divya Jain on 9/25/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
@end
