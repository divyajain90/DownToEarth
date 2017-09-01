//
//  SelectShippingAddress.h
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectShippingAddress : BaseClass<UITableViewDelegate,UITableViewDataSource>
{

    __weak IBOutlet UITableView *tblSelectAddress;
    
    NSMutableArray* arrShippingAddress;
}

@property(strong,nonatomic)NSMutableDictionary* dictDeliveryAddress;


- (IBAction)BackAction:(id)sender;

@end
