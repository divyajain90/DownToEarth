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
    if ([app.strSideMenuPage isEqualToString: @" Our story"]) {
        lblTitle.text = @"Our story";
        txtVwOurStory.hidden = NO;
 
    }
    else if ([app.strSideMenuPage isEqualToString: @" Organic food culture"]) {
        lblTitle.text = @"Organic food culture";
        txtVwOrganicFoodCulture.hidden = NO;


    }
    else if ([app.strSideMenuPage isEqualToString: @" Guarantee for quality"]) {
        lblTitle.text = @"Guarantee for quality";
        txtVwQuality.hidden = NO;

    }
    else if ([app.strSideMenuPage isEqualToString: @" Contact Us"]) {
        lblTitle.text = @"Contact Us";
        txtVwContactUs.hidden = NO;

        
    }
    else if ([app.strSideMenuPage isEqualToString: @" Offers"]) {
        lblTitle.text = @"Offers";
        txtVwOffers.hidden = NO;

    }
    else if ([app.strSideMenuPage isEqualToString: @" Store Locations"]) {
        lblTitle.text = @"Store Locations";
        txtVwStoreLocations.hidden = NO;
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackAction:(id)sender {
    GO_BACK;
}
@end
