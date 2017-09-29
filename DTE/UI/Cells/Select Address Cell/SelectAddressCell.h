//
//  SelectAddressCell.h
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress1;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress2;
@property (weak, nonatomic) IBOutlet UILabel *lblCity_State_Postal;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnDeliver;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnEditAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteAddress;

@property (weak, nonatomic) IBOutlet UIView *vwDeliver;


@end
