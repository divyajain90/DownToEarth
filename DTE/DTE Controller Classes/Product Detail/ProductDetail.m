//
//  ProductDetail.m
//  DTE
//
//  Created by Divya Jain on 5/16/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "ProductDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FPPopoverController.h"
#import "FPPopoverTableController.h"

@interface ProductDetail ()<FPPopupViewDelegate>

@end
FPPopoverController *popoverQty;
FPPopoverController *popoverWeight;
NSUInteger selectedWeightIndex;

@implementation ProductDetail
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(setUI) withObject:nil afterDelay:0.4];
    [self updateProductDetails];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUI
{
    btnAddToCart.layer.cornerRadius = 4;
    btnAddToCart.layer.masksToBounds = YES;
    lblProductQuantity.layer.cornerRadius = 4;
    lblProductQuantity.layer.masksToBounds = YES;
    lblProductWeight.layer.cornerRadius = 4;
    lblProductWeight.layer.masksToBounds = YES;

}

-(void)updateProductDetails
{
    NSURL *prodImgURL = [NSURL URLWithString:self.product[@"ImageURL"]];
    [imgProduct sd_setImageWithURL:prodImgURL placeholderImage:[UIImage imageNamed:@"Placeholder.jpg"]];
    lblProductName.text = [@" " stringByAppendingString:self.product[@"ProductName"]] ;
    NSArray * productWeights =self.product[@"ProductWeights"];
    NSDictionary* prodWeights = [productWeights objectAtIndex:0];

    lblProductWeight.text = prodWeights[@"Weight"];
    lblProductPrice.text = [@"₹ " stringByAppendingString:prodWeights[@"Price"]];
    lblProductQuantity.text = @"1";
    lblProductAvailability.text = @"In Stock";
    txtProductReview.text = self.product[@"SmallDescription"];
    
    selectedWeightIndex = 0;
    
}

#pragma mark - Actions

- (IBAction)AddToCartAction:(id)sender {
   // ALERT_UnderProcess;
    NSArray * productWeights =self.product[@"ProductWeights"];
    NSDictionary* prodWeights = [productWeights objectAtIndex:selectedWeightIndex];

    NSMutableDictionary *dictProdInfo =[[NSMutableDictionary alloc] init];
    dictProdInfo[@"CustomerId"] = @"8931";
    dictProdInfo[@"ProductVariantAttributeValueID"] = prodWeights[@"ProductVariantAttributeValueId"];
    dictProdInfo[@"ProductVariantID"] = self.product[@"ProductVariantId"];
    dictProdInfo[@"Qty"] = lblProductQuantity.text;
    dictProdInfo[@"Weight"] = [lblProductWeight.text stringByReplacingOccurrencesOfString:@" " withString:@""] ;


    
    if (![APIManager isNetworkAvailable]) {
//        vwError.hidden = false;
        
        return;
    }
    [[APIManager sharedManager] addToCartForProduct:dictProdInfo withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSArray *arr = [response copy];
            [btnCart updateCart:arr.count];
        }
    }];


}

- (IBAction)QuantityAction:(id)sender {
//    //the view controller you want to present as popover
    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
    controller.itemsArr = @[@"1",@"2",@"3",@"4",@"5"];
    controller.delegate = self;
    
    //our popover
    popoverQty = [[FPPopoverController alloc] initWithViewController:controller];
    popoverQty.border = NO;
    popoverQty.tint = FPPopoverWhiteTint;
    
    //the popover will be presented from the okButton view
    [popoverQty presentPopoverFromView:sender];

}

- (IBAction)WeightAction:(id)sender {
    //the view controller you want to present as popover
    NSMutableArray *weightArray = [[NSMutableArray alloc]init];
    NSArray * productWeights = self.product[@"ProductWeights"];
    for (int i = 0; i < productWeights.count; i++) {
        [weightArray addObject:[[productWeights objectAtIndex:i] objectForKey:@"Weight"]];
    }

    
    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
    controller.itemsArr = weightArray;
    controller.delegate = self;
    
    //our popover
    popoverWeight = [[FPPopoverController alloc] initWithViewController:controller];
    popoverWeight.border = NO;
    popoverWeight.tint = FPPopoverWhiteTint;
    
    //the popover will be presented from the okButton view
    [popoverWeight presentPopoverFromView:sender];


}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}

- (IBAction)SearchProductAction:(id)sender
{
    ALERT_UnderProcess;
}
- (IBAction)CartAction:(id)sender
{
    ALERT_UnderProcess;
}
- (IBAction)SettingsAction:(id)sender
{
    ALERT_UnderProcess;
}

#pragma mark - FPPopover Delegate
//-(void)selectedTableRow:(NSUInteger)rowNum
//{
//    if (popoverWeight) {
//        [popoverWeight dismissPopoverAnimated:YES];
//        lblProductWeight.text = ;
//
//    }
//    else{
//        [popoverQty dismissPopoverAnimated:YES];
//        lblProductQuantity.text = [NSString stringWithFormat:@"%lu",rowNum+1];
//
//    }
//
//}


-(void)selectedItem:(NSString *)item selectedRow:(NSUInteger)rowNum
{
    if (popoverWeight) {
        selectedWeightIndex = rowNum;
        [popoverWeight dismissPopoverAnimated:YES];
        lblProductWeight.text = item;
        NSArray * productWeights =self.product[@"ProductWeights"];
        NSDictionary* prodWeights = [productWeights objectAtIndex:rowNum];
        lblProductPrice.text = [@"₹ " stringByAppendingString:prodWeights[@"Price"]];
        popoverWeight= nil;
        
    }
    else{
        [popoverQty dismissPopoverAnimated:YES];
        lblProductQuantity.text = item;
        popoverQty= nil;

    }

}
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}

@end
