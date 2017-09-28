//
//  AddOrder.m
//  DTE
//
//  Created by Divya Jain on 9/20/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "AddOrder.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface AddOrder ()<FPPopupViewDelegate>
{
    IBOutlet TPKeyboardAvoidingScrollView *mainScroll;
    NSUInteger selectedBillingIndex;
    NSUInteger selectedShippingIndex;
}

@end

@implementation AddOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrStateList = [[NSMutableArray alloc] init];
    for (int i = 0; i<[[APIManager sharedManager] stateList].count; i++) {
        NSDictionary * dictState = [[APIManager sharedManager] stateList][i];
        [arrStateList addObject:dictState[@"Name"]];
    }
    
    
    for (UITextField*txt in allTxtFields) {
        [self setUIForTextBox:txt];
        
    }
    isStateBillingTapped = NO;
    isBillingsame = NO;
    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
 }

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}

- (IBAction)BillingSelectStateAction:(id)sender {
    isStateBillingTapped = YES;
    if (popoverStateList) {
        popoverStateList = nil;
    }
    //the view controller you want to present as popover
    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
    controller.itemsArr = arrStateList;
    controller.delegate = self;
    
    //our popover
    popoverStateList = [[FPPopoverController alloc] initWithViewController:controller];
    popoverStateList.border = NO;
    popoverStateList.tint = FPPopoverGreenTint;
    
    popoverStateList.contentSize = CGSizeMake(300, 350);
    //the popover will be presented from the okButton view
    [popoverStateList presentPopoverFromView:sender];

}

- (IBAction)ShippingSelectStateAction:(id)sender {
    isStateBillingTapped = NO;
    if (popoverStateList) {
        popoverStateList = nil;
    }
    //the view controller you want to present as popover
    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
    controller.itemsArr = arrStateList;
    controller.delegate = self;
    
    //our popover
    popoverStateList = [[FPPopoverController alloc] initWithViewController:controller];
    popoverStateList.border = NO;
    popoverStateList.tint = FPPopoverGreenTint;
    
    popoverStateList.contentSize = CGSizeMake(300, 350);
    //the popover will be presented from the okButton view
    [popoverStateList presentPopoverFromView:sender];
 
}

- (IBAction)SameAsShippingAddAction:(id)sender {
    isBillingsame = !isBillingsame;
    if (isBillingsame) {
        txtBillingFirstName.text = txtShippingFirstName.text;
        txtBillingLastName.text = txtShippingLastName.text;
        txtBillingEmail.text = txtShippingEmail.text;
        txtBillingCity.text = txtShippingCity.text;
        txtBillingState.text = txtShippingState.text;
        txtBillingAddress1.text = txtShippingAddress1.text;
        txtBillingAddress2.text = txtShippingAddress2.text;
        txtBillingZip.text = txtShippingZip.text;
        txtBillingMobile.text = txtShippingMobile.text;
    }
    else
    {
        txtBillingFirstName.text = @"";
        txtBillingLastName.text = @"";
        txtBillingEmail.text = @"";
        txtBillingCity.text = @"";
        txtBillingState.text = @"";
        txtBillingAddress1.text = @"";
        txtBillingAddress2.text = @"";
        txtBillingZip.text = @"";
        txtBillingMobile.text = @"";

    }
}

- (IBAction)AddOrderAction:(id)sender {
    NSMutableDictionary *orderInfo = [[NSMutableDictionary alloc] init];
    orderInfo[@"AdvanceAmount"] = @"0";

    orderInfo[@"BillingAddressId"] = @"0";
    orderInfo[@"BillingFirstName"]= txtBillingFirstName.text;
    orderInfo[@"BillingLastName"]= txtBillingLastName.text;
    orderInfo[@"BillingEmail"]= txtBillingEmail.text;
    orderInfo[@"BillingAddress1"]= txtBillingAddress1.text;
    orderInfo[@"BillingAddress2"]= txtBillingAddress2.text;
    orderInfo[@"BillingCity"]= txtBillingCity.text;
    NSString *stateProvinceIDBilling = [[APIManager sharedManager] stateList][selectedBillingIndex][@"ID"];
    orderInfo[@"BillingStateProvinceId"]= stateProvinceIDBilling;
    orderInfo[@"BillingZipPostalCode"]= txtBillingZip.text;
    orderInfo[@"BillingCountryId"]= @"41";
    orderInfo[@"BillingMobileNo"]= txtBillingMobile.text;
    
    
    orderInfo[@"ShippingAddressId"]= @"0";
    orderInfo[@"ShippingFirstName"]= txtShippingFirstName.text;
    orderInfo[@"ShippingLastName"]= txtShippingLastName.text;
    orderInfo[@"ShippingEmail"]= txtShippingEmail.text;
    orderInfo[@"ShippingAddress1"]= txtShippingAddress1.text;
    orderInfo[@"ShippingAddress2"]= txtShippingAddress2.text;
    orderInfo[@"ShippingCity"]= txtShippingCity.text;
    
    NSString *stateProvinceIDShipping = [[APIManager sharedManager] stateList][selectedShippingIndex][@"ID"];
    orderInfo[@"ShippingStateProvinceId"]= stateProvinceIDShipping;
    orderInfo[@"ShippingZipPostalCode"]= txtShippingZip.text;
    orderInfo[@"ShippingCountryId"]= @"41";
    orderInfo[@"ShippingMobileNo"]= txtShippingMobile.text;

    
    [self addOrder:orderInfo];
}


#pragma mark - TextField delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (textField == txtBillingEmail || textField == txtShippingEmail ) {
        
        return newLength <= 70;
    }
    if (textField == txtBillingMobile) {
        
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
//    if (textField == txtFirstName) {
//        [txtLastName becomeFirstResponder];
//    }
//    else if (textField == txtLastName) {
//        [txtEmail becomeFirstResponder];
//    }
//    else if (textField == txtEmail) {
//        [txtPswd becomeFirstResponder];
//    }
//    else if (textField == txtPswd) {
//        [txtConfirmPswd becomeFirstResponder];
//    }
//    else{
//        [textField resignFirstResponder];
//    }
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

-(BOOL)isValidEmail:(UITextField*)txtEmail
{
    BOOL isValidMail = YES;
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:txtEmail.text options:0 range:NSMakeRange(0, [txtEmail.text length])];
    NSLog(@"regExMatches %lu", (unsigned long)regExMatches);
    if (regExMatches == 0 && txtEmail.text.length>0){
        [self showAlertTitle:@"" message:@"Please enter a valid email."];
        txtEmail.text = nil;
        isValidMail = NO;
    }
    return isValidMail;
    
}



#pragma mark - FPPopover Delegate

-(void)selectedItem:(NSString*)item selectedRow:(NSUInteger)rowNum
{
    if (isStateBillingTapped) {
        txtBillingState.text = item;
        selectedBillingIndex = rowNum;

    }else{
        txtShippingState.text = item;
        selectedShippingIndex = rowNum;
    }
    }

- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addOrder:(NSMutableDictionary*)order
{
    if (![APIManager isNetworkAvailable]) {
        
        return;
    }
    [[APIManager sharedManager] AddOrderWithOrderInfo:order withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
   
            [Utility showMessage:@"Order added successfully" OnView:self.view];
    // Response...........
//            AmountToPay = 710;
//            OrderGUID = "84d46216-0536-40d6-96ce-951f5a76cceb";
//            OrderId = 12007;
      
        }
    }];
    
    
}

@end
