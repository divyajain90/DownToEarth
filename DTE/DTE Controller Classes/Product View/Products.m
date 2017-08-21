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
    lblCategoryName.text = self.strCategory;
    arrayProductSelect = [[NSMutableArray alloc]init];
    tblProducts.delegate= self;
    tblProducts.dataSource= self;
    for(int i = 0 ; i < self.Products.count ; i++)
    {
        [arrayProductSelect addObject:@"0"];
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
    return [self.Products count];
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
    NSDictionary * product =self.Products[indexPath.row];
    NSURL* productImageURL = [NSURL URLWithString:product[@"ImageURL"]];
    
    cell.btnAddToCart.tag = indexPath.row;
    cell.btnProdWeight.tag = indexPath.row;
    [cell.productImage sd_setImageWithURL:productImageURL placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    cell.lblProductName.text = product[@"ProductName"];
    NSArray * productWeights =product[@"ProductWeights"];
    NSDictionary* prodWeights = [productWeights objectAtIndex:[[arrayProductSelect objectAtIndex:indexPath.row]intValue]];

    
    cell.lblProductPrice.text = [@"₹ " stringByAppendingString:prodWeights[@"Price"]];
//    if (strWeight== nil) {
//        strWeight = prodWeights[@"Weight"];
//
//    }
//    else
    cell.lblProductWeight.text = prodWeights[@"Weight"];

    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 159;
}

#pragma mark -- UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * product =self.Products[indexPath.row];
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
    
    
    [ActionSheetStringPicker showPickerWithTitle:@"WEIGHT"
                                            rows:weightArray
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [arrayProductSelect replaceObjectAtIndex:selectedIndex withObject:[NSString stringWithFormat:@"%ld",selectedIndex]];
                                           
                                           NSArray *indexPathArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
                                           [tblProducts reloadRowsAtIndexPaths:indexPathArray withRowAnimation:NO];
                                           
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
  //  ALERT_UnderProcess;
//    indexRow = sender.tag;
//    
//    //the view controller you want to present as popover
//    FPPopoverTableController *controller = [[FPPopoverTableController alloc] init];
//    controller.itemsArr = @[@"1",@"2",@"3"];
//    controller.delegate = self;
//    
//    //our popover
//    popoverWeight = [[FPPopoverController alloc] initWithViewController:controller];
//    popoverWeight.border = NO;
//    popoverWeight.tint = FPPopoverGreenTint;
//
//    popoverWeight.contentSize = CGSizeMake(130, 150);
//    //the popover will be presented from the okButton view
//    [popoverWeight presentPopoverFromView:sender];
// 
}

-(void)AddToCartAction
{
    ALERT_UnderProcess;
   
}

#pragma mark - FPPopover Delegate

-(void)selectedItem:(NSString*)item selectedRow:(NSUInteger)rowNum
{
    if (popoverWeight) {
        [popoverWeight dismissPopoverAnimated:YES];
        NSDictionary * product =self.Products[indexRow];
        NSArray * productWeights =product[@"ProductWeights"];
        NSMutableDictionary* prodWeights = [productWeights objectAtIndex:0];
        [prodWeights setValue:item forKey:@"Weight"];
//        strWeight = item;
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
