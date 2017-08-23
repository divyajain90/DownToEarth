//
//  EditShippingAddress.m
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "EditShippingAddress.h"

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
}

- (IBAction)BackAction:(id)sender
{
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
}
@end
