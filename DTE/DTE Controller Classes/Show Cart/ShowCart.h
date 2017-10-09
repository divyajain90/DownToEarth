//
//  ShowCart.h
//  DTE
//
//  Created by Divya Jain on 21/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowCart : BaseClass<UITableViewDelegate,UITableViewDataSource>
{

    __weak IBOutlet NSLayoutConstraint *constCheckoutTop;
    __weak IBOutlet UITableView *tblCartItems;
    __weak IBOutlet UIButton *btnCheckout;
    
    __weak IBOutlet UIButton *btnApplyCoupon;
    __weak IBOutlet UILabel *lblDiscount;
    __weak IBOutlet BadgeButton *btnCart;
    NSMutableArray *arrCartItems;
    NSString *strSubTotal;

    __weak IBOutlet UITextField *txtCouponCode;
    __weak IBOutlet UILabel *lblTotalPrice;
}

- (IBAction)CheckoutAction:(id)sender;
- (IBAction)BackAction:(id)sender;
- (IBAction)SearchProductAction:(id)sender;
- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;
- (IBAction)ApplyAction:(id)sender;

@end
