//
//  SearchScreen.m
//  DTE
//
//  Created by Divya Jain on 8/26/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "SearchScreen.h"
#import "Products.h"
@interface SearchScreen ()

@end

@implementation SearchScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI
{
    lblNoProductFound.hidden = false;
    tblSearchProd.hidden = true;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textfieldDataChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    DTESearchBar.layer.cornerRadius = 3.5;
    vwSearchedTag.hidden = YES;
    
    arrProducts = [[NSMutableArray alloc]init];
    arrdisplayItems = [[NSMutableArray alloc]init];


    
    tblSearchProd.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setUIForTextBox:DTESearchBar];
    //    [mySearchBar becomeFirstResponder];
    
}

-(void)setUIForTextBox: (UITextField*)text
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    text.leftView = paddingView;
    text.leftViewMode = UITextFieldViewModeAlways;
    
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    return YES;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        [DTESearchBar resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (DTESearchBar.text.length>0) {

        
        [self performSegueWithIdentifier:@"searchedProdSegue" sender:arrdisplayItems];
        
    }
    else
        [DTESearchBar resignFirstResponder];
    
    
    
    return YES;
}

-(void)searchProducts
{
    if (![APIManager isNetworkAvailable]) {
//        vwError.hidden = false;
        
        return;
    }
    
    [[APIManager sharedManager] searchProductByKeywords:DTESearchBar.text withCompletionBlock:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            lblNoProductFound.hidden = true;

            arrProducts = response;
            if (DTESearchBar.text.length>0) {
                [arrdisplayItems removeAllObjects];
                [arrdisplayItems addObjectsFromArray:arrProducts];

            }
            else
                [arrdisplayItems removeAllObjects];
 
            
            [tblSearchProd performSelector:@selector(reloadData) withObject:nil afterDelay:0.01];


        }
    }];

    
    

}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"searchedProdSegue"])
    {
    
        Products *vc = segue.destinationViewController;
        vc.Products = sender;
        vc.strCategory = @"";
    }
    
    
}


#pragma mark - TextField delegates

-(void)textfieldDataChanged:(NSNotification *)not
{

    [self searchProducts];
    

}



#pragma mark tableView del
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (arrdisplayItems.count) {
        lblNoProductFound.hidden = true;
        tblSearchProd.hidden = false;

    }
    
    return arrdisplayItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    if (arrdisplayItems.count) {
        NSDictionary* prodInfo = arrdisplayItems[indexPath.row];
        cell.textLabel.text =prodInfo[@"ProductName"] ;
  
    }
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * arrToSend = [[NSArray alloc] initWithObjects:arrdisplayItems[indexPath.row], nil];
    [self performSegueWithIdentifier:@"searchedProdSegue" sender:arrToSend];

}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}

- (IBAction)clearSearchAction:(id)sender {
    vwSearchedTag.hidden = YES;
    lblSearchText.text = nil;
    DTESearchBar.text = nil;
 
    [arrdisplayItems removeAllObjects];

    [tblSearchProd reloadData];

}

- (IBAction)SearchAction:(id)sender {
    if (DTESearchBar.text.length>0) {
        
        
        [self performSegueWithIdentifier:@"searchedProdSegue" sender:arrdisplayItems];
        
    }

}
@end
