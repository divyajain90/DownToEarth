//
//  MyOrders.h
//  DTE
//
//  Created by Divya Jain on 9/25/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrders : BaseClass
{
    __weak IBOutlet UITableView *tblMyOrders;
    NSArray * arrMyOrders;
}

- (IBAction)BackAction:(id)sender;

@end
