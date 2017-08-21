//
//  CartItemCell.h
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnRemove;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProdName;
@property (weak, nonatomic) IBOutlet UILabel *lblProdWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblProdPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;


@property (weak, nonatomic) IBOutlet UILabel *lblSubTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblSaveAmt;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblGrandTotal;


@end
