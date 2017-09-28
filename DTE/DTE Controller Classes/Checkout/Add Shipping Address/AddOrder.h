//
//  AddOrder.h
//  DTE
//
//  Created by Divya Jain on 9/20/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "FPPopoverTableController.h"

@interface AddOrder : BaseClass
{
    __weak IBOutlet UITextField *txtShippingFirstName;
    __weak IBOutlet UITextField *txtShippingLastName;
    __weak IBOutlet UITextField *txtShippingEmail;
    __weak IBOutlet UITextField *txtShippingAddress1;
    __weak IBOutlet UITextField *txtShippingAddress2;
    __weak IBOutlet UITextField *txtShippingCity;
    __weak IBOutlet UITextField *txtShippingState;
    __weak IBOutlet UITextField *txtShippingZip;
    __weak IBOutlet UITextField *txtShippingMobile;

    __weak IBOutlet UITextField *txtBillingFirstName;
    __weak IBOutlet UITextField *txtBillingLastName;
    __weak IBOutlet UITextField *txtBillingEmail;
    __weak IBOutlet UITextField *txtBillingAddress1;
    __weak IBOutlet UITextField *txtBillingAddress2;
    __weak IBOutlet UITextField *txtBillingCity;
    __weak IBOutlet UITextField *txtBillingState;
    __weak IBOutlet UITextField *txtBillingZip;
    __weak IBOutlet UITextField *txtBillingMobile;

    __weak IBOutlet UIButton *btnSameAdShippingAdd;
    
    IBOutletCollection(UITextField) NSArray *allTxtFields;

    FPPopoverController *popoverStateList;
    BOOL isStateBillingTapped;
    BOOL isBillingsame;
    NSMutableArray* arrStateList;

}
- (IBAction)BackAction:(id)sender;
- (IBAction)BillingSelectStateAction:(id)sender;
- (IBAction)ShippingSelectStateAction:(id)sender;
- (IBAction)SameAsShippingAddAction:(id)sender;
- (IBAction)AddOrderAction:(id)sender;



@end
