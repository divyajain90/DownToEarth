//
//  AddOrder.m
//  DTE
//
//  Created by Divya Jain on 9/20/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "AddOrder.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface AddOrder ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UITextField *txtSelectCounty1;
    IBOutlet UITextField *txtSelectCounty2;
    
    NSArray *pickerArray;
    UIToolbar *toolBar;
    UIPickerView *picker;
    
    IBOutlet TPKeyboardAvoidingScrollView *mainScroll;
    
    int tagPicker;
}

@end

@implementation AddOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    
    pickerArray = @[@"City1",@"City2"];
    
    picker = [[UIPickerView alloc]init];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(tapDone)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-picker.frame.size.height-50, 320, 44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:flex, doneButton, nil];
    [toolBar setItems:toolbarItems];
    
    txtSelectCounty2.inputView = picker;
    txtSelectCounty2.inputAccessoryView = toolBar;
    
    txtSelectCounty1.inputView = picker;
    txtSelectCounty1.inputAccessoryView = toolBar;
    
}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}


- (IBAction)tapSelectCount1:(id)sender {
    
    tagPicker = 1;
    [txtSelectCounty1 becomeFirstResponder];
}

- (IBAction)tapSelectCount2:(id)sender {
    
    tagPicker = 2;
    [txtSelectCounty2 becomeFirstResponder];
}

-(void)tapDone
{
    [self.view endEditing:YES];
}



#pragma mark - Picker View Data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (tagPicker == 1)
    {
        txtSelectCounty1.text = pickerArray[row];
    }
    else
    {
        txtSelectCounty2.text = pickerArray[row];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerArray[row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    lbl.text = pickerArray[row];
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textAlignment = NSTextAlignmentCenter;
    return lbl;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
