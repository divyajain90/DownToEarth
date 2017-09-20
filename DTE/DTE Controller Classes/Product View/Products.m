//
//  Products.m
//  DTE
//
//  Created by Divya Jain on 5/15/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "Products.h"
#import "ProductCell.h"
#import "ProductDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>
 #import "ActionSheetPicker.h"

@interface Products ()<FPPopupViewDelegate>

@end


@implementation Products
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrProducts= (NSMutableArray*)[self.Products mutableCopy];
    lblCategoryName.text = self.strCategory;
    arrEditedProducts = [[NSMutableArray alloc] init];
    tblProducts.delegate= self;
    tblProducts.dataSource= self;
    
    for(int i = 0 ; i < self.Products.count ; i++)
    {

        NSArray * productWeights =self.Products[i][@"ProductWeights"];
        NSDictionary* prodWeights = [productWeights objectAtIndex:0];
        NSMutableDictionary *dictEditedProducts = [[NSMutableDictionary alloc] init];

        [dictEditedProducts setObject:prodWeights[@"Weight"] forKey:@"Weight" ];
        [dictEditedProducts setObject:prodWeights[@"Price"] forKey:@"Price" ];
        [dictEditedProducts setObject:prodWeights[@"ProductVariantAttributeValueId"] forKey:@"ProductVariantAttributeValueId" ];

        
        [arrEditedProducts addObject:dictEditedProducts];
        
    }
    
    
    [tblProducts reloadData];

}
-(void)viewWillAppear:(BOOL)animated
{
     [Utility hideHUDOnView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Methods

#pragma mark -- UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrProducts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:@"productCell"];
    if (cell== nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];

        [cell.btnProdWeight addTarget:self action:@selector(WeightAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnProdWeight setTag:indexPath.row];
        
//        [cell.btnProdDetail addTarget:self action:@selector(DetailsAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.btnProdDetail setTag:indexPath.row];

        [cell.btnAddToCart addTarget:self action:@selector(AddToCartAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAddToCart setTag:indexPath.row];

      

    }
    NSDictionary * product =arrProducts[indexPath.row];
    NSURL* productImageURL = [NSURL URLWithString:product[@"ImageURL"]];
    
    cell.btnAddToCart.tag = indexPath.row;
    cell.btnProdWeight.tag = indexPath.row;
    [cell.productImage sd_setImageWithURL:productImageURL placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    cell.lblProductName.text = product[@"ProductName"];
    cell.lblProductPrice.text = [@"₹ " stringByAppendingString:arrEditedProducts[indexPath.row][@"Price"]];
    cell.lblProductWeight.text = arrEditedProducts[indexPath.row][@"Weight"];

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 159;
}

#pragma mark -- UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * product =arrProducts[indexPath.row];
    [Utility showHUDOnView:self.view];
    dispatch_time_t deferTime = 0.10f;
    dispatch_after(deferTime, dispatch_get_main_queue(), ^{
        [[APIManager sharedManager] getProductDetailByProductID:product[@"ProductId"] withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
            [Utility hideHUDOnView:self.view];
            if (!error) {
                [self performSegueWithIdentifier:@"productDetailSegue" sender:response];
                
            }
            else
                [self showAlertTitle:@"" message:[error localizedDescription]];
            
            
        }];
    });
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"productDetailSegue"])
    {
        ProductDetail *vc = segue.destinationViewController;
        vc.product = sender;
    }
}


#pragma mark - Actions
- (IBAction)BackAction:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    GO_BACK;
    
}

- (IBAction)SearchProductAction:(id)sender {
    ALERT_UnderProcess;
}

- (IBAction)CartAction:(id)sender {
   
    ALERT_UnderProcess;

    

}

- (IBAction)SettingsAction:(id)sender {
    ALERT_UnderProcess;

}
-(void)DetailsAction:(UIButton*)sender
{
    
}

-(void)WeightAction:(UIButton*)sender
{
    indexRow = sender.tag;

    NSMutableArray *weightArray = [[NSMutableArray alloc]init];
    NSDictionary * product =self.Products[indexRow];

    NSArray * productWeights = product[@"ProductWeights"];
    for (int i = 0; i < productWeights.count; i++) {
        [weightArray addObject:[[productWeights objectAtIndex:i] objectForKey:@"Weight"]];
    }
    
    
    //the view controller you want to present as popover
    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
    controller.itemsArr = weightArray;
    controller.delegate = self;
    
    //our popover
    popoverWeight = [[FPPopoverController alloc] initWithViewController:controller];
    popoverWeight.border = NO;
    popoverWeight.tint = FPPopoverGreenTint;

    popoverWeight.contentSize = CGSizeMake(130, 150);
    //the popover will be presented from the okButton view
    [popoverWeight presentPopoverFromView:sender];
 
}

