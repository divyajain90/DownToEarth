//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

#import "AppDelegate.h"

NSString *strMenu1 =@"";
NSArray * arrSideMenuLogin;
NSArray * arrSideMenuLogout;

@implementation LeftMenuViewController
AppDelegate *app;

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    app = APPDELEGATE;
    arrSideMenuLogin = [[NSArray alloc] initWithObjects:@"",@" Cart",@" My Orders",@" Our story",@" Organic food culture",@" Guarantee for quality",@" Offers",@" Store Locations", @" Contact Us",@" Logout", nil];
    arrSideMenuLogout = [[NSArray alloc] initWithObjects:@"",@"Cart",@"Login/Sign Up",@"Our story",@"Organic food culture",@"Guarantee for quality",@"Offers",@"Store Locations", @"Contact Us", nil];

//	self.tableView.separatorColor = [UIColor greenColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);

//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];

    self.tableView.backgroundColor = BaseGreenColor;
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"updateMenu" object:nil];
}

//-(void)reloadTable
//{
//    [self.tableView reloadData ];
//}
#pragma mark - UITableView Delegate & Datasrouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([[User sharedUser]isLoggedIn]) {
//        return 7;
       return arrSideMenuLogin.count;

    }
   else
//	return 6;
       return arrSideMenuLogout.count;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[User sharedUser]isLoggedIn]) {

    if (indexPath.row == 0) {
        return 80;
    
    }
    }
    return 60;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.imageView setContentMode:UIViewContentModeScaleToFill];

    if ([[User sharedUser]isLoggedIn]) {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.textColor = [UIColor blackColor];
                
                cell.imageView.image =[UIImage imageNamed:@"Placeholder"]  ;
                strMenu1 = [@"Hi " stringByAppendingString:[NSString stringWithFormat:@"%@!",[User sharedUser].fName]];
                cell.textLabel.text = strMenu1;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                [cell.imageView setContentMode:UIViewContentModeScaleToFill];
                
                break;
                
            case 1:
                cell.textLabel.text = arrSideMenuLogin[1];
                cell.imageView.image =[UIImage imageNamed:@"CartGrey"]  ;
                
                break;
            case 2:
            {
                cell.textLabel.text = arrSideMenuLogin[2];
                cell.imageView.image =[UIImage imageNamed:@"MyOrders"]  ;
                
            }
                break;
            case 3:
            {
                cell.textLabel.text = arrSideMenuLogin[3];
                cell.imageView.image =[UIImage imageNamed:@"OurStory"]  ;
                
            }
                break;
            case 4:
            {
                cell.textLabel.text = arrSideMenuLogin[4];
                cell.imageView.image =[UIImage imageNamed:@"FoodCulture"]  ;
                
            }
                break;
            case 5:
            {
                cell.textLabel.text = arrSideMenuLogin[5];
                cell.imageView.image =[UIImage imageNamed:@"Quality"]  ;
                
            }
                break;
            case 6:
            {
                cell.textLabel.text = arrSideMenuLogin[6];
                cell.imageView.image =[UIImage imageNamed:@"Offers"]  ;
                
            }
                break;
            case 7:
            {
                cell.textLabel.text = arrSideMenuLogin[7];
                cell.imageView.image =[UIImage imageNamed:@"StoreLocations"]  ;
                
            }
                break;
            case 8:
            {
                cell.textLabel.text = arrSideMenuLogin[8];
                cell.imageView.image =[UIImage imageNamed:@"ContactUs"]  ;
                
            }
                break;
            case 9:
            {
                cell.textLabel.text = arrSideMenuLogin[9];
                cell.imageView.image =[UIImage imageNamed:@"Logout"]  ;
                
            }
                break;
        }
    }
    else
    {
    switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Home";
            cell.imageView.image =[UIImage imageNamed:@"RightArrow"]  ;
            cell.contentView.backgroundColor = [UIColor clearColor];

			break;
			
		case 1:
			cell.textLabel.text = @"Login";
            cell.imageView.image =[UIImage imageNamed:@"RightArrow"]  ;

			break;
        case 2:
        {
            cell.textLabel.text = @"Our story";
            cell.imageView.image =[UIImage imageNamed:@"RightArrow"]  ;
            
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"Organic food culture";
            cell.imageView.image =[UIImage imageNamed:@"RightArrow"]  ;
            
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"Offers";
            cell.imageView.image =[UIImage imageNamed:@"RightArrow"]  ;
            
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"Contact Us";
            cell.imageView.image =[UIImage imageNamed:@"RightArrow"]  ;
            
        }
            break;

            
	}
    }
	cell.backgroundColor = [UIColor clearColor];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	UIViewController *vc ;
    if ([[User sharedUser]isLoggedIn]) {
        switch (indexPath.row)
        {
            case 0:
                break;
                
            case 1: // Cart
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"ShowCart"];

                break;
            case 2: // My Orders
                
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"MyOrders"];
                break;
            case 3: //Our Story
                app.strSideMenuPage = arrSideMenuLogin[3];
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
                break;
            case 4:
                app.strSideMenuPage = arrSideMenuLogin[4];

                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
                break;
            case 5:
                app.strSideMenuPage = arrSideMenuLogin[5];

                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
                break;
            case 6:
                app.strSideMenuPage = arrSideMenuLogin[6];
                
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
                break;
            case 7:
//                app.strSideMenuPage = arrSideMenuLogin[7];
                
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
                break;
            case 8:
                app.strSideMenuPage = arrSideMenuLogin[8];
                
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
                break;

            case 9:
            {
                [APPDELEGATE logout];
//                [[User sharedUser] logout ];
//                [self.navigationController pop]
                
            }
                break;
        }

        
    }
    else{
	switch (indexPath.row)
	{
		case 0:
			vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"HomeView1"];
			break;
			
		case 1:
			vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Login"];
			break;
        case 2:
            app.strSideMenuPage = @"Our story";

            vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
            break;
        case 3:
            app.strSideMenuPage = @"Our story";
            vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
            break;
        case 4:
            app.strSideMenuPage = @"Organic food culture";
            
            vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
            break;
        case 5:
            app.strSideMenuPage = @"Guarantee for quality";
            
            vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Description"];
            break;
            
		case 6:
			[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
			[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
			return;
			break;
	}
    }
	[[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
															 withSlideOutAnimation:self.slideOutAnimationEnabled
																	 andCompletion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
