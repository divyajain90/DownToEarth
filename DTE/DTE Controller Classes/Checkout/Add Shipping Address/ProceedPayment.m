//
//  ProceedPayment.m
//  DTE
//
//  Created by Divya Jain on 03/10/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "ProceedPayment.h"

@interface ProceedPayment ()

@end

@implementation ProceedPayment

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlString = [NSString stringWithFormat:@"http://demo.downtoearthorganicfood.com/rdpgccApp.aspx?orderId=%@",self.orderID];
    [paymentWebVw loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackAction:(id)sender {
    GO_BACK;
}
@end
