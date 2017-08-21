//
//  EditShippingAddress.h
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditShippingAddress : UIViewController
{
    __weak IBOutlet UITextField *txtFullName;
    __weak IBOutlet UITextField *txtMobile;
    __weak IBOutlet UITextField *txtPincode;
    __weak IBOutlet UITextField *txtFlatNo;
    __weak IBOutlet UITextField *txtColonyStreet;
    __weak IBOutlet UITextField *txtLandmark;
    __weak IBOutlet UITextField *txtCity;
    __weak IBOutlet UITextField *txtState;
    
    

}
- (IBAction)ContinueAction:(id)sender;



@end
