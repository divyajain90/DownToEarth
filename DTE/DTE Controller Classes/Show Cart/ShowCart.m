//
//  ShowCart.m
//  DTE
//
//  Created by Divya Jain on 21/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "ShowCart.h"
#import "CartItemCell.h"

@interface ShowCart ()

@end

@implementation ShowCart

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tblCartItems.delegate= self;
    tblCartItems.dataSource= self;
    tblCartItems.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tblCartItems reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Methods

#pragma mark -- UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section == 0?1:1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartItemCell *cell = (CartItemCell*)[tableView dequeueReusableCellWithIdentifier:@"CartItemCell"];
    if (cell== nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CartItemCell" owner:self options:nil];

        if (indexPath.section ==0) {
            cell = [nibArray objectAtIndex:0];
        }
        else
            cell = [nibArray objectAtIndex:1];

        }
    
    return cell;
    
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
    [self performSegueWithIdentifier:@"EditShippingAddressSegue" sender:nil];
}
@end
