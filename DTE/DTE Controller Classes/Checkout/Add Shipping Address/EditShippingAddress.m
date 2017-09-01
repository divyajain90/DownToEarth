//
//  EditShippingAddress.m
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "EditShippingAddress.h"
#import "SelectShippingAddress.h"
@interface EditShippingAddress ()

@end

@implementation EditShippingAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Misc

-(void)initUI
{
    [self.navigationController setNavigationBarHidden:YES];
    for (UITextField*txt in allTxtFields) {
        [self setUIForTextBox:txt];
        
    }
    if (self.toEdit) {
        [self updateUI];
    }

}


-(void)updateUI
{
    txtFullName.text = self.dictDeliveryAddress[@"FullName"];
    txtFlatNo.text = self.dictDeliveryAddress[@"AddressLine1"];
    txtColonyStreet.text = self.dictDeliveryAddress[@"AddressLine2"];
    txtCity.text = self.dictDeliveryAddress[@"City"];
    txtState.text = self.dictDeliveryAddress[@"State"];
    txtMobile.text = self.dictDeliveryAddress[@"Mobile"];
    txtLandmark.text = self.dictDeliveryAddress[@"Landmark"];
    txtPincode.text = self.dictDeliveryAddress[@"Postal"];

}

- (IBAction)BackAction:(id)sender
{
    if (self.toEdit) {
    
    
        GO_BACK;

    }
    else
    GO_BACK;
}

#pragma mark - TextField delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (textField != txtMobile) {
        
        return newLength <= 10;
    }
    else
        return 254;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        for (UITextField *tf in allTxtFields) {
            [tf resignFirstResponder];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtFullName) {
        [txtMobile becomeFirstResponder];
    }
    else if (textField == txtMobile) {
        [txtPincode becomeFirstResponder];
    }
    else if (textField == txtPincode) {
        [txtFlatNo becomeFirstResponder];
    }
    else if (textField == txtFlatNo) {
        [txtColonyStreet becomeFirstResponder];
    }
    else if (textField == txtColonyStreet) {
        [txtLandmark becomeFirstResponder];
    }
    else if (textField == txtLandmark) {
        [txtCity becomeFirstResponder];
    }
    else if (textField == txtCity) {
        [txtState becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)setUIForTextBox: (UITextField*)text
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    text.leftView = paddingView;
    text.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)hideKeyboard
{
    for (UITextField *text in allTxtFields) {
        if ([text isFirstResponder]) {
            [text resignFirstResponder];
        }
    }
    
}


- (IBAction)ContinueAction:(id)sender {
    
    self.dictDeliveryAddress = [[NSMutableDictionary alloc] init];
//    dictDeliveryAddress[@"FullName"] = txtFullName.text;
//    dictDeliveryAddress[@"AddressLine1"] = txtFlatNo.text;
//    dictDeliveryAddress[@"AddressLine2"] = txtColonyStreet.text;
//    dictDeliveryAddress[@"City"] = [NSString stringWithFormat:@"%@, %@ %@",txtCity.text,txtState.text,txtPincode];
//    dictDeliveryAddress[@"Country"] = @"India";
    
    self.dictDeliveryAddress[@"FullName"] = @"Veerendra";
    self.dictDeliveryAddress[@"AddressLine1"] = @"E-703";
    self.dictDeliveryAddress[@"AddressLine2"] = @"Greenzone";
    self.dictDeliveryAddress[@"City"] = @"Pune";
    self.dictDeliveryAddress[@"State"] = @"Maharashtra";
    self.dictDeliveryAddress[@"Postal"] = @"411007";

    self.dictDeliveryAddress[@"Country"] = @"India";
    self.dictDeliveryAddress[@"Mobile"] = @"9860697457";
    self.dictDeliveryAddress[@"Landmark"] = @"";

//   [User sharedUser]
    
    [self performSegueWithIdentifier:@"SelectAddressSegue" sender:self.dictDeliveryAddress];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SelectShippingAddress *vc = segue.destinationViewController;

    vc.dictDeliveryAddress = sender;
}

- (IBAction)SettingsAction:(id)sender;
{

}

@end
