//
//  BadgeButton.m
//  DTE
//
//  Created by Divya Jain on 5/24/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "BadgeButton.h"
#import "CustomBadge.h"
//static int i ;
@implementation BadgeButton{
    CustomBadge *badge;
    BadgeStyle *badgeStyle;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

-(void) initialize
{
    NSInteger __block cartValue;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        cartValue = [[APIManager sharedManager] cartItems].count;

    });
    
    NSString *successRemainingStr = [NSString stringWithFormat:@"%ld", (long)cartValue];
    badge = [CustomBadge customBadgeWithString:successRemainingStr];
    CGFloat y;
    y= 0;
    CGPoint point = CGPointMake(self.frame.size.width-badge.frame.size.width/2 + 3, y);
    CGSize size = CGSizeMake(15, 15);
    CGRect rect = CGRectMake(point.x, point.y, size.width, size.height);
    [badge setFrame:rect];
    
    badgeStyle = [BadgeStyle freeStyleWithTextColor:[UIColor greenColor] withInsetColor:[UIColor colorWithRed:17.0/255.0 green:80/255.0 blue:100.0/255.0 alpha:1.0] withFrameColor:nil withFrame:nil withShadow:nil withShining:nil withFontType:BadgeStyleFontTypeHelveticaNeueLight];
    [badge setBadgeStyle:badgeStyle];
    [self addSubview:badge];
    if (cartValue == 0) badge.hidden = true;
}



+(instancetype)sharedButton
{
    static BadgeButton *sharedButton;
    if (!sharedButton){
        sharedButton = [[super allocWithZone:nil]init];

    }
    return sharedButton;
}


//MARK:- UpdateCart

-(void)updateCart:(NSInteger)value {
//    NSInteger cartValue = [self getCartValue] + value;
        NSInteger cartValue = value;

    badge.hidden = true;
    if (cartValue >= 0) {
        badge.hidden = false;
        NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
        [pref setInteger:cartValue forKey:@"cart"];
        [pref synchronize];
        [badge autoBadgeSizeWithString:[NSString stringWithFormat:@"%ld", (long)cartValue]];
    }
}

-(void)updateCart
{
    NSInteger cartValue = [[APIManager sharedManager] cartItems].count;
    badge.hidden = true;
    if (cartValue >= 0) {
        badge.hidden = false;
        NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
        [pref setInteger:cartValue forKey:@"cart"];
        [pref synchronize];
        [badge autoBadgeSizeWithString:[NSString stringWithFormat:@"%ld", (long)cartValue]];
    }
}

-(NSInteger)getCartValue {
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSInteger cart = 0;
    if ([pref integerForKey:@"cart"]) {
        cart = [pref integerForKey:@"cart"];
    }
    return cart;
}

@end
