//
//  SearchScreen.h
//  DTE
//
//  Created by Divya Jain on 8/26/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchScreen : BaseClass<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    __weak IBOutlet UITextField *DTESearchBar;
    __weak IBOutlet UITableView *tblSearchProd;
    IBOutlet UILabel *lblSearchText;
    
    IBOutlet UIView *vwSearchedTag;
    
//    NSMutableArray *trendingTagsArr;
    NSMutableArray *arrdisplayItems;
    
    NSMutableArray *arrProducts;
    

    
    __weak IBOutlet UILabel *lblNoProductFound;
    NSInteger indexRow;
    UIImageView *iv;
    
    
    BOOL shouldCallAPI;
    int pageNo;
}
- (IBAction)clearSearchAction:(id)sender;
- (IBAction)BackAction:(id)sender;
- (IBAction)SearchAction:(id)sender;

@end
