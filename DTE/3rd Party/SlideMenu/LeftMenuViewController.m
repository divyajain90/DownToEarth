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
        return 7;

    }
   else
	return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//	return 40;
//}

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
                cell.textLabel.text = [@"Hi " stringByAppendingString:[NSString stringWithFormat:@"%@!",[User sharedUser].fName]];
                cell.contentView.backgroundColor = [UIColor whiteColor];
                [cell.imageView setContentMode:UIViewContentModeScaleToFill];

                break;
                
            case 1:
                cell.textLabel.text = @"Home";
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
            case 6:
            {
                cell.textLabel.text = @"Logout";
                cell.imageView.image =[UIImage imageNamed:@"RightArrow"]  ;
  
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
                
            case 1:
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"HomeView1"];

                break;
            case 2:
                
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
            {
                [[User sharedUser] logout ];
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
