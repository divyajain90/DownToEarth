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
    __weak IBOutlet UITextView *txtVwDesc;
}
- (IBAction)BackAction:(id)sender;


@end
