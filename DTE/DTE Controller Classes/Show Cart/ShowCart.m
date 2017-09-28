//
//  ShowCart.m
//  DTE
//
//  Created by Divya Jain on 21/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "ShowCart.h"
#import "CartItemCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import "SelectAddress.h"


@interface ShowCart ()

@end

@implementation ShowCart

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    arrCartItems = [[GET_DEFAULTS objectForKey:@"cartItems"] mutableCopy];

    arrCartItems = [[NSMutableArray alloc] init];
    [self getCartItems];
    
}


-(void)viewWillAppear:(BOOL)animated
{

    tblCartItems.delegate= self;
    tblCartItems.dataSource= self;
    tblCartItems.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

-(void)getCartItems{
    if (![APIManager isNetworkAvailable]) {
        
        return;
    }
    [[APIManager sharedManager] GetCartByCustomerId: [[User sharedUser] customerId] withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
           
            arrCartItems =[response mutableCopy];
            for (int i=0; i<arrCartItems.count; i++) {
            
            }
//            strSubTotal = 
            [tblCartItems reloadData];

        }
    }];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Methods

#pragma mark -- UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return arrCartItems.count+1;
    }
//    else if (section == 1)
//    return 1;
//    return section == 0?arrCartItems.count:1;

    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * reuseID;
    
    if (indexPath.row ==arrCartItems.count) {
        reuseID = @"CartItemCell1";
    }
    else
        reuseID = @"CartItemCell";

    CartItemCell *cell = (CartItemCell*)[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell== nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CartItemCell" owner:self options:nil];

        if (indexPath.row ==arrCartItems.count) {
            cell = [nibArray objectAtIndex:1];

        }
        else
            cell = [nibArray objectAtIndex:0];
        [cell.btnRemove addTarget:self action:@selector(RemoveProduct:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnRemove setTag:indexPath.row];

        }

    if (arrCartItems.count>0 && indexPath.row <arrCartItems.count) {

    NSDictionary *prodToDisplay = arrCartItems[indexPath.row];

    cell.lblProdName.text = prodToDisplay[@"ProductName"];
    cell.lblProdPrice.text = prodToDisplay[@"UnitPrice"];
    cell.lblOfferPrice.text = prodToDisplay[@"ProductName"];
    cell.lblProdWeight.text = prodToDisplay[@"Weight"];
    cell.txtQuantity.text = [NSString stringWithFormat:@"%@",prodToDisplay[@"Quantity"]];
//    NSURL* productImageURL = [NSURL URLWithString:prodToDisplay[@"ImageURL"]];
//
    [cell.imgProduct sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    }
    if (arrCartItems.count>0 ) {

    cell.lblTotal.text = @"";
    cell.lblSubTotal.text = arrCartItems[0][@"TotalPrice"];
    cell.lblGrandTotal.text = @"";
    cell.lblSaveAmt.text = @"save amt";
    }
    
    return cell;
    
}

-(void)RemoveProduct:(UIButton*)sender {

    NSDictionary *prodToDisplay = arrCartItems[sender.tag];

    if (![APIManager isNetworkAvailable]) {
//            vwError.hidden = false;
    
            return;
    }
    
        [[APIManager sharedManager] removeProduct:prodToDisplay[@"ShoppingCartItemId"] withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
            if (!error) {
                [btnCart updateCart:-1];

                arrCartItems=[response mutableCopy];
                [tblCartItems reloadData];
            }
        }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section ==0) {
        height=169;
    }
    else
        height= 148;
    return height;
    

}


- (IBAction)BackAction:(id)sender
{
    GO_BACK;
}
- (IBAction)SearchProductAction:(id)sender{}
- (IBAction)CartAction:(id)sender{}
- (IBAction)SettingsAction:(id)sender{}


- (IBAction)CheckoutAction:(id)sender {
//    [self performSegueWithIdentifier:@"EditShippingAddressSegue" sender:nil];

//    [self performSegueWithIdentifier:@"AddOrderSegue" sender:nil];
    
    [self performSegueWithIdentifier:@"SelectAddress" sender:nil];
    
}
@end
