//
//  SelectAddress.h
//  DTE
//
//  Created by Divya Jain on 9/26/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "FPPopoverTableController.h"

@interface SelectAddress : BaseClass
{
    __weak IBOutlet UITextField *txtShippingAddress;
    __weak IBOutlet UITextField *txtBillingAddress;

    __weak IBOutlet UIButton *btnSelect;
    
    FPPopoverController *popoverStateList;
    BOOL isShippingAddress;
    
    NSMutableArray * arrShippingAddress;
    NSMutableArray * arrBillingAddress;

    __weak IBOutlet UIButton *btnShipping;
    __weak IBOutlet UIButton *btnBilling;


}
- (IBAction)BackAction:(id)sender;
- (IBAction)SelectShippingAddressAction:(id)sender;
- (IBAction)SelectBillingAddress:(id)sender;

- (IBAction)SelectAction:(id)sender;
- (IBAction)AddNewAddressAction:(id)sender;


@end
