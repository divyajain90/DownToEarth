//
//  Description.h
//  DTE
//
//  Created by Divya Jain on 9/16/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Description : BaseClass
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UITextView *txtVwOurStory;
    __weak IBOutlet UITextView *txtVwOffers;
    __weak IBOutlet UITextView *txtVwContactUs;
    __weak IBOutlet UITextView *txtVwOrganicFoodCulture;
    __weak IBOutlet UITextView *txtVwQuality;
    
}
- (IBAction)BackAction:(id)sender;


@end
