//
//  MyOrders.m
//  DTE
//
//  Created by Divya Jain on 9/25/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "MyOrders.h"
#import "MyOrderCell.h"
@interface MyOrders ()<UITableViewDelegate,UITableViewDataSource>{

}

@end

@implementation MyOrders

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tblMyOrders.delegate = self;
    tblMyOrders.dataSource = self;
    [self getMyOrders];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getMyOrders
{
    if (![APIManager isNetworkAvailable]) {
//        vwError.hidden = false;
        return;
    }
    
    [[APIManager sharedManager]GetMyOrdersByCustomerID:@"8931" withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            arrMyOrders = [response copy];
            [tblMyOrders reloadData];
        }
        else
        {
//            vwError.hidden = false;
        }
    }];
    
    
//    [{"OrderId":12002,"OrrderStatus":"Pending","OrderDate":"Sunday, September 24, 2017","OrderTotal":524.0000},
}

#pragma mark - TableView Methods

#pragma mark -- UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrMyOrders.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyOrderCell";

    MyOrderCell *cell = (MyOrderCell*)[tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyOrderCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dict = arrMyOrders[indexPath.row];
    cell.lblOrderDate.text = dict[@"OrderDate"];
    cell.lblOrderStatus.text = dict[@"OrrderStatus"];
    cell.lblOrderTotal.text = [NSString stringWithFormat:@"%@",dict[@"OrderTotal"]];
    cell.lblOrderID.text = [NSString stringWithFormat:@"%@",dict[@"OrderId"]] ;

    return cell;
    
}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}
@end
