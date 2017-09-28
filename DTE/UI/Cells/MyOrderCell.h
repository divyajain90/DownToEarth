//
//  MyOrderCell.h
//  DTE
//
//  Created by Divya Jain on 9/25/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblOrderDate;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderID;

@end
