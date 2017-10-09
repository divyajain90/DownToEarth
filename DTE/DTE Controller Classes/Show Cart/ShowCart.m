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
#import "TPKeyboardAvoidingScrollView.h"

@interface ShowCart ()
{
    __weak IBOutlet TPKeyboardAvoidingScrollView *mainScroll;

}
@end

@implementation ShowCart

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    arrCartItems = [[NSMutableArray alloc] init];
    [self setUIForTextBox:txtCouponCode];
    [self getCartItems];
//    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    [self updatePrice:@"0"];
    btnCheckout.layer.cornerRadius = 4;
    btnCheckout.layer.masksToBounds = YES;
    btnApplyCoupon.layer.cornerRadius = 4;
    btnApplyCoupon.layer.masksToBounds = YES;


}
-(void)updatePrice:(NSString*)price
{
    lblTotalPrice.text= price;

}

-(void)setUIForTextBox: (UITextField*)text
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    text.leftView = paddingView;
    text.leftViewMode = UITextFieldViewModeAlways;
    
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
    [[APIManager sharedManager] GetCartWithCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
           
            arrCartItems =[response mutableCopy];
            for (int i=0; i<arrCartItems.count; i++) {
            
            }
            if (arrCartItems.count) {
                [self updatePrice:arrCartItems[0][@"TotalPrice"]];
  
            }
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
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
        return arrCartItems.count;
//    }
//    else if (section == 1)
//    return 1;
//    return section == 0?arrCartItems.count:1;

//    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * reuseID;
    
//    if (indexPath.row ==arrCartItems.count) {
//        reuseID = @"CartItemCell1";
//    }
//    else
        reuseID = @"CartItemCell";

    CartItemCell *cell = (CartItemCell*)[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell== nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CartItemCell" owner:self options:nil];

//        if (indexPath.row ==arrCartItems.count) {
//            cell = [nibArray objectAtIndex:1];
//
//        }
//        else
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
//    if (arrCartItems.count>0 ) {
//
//    cell.lblTotal.text = @"";
//    cell.lblSubTotal.text = arrCartItems[0][@"TotalPrice"];
//    cell.lblGrandTotal.text = @"";
//    cell.lblSaveAmt.text = @"save amt";
//    }
    
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
                [btnCart updateCart:arrCartItems.count];

                arrCartItems=[response mutableCopy];
                if (arrCartItems.count) {
                    [self updatePrice:arrCartItems[0][@"TotalPrice"]];
                    
                }

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
//        height= 148;
    height= UITableViewAutomaticDimension;
    return height;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400; // customize the height
}

- (IBAction)BackAction:(id)sender
{
    GO_BACK;
}
- (IBAction)SearchProductAction:(id)sender{}
- (IBAction)CartAction:(id)sender{}
- (IBAction)SettingsAction:(id)sender{}

- (IBAction)ApplyAction:(id)sender {
    if (!txtCouponCode.text.length) {
        [Utility showMessage:@"Please enter a coupon code!" OnView:self.view];
    }else{
    lblDiscount.text = @"Discount:- 0%";
    lblDiscount.hidden = false;
        NSString * priceTotal = @"0";
        if (arrCartItems.count) {
            priceTotal = arrCartItems[0][@"TotalPrice"];
        }
        NSMutableAttributedString * price =
        [[NSMutableAttributedString alloc] initWithString:priceTotal
                                        attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
        NSString *atrPrice = [NSString stringWithFormat:@" %@",priceTotal];
        NSAttributedString * str = [[NSAttributedString alloc] initWithString:atrPrice];
        [price appendAttributedString:str];
        lblTotalPrice.attributedText = price;
    constCheckoutTop.constant = constCheckoutTop.constant + 20;
    }
}


- (IBAction)CheckoutAction:(id)sender {
//    [self performSegueWithIdentifier:@"EditShippingAddressSegue" sender:nil];

//    [self performSegueWithIdentifier:@"AddOrderSegue" sender:nil];
    if (arrCartItems.count) {
        [self performSegueWithIdentifier:@"SelectAddress" sender:nil];

    }
else
    [Utility showMessage:@"No item in the cart!" OnView:self.view];
}


@end
