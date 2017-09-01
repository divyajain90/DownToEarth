//
//  ShowCart.h
//  DTE
//
//  Created by Divya Jain on 21/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowCart : BaseClass<UITableViewDelegate,UITableViewDataSource>
{

    __weak IBOutlet UITableView *tblCartItems;
    
    NSMutableArray *arrCartItems;
    NSString *strSubTotal;

}

- (IBAction)CheckoutAction:(id)sender;
- (IBAction)BackAction:(id)sender;
- (IBAction)SearchProductAction:(id)sender;
- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;

@end
