//
//  ProceedPayment.h
//  DTE
//
//  Created by Divya Jain on 03/10/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProceedPayment : BaseClass
{
    __weak IBOutlet UIWebView *paymentWebVw;

}
@property (strong, nonatomic) NSString* orderID;
- (IBAction)BackAction:(id)sender;

@end