-(void)AddToCartAction:(UIButton*)sender
{
    indexRow = sender.tag;
    strWeight = [arrEditedProducts[indexRow][@"Weight"] stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    
    NSMutableDictionary *dictProdInfo =[[NSMutableDictionary alloc] init];
    dictProdInfo[@"CustomerId"] = @"8931";
    dictProdInfo[@"ProductVariantAttributeValueID"] = arrEditedProducts[indexRow][@"ProductVariantAttributeValueId"];
    dictProdInfo[@"ProductVariantID"] = self.Products[indexRow][@"ProductVariantId"];
    dictProdInfo[@"Qty"] = @"1";
    dictProdInfo[@"Weight"] = strWeight;

    
    [self AddToCart:dictProdInfo];
   
}


-(void)AddToCart:(NSMutableDictionary*)prodToAdd
{
    if (![APIManager isNetworkAvailable]) {
        vwError.hidden = false;
        
        return;
    }
    [[APIManager sharedManager] addToCartForProduct:prodToAdd withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSArray *arr = [response copy];
            [btnCart updateCart:arr.count];
        }
    }];
//   ----------------------------------------------------------
//    Getting response as:
//    Printing description of response:
//    <__NSArrayI 0x600000247bf0>(
//    {
//        CreatedOn = "/Date(1503427154517)/";
//        CustomerSessionGuid = "ac268143-30fd-461c-afc0-adba49378b73";
//        ProductAttribute = "<Attributes><ProductVariantAttribute ID=\"34\"><ProductVariantAttributeValue><Value>674</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>";
//        ProductName = "Biryani Pulav Rice";
//        ProductVariantId = 108;
//        Quantity = 4;
//        ShoppingCartItemId = 56154;
//        ShoppingCartTypeId = 1;
//        TotalPrice = "\U0930\U0941 700.00";
//        UnitPrice = "175.00";
//        UpdatedOn = "/Date(1503466341843)/";
//        Weight = "Weight: 1 kg";
//    },
//    {
//        CreatedOn = "/Date(1503466119407)/";
//        CustomerSessionGuid = "ac268143-30fd-461c-afc0-adba49378b73";
//        ProductAttribute = "<Attributes><ProductVariantAttribute ID=\"323\"><ProductVariantAttributeValue><Value>720</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>";
//        ProductName = "Wheat Chakki Atta";
//        ProductVariantId = 170;
//        Quantity = 4;
//        ShoppingCartItemId = 56155;
//        ShoppingCartTypeId = 1;
//        TotalPrice = "\U0930\U0941 1,180.00";
//        UnitPrice = "295.00";
//        UpdatedOn = "/Date(1503466205267)/";
//        Weight = "Weight: 5 Kg";
//    },
//    {
//        CreatedOn = "/Date(1503466480267)/";
//        CustomerSessionGuid = "ac268143-30fd-461c-afc0-adba49378b73";
//        ProductAttribute = "<Attributes><ProductVariantAttribute ID=\"334\"><ProductVariantAttributeValue><Value>755</Value></ProductVariantAttributeValue></ProductVariantAttribute></Attributes>";
//        ProductName = "Brown Basmati Rice Superfine ";
//        ProductVariantId = 275;
//        Quantity = 1;
//        ShoppingCartItemId = 56156;
//        ShoppingCartTypeId = 1;
//        TotalPrice = "\U0930\U0941 185.00";
//        UnitPrice = "185.00";
//        UpdatedOn = "/Date(1503466480267)/";
//        Weight = "Weight: 1 Kg";
//    }
//                                )
//
}


#pragma mark - FPPopover Delegate

-(void)selectedItem:(NSString*)item selectedRow:(NSUInteger)rowNum
{
    if (popoverWeight) {
        [popoverWeight dismissPopoverAnimated:YES];
        
        [arrEditedProducts[indexRow]setValue:item forKey:@"Weight"];
        [arrEditedProducts[indexRow]setValue:arrProducts[indexRow][@"ProductWeights"][rowNum][@"Price"] forKey:@"Price"];
        
        
        
        NSArray * productWeights =arrProducts[indexRow][@"ProductWeights"];
        NSDictionary* prodWeights = [productWeights objectAtIndex:rowNum];
        NSString* ProductVariantAttributeValueId = [NSString stringWithFormat:@"%@",prodWeights[@"ProductVariantAttributeValueId"]];
        
        [arrEditedProducts[indexRow]setValue:ProductVariantAttributeValueId forKey:@"ProductVariantAttributeValueId"];

        

        NSArray *indexPathArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexRow inSection:0]];
        [tblProducts reloadRowsAtIndexPaths:indexPathArray withRowAnimation:NO];
    }
}

- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}



@end
