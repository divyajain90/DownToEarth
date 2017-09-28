//
//  SelectAddress.m
//  DTE
//
//  Created by Divya Jain on 9/26/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "SelectAddress.h"

@interface SelectAddress ()<FPPopupViewDelegate>

@end
NSUInteger selectedShippingIndex;
NSUInteger selectedBillingIndex;
@implementation SelectAddress


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isShippingAddress = YES;
    arrShippingAddress = [[NSMutableArray alloc] init];
    arrBillingAddress = [[NSMutableArray alloc] init];
    if ([[User sharedUser] shippingAddress].count) {
        
        for (int i=0; i<[[User sharedUser] shippingAddress].count; i++) {
            if (i == 0) {
                [arrShippingAddress addObject:@"Select Shipping Address"];
                continue;
            }
            NSDictionary * dict = [[User sharedUser] shippingAddress][i-1];
            NSString * str = [dict[@"FirstName"] stringByAppendingString:[NSString stringWithFormat:@"%@ , %@",dict[@"LastName"],dict[@"Address1"]]];
            
            [arrShippingAddress addObject:str];
        }
    }
    
    if ([[User sharedUser] billingAddress].count) {
        
        for (int i=0; i<[[User sharedUser] billingAddress].count; i++) {
            if (i == 0) {
                [arrBillingAddress addObject:@"Select Billing Address"];
                continue;
            }
            NSDictionary * dict = [[User sharedUser] billingAddress][i-1];
            NSString * str = [dict[@"FirstName"] stringByAppendingString:[NSString stringWithFormat:@"%@ , %@",dict[@"LastName"],dict[@"Address1"]]];
            [arrBillingAddress addObject:str];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}

- (IBAction)SelectShippingAddressAction:(id)sender {
    isShippingAddress = YES;
    if (popoverStateList) {
        popoverStateList = nil;
    }
    //the view controller you want to present as popover
    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
    controller.itemsArr = arrShippingAddress;
    controller.delegate = self;
    
    //our popover
    popoverStateList = [[FPPopoverController alloc] initWithViewController:controller];
    popoverStateList.border = NO;
    popoverStateList.tint = FPPopoverGreenTint;
    
    popoverStateList.contentSize = CGSizeMake(300, 350);
    //the popover will be presented from the okButton view
    [popoverStateList presentPopoverFromView:sender];
    
}

- (IBAction)SelectBillingAddress:(id)sender {
    isShippingAddress = NO;
    if (popoverStateList) {
        popoverStateList = nil;
    }
    //the view controller you want to present as popover
    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
    controller.itemsArr = arrBillingAddress;
    controller.delegate = self;
    
    //our popover
    popoverStateList = [[FPPopoverController alloc] initWithViewController:controller];
    popoverStateList.border = NO;
    popoverStateList.tint = FPPopoverGreenTint;
    
    popoverStateList.contentSize = CGSizeMake(300, 350);
    //the popover will be presented from the okButton view
    [popoverStateList presentPopoverFromView:sender];
    
    
}

- (IBAction)SelectAction:(id)sender {
    
    NSMutableDictionary *orderInfo = [[NSMutableDictionary alloc] init];
    NSDictionary * dictBilling= [[User sharedUser] billingAddress][selectedBillingIndex];
    //[{"AddressId":13219,"CustomerId":8934,"IsBillingAddress":true,"FirstName":"srk","LastName":"siddiqui","Email":"srk@mailinator.com","Address1":"jaipur","Address2":"jaiipur","City":"JAIPUR","StateProvinceId":217,"ZipPostalCode":"302003","CountryId":41,"MobileNo":"9529238553"}
    orderInfo[@"AdvanceAmount"] = @"0";

    orderInfo[@"BillingAddressId"] = dictBilling[@"AddressId"];
    orderInfo[@"BillingFirstName"]= dictBilling[@"FirstName"];
    orderInfo[@"BillingLastName"]= dictBilling[@"LastName"];
    orderInfo[@"BillingEmail"]= dictBilling[@"Email"];
    orderInfo[@"BillingAddress1"]= dictBilling[@"Address1"];
    orderInfo[@"BillingAddress2"]= dictBilling[@"Address2"];
    orderInfo[@"BillingCity"]= dictBilling[@"City"];
    orderInfo[@"BillingStateProvinceId"]= dictBilling[@"StateProvinceId"];
    orderInfo[@"BillingZipPostalCode"]= dictBilling[@"ZipPostalCode"];
    orderInfo[@"BillingCountryId"]= dictBilling[@"CountryId"];
    orderInfo[@"BillingMobileNo"]= dictBilling[@"MobileNo"];
    
    NSDictionary * dictShipping= [[User sharedUser] shippingAddress][selectedShippingIndex];

    orderInfo[@"ShippingAddressId"]= dictShipping[@"AddressId"];
    orderInfo[@"ShippingFirstName"]= dictShipping[@"FirstName"];
    orderInfo[@"ShippingLastName"]= dictShipping[@"LastName"];
    orderInfo[@"ShippingEmail"]= dictShipping[@"Email"];
    orderInfo[@"ShippingAddress1"]= dictShipping[@"Address1"];
    orderInfo[@"ShippingAddress2"]= dictShipping[@"Address2"];
    orderInfo[@"ShippingCity"]= dictShipping[@"City"];
    orderInfo[@"ShippingStateProvinceId"]= dictShipping[@"StateProvinceId"];
    orderInfo[@"ShippingZipPostalCode"]= dictShipping[@"ZipPostalCode"];
    orderInfo[@"ShippingCountryId"]= dictShipping[@"CountryId"];
    orderInfo[@"ShippingMobileNo"]= dictShipping[@"MobileNo"];
    
    [self addOrder:orderInfo];
}

- (IBAction)AddNewAddressAction:(id)sender {
    
  [self performSegueWithIdentifier:@"AddOrderSegue" sender:nil];

}

-(void)addOrder:(NSMutableDictionary*)order
{
    if (![APIManager isNetworkAvailable]) {
        
        return;
    }
    [[APIManager sharedManager] AddOrderWithOrderInfo:order withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            
        }
    }];
    
    
}

#pragma mark - FPPopover Delegate

-(void)selectedItem:(NSString*)item selectedRow:(NSUInteger)rowNum
{
    
    if (isShippingAddress) {
        txtShippingAddress.text = item;
        selectedShippingIndex = rowNum;
        
    }else{
        txtBillingAddress.text = item;
        selectedBillingIndex = rowNum;
    }
    if ((selectedBillingIndex >0) && (selectedShippingIndex >0)) {
        btnSelect.enabled = YES;
    }
    
    
}
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}




@end
