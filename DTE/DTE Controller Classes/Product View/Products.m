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
        
        [cell.btnProdDetail addTarget:self action:@selector(DetailsAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAddToCart addTarget:self action:@selector(AddToCartAction) forControlEvents:UIControlEventTouchUpInside];
      

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
-(void)DetailsAction
{
}

-(void)WeightAction:(UIButton*)sender
{
    NSMutableArray *weightArray = [[NSMutableArray alloc]init];
    NSDictionary * product =self.Products[sender.tag];

    NSArray * productWeights = product[@"ProductWeights"];
    for (int i = 0; i < productWeights.count; i++) {
        [weightArray addObject:[[productWeights objectAtIndex:i] objectForKey:@"Weight"]];
    }
    
  //  ALERT_UnderProcess;
    indexRow = sender.tag;
    
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

-(void)AddToCartAction
{
//    ALERT_UnderProcess;
    
    
    
   
}

#pragma mark - FPPopover Delegate

-(void)selectedItem:(NSString*)item selectedRow:(NSUInteger)rowNum
{
    if (popoverWeight) {
        [popoverWeight dismissPopoverAnimated:YES];
        
        [arrEditedProducts[indexRow]setValue:item forKey:@"Weight"];
        [arrEditedProducts[indexRow]setValue:arrProducts[indexRow][@"ProductWeights"][rowNum][@"Price"] forKey:@"Price"];

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
