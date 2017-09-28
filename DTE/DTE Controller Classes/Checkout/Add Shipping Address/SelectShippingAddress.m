//
//  SelectShippingAddress.m
//  DTE
//
//  Created by Divya Jain on 22/08/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "SelectShippingAddress.h"
#import "SelectAddressCell.h"
#import "EditShippingAddress.h"
@interface SelectShippingAddress ()

@end
NSInteger selectedIndex;
@implementation SelectShippingAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    selectedIndex = 1;
    arrShippingAddress = [[NSMutableArray alloc]init];
    [arrShippingAddress addObject:self.dictDeliveryAddress];
    tblSelectAddress.delegate = self;
    tblSelectAddress.dataSource = self;
    tblSelectAddress.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

-(void)getShippingAddress
{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Methods
#pragma mark -- UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    SelectAddressCell *cell = (SelectAddressCell*)[tableView dequeueReusableCellWithIdentifier:@"SelectAddressCell"];
    if (cell== nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SelectAddressCell" owner:self options:nil];
        
            cell = [nibArray objectAtIndex:0];
        
        if (indexPath.row == selectedIndex) {
            cell.vwDeliver.hidden = false;
        }
        else
            cell.vwDeliver.hidden = true;

        
        [cell.btnSelectAddress addTarget:self action:@selector(SelectAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSelectAddress setTag:indexPath.row];
        
        [cell.btnDeliver addTarget:self action:@selector(DeliverAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDeliver setTag:indexPath.row];
        
        [cell.btnEditAddress addTarget:self action:@selector(EditAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnEditAddress setTag:indexPath.row];

        [cell.btnDeleteAddress addTarget:self action:@selector(DeleteAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDeleteAddress setTag:indexPath.row];

    }
    
    
    cell.lblFullName.text = self.dictDeliveryAddress[@"FullName"];
    cell.lblAddress1.text = self.dictDeliveryAddress[@"AddressLine1"];
    cell.lblAddress2.text = self.dictDeliveryAddress[@"AddressLine2"];
    cell.lblCity_State_Postal.text = [NSString stringWithFormat:@"%@, %@ %@",self.dictDeliveryAddress[@"City"],self.dictDeliveryAddress[@"State"],self.dictDeliveryAddress[@"Postal"]] ;
    cell.lblCountry.text = self.dictDeliveryAddress[@"Country"];

    
       return cell;
    
}


-(void)SelectAddressAction:(UIButton*)sender
{
    selectedIndex = sender.tag;
    [tblSelectAddress beginUpdates];
    
}

-(void)DeliverAction:(UIButton*)sender
{
    
}

-(void)EditAddressAction:(UIButton*)sender
{
   
    [self performSegueWithIdentifier:@"EditShippingSegue" sender:self.dictDeliveryAddress];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditShippingAddress* vc= segue.destinationViewController;
    vc.dictDeliveryAddress = self.dictDeliveryAddress;
    vc.toEdit = YES;

}

-(void)DeleteAddressAction:(UIButton*)sender
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 193;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}
@end
