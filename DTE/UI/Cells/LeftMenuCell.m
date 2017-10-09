//
//  LeftMenuCell.m
//  DTE
//
//  Created by Divya Jain on 06/10/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

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
