//
//  EditShippingAddress.h
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditShippingAddress : BaseClass<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txtFullName;
    __weak IBOutlet UITextField *txtMobile;
    __weak IBOutlet UITextField *txtPincode;
    __weak IBOutlet UITextField *txtFlatNo;
    __weak IBOutlet UITextField *txtColonyStreet;
    __weak IBOutlet UITextField *txtLandmark;
    __weak IBOutlet UITextField *txtCity;
    __weak IBOutlet UITextField *txtState;
    IBOutletCollection(UITextField) NSArray *allTxtFields;
//    NSMutableDictionary *dictDeliveryAddress;
    

}
@property(nonatomic,strong)NSMutableDictionary *dictDeliveryAddress;
@property(assign)BOOL *toEdit;


- (IBAction)ContinueAction:(id)sender;
- (IBAction)BackAction:(id)sender;
//- (IBAction)SearchProductAction:(id)sender;
//- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;


@end
