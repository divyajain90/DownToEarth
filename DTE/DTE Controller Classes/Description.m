//
//  Description.m
//  DTE
//
//  Created by Divya Jain on 9/16/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "Description.h"

@interface Description ()

@end

@implementation Description

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    AppDelegate *app = APPDELEGATE;
    if ([app.strSideMenuPage isEqualToString: @"Our story"]) {
        lblTitle.text = @"Our story";
        txtVwDesc.text = @"Our story";
 
    }
    else if ([app.strSideMenuPage isEqualToString: @"Organic food culture"]) {
        lblTitle.text = @"Organic food culture";
        txtVwDesc.text = @"Organic food culture";

    }
    else if ([app.strSideMenuPage isEqualToString: @"Guarantee for quality"]) {
        lblTitle.text = @"Guarantee for quality";
        txtVwDesc.text = @"Guarantee for quality";
        
    }
//    else if ([app.strSideMenuPage isEqualToString: @"Our story"]) {
//        lblTitle.text = @"Our story";
//        txtVwDesc.text = @"Our story";
//        
//    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackAction:(id)sender {
    GO_BACK;
}
@end
