//
//  PFProfileViewController.m
//  ราตรีสโมสร
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFProfileViewController.h"

@interface PFProfileViewController ()

@end

@implementation PFProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.waitView];
    
    self.navigationItem.title = @"Profile";
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.bgprofileView.layer.shadowOffset = CGSizeMake(0.5, -0.5);
    self.bgprofileView.layer.shadowRadius = 2;
    self.bgprofileView.layer.shadowOpacity = 0.1;
    
    CALayer *edit_bt = [self.edit_bt layer];
    [edit_bt setMasksToBounds:YES];
    [edit_bt setCornerRadius:5.0f];
    
    CALayer *facebook_bt = [self.facebook_bt layer];
    [facebook_bt setMasksToBounds:YES];
    [facebook_bt setCornerRadius:5.0f];
    
    CALayer *email_bt = [self.email_bt layer];
    [email_bt setMasksToBounds:YES];
    [email_bt setCornerRadius:5.0f];
    
    CALayer *website_bt = [self.website_bt layer];
    [website_bt setMasksToBounds:YES];
    [website_bt setCornerRadius:5.0f];
    
    CALayer *tel_bt = [self.tel_bt layer];
    [tel_bt setMasksToBounds:YES];
    [tel_bt setCornerRadius:5.0f];
    
    CALayer *gender_bt = [self.gender_bt layer];
    [gender_bt setMasksToBounds:YES];
    [gender_bt setCornerRadius:5.0f];
    
    CALayer *birthday_bt = [self.birthday_bt layer];
    [birthday_bt setMasksToBounds:YES];
    [birthday_bt setCornerRadius:5.0f];
    
    self.RatreeSamosornApi = [[PFRatreeSamosornApi alloc] init];
    self.RatreeSamosornApi.delegate = self;
    
    self.objAccount = [[NSDictionary alloc] init];

    [self.RatreeSamosornApi me];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)fullimgTapped:(id)sender {
    
    NSString *picStr = [[NSString alloc] initWithString:[[self.objAccount objectForKey:@"picture"] objectForKey:@"url"]];
    [self.delegate PFAccountViewController:self viewPicture:picStr];
    
}

- (void)PFRatreeSamosornApi:(id)sender meResponse:(NSDictionary *)response {
    self.objAccount = response;
    NSLog(@"Me %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"url"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    self.facebook.text = [response objectForKey:@"fb_name"];
    self.email.text = [response objectForKey:@"email"];
    self.website.text = [response objectForKey:@"website"];
    self.tel.text = [response objectForKey:@"mobile"];
    self.gender.text = [response objectForKey:@"gender"];
    
    NSString *myString = [[NSString alloc] initWithFormat:@"%@",[response objectForKey:@"birth_date"]];
    NSString *mySmallerString = [myString substringToIndex:10];
    
    self.birthday.text = mySmallerString;
    
    [self.RatreeSamosornApi getUserSetting];
    
}

- (void)PFRatreeSamosornApi:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)PFRatreeSamosornApi:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"getUserSetting %@",response);
    
    //switch
    if ([[response objectForKey:@"show_facebook"] intValue] == 1) {
        [self.facebook_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(0, 174, 239)];
        self.facebookSetting = @"1";
    } else {
        [self.facebook_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(167, 169, 172)];
        self.facebookSetting = @"0";
    }
    if ([[response objectForKey:@"show_email"] intValue] == 1) {
        [self.email_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(0, 174, 239)];
        self.emailSetting = @"1";
    } else {
        [self.email_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(167, 169, 172)];
        self.emailSetting = @"0";
    }
    if ([[response objectForKey:@"show_website"] intValue] == 1) {
        [self.website_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(0, 174, 239)];
        self.websiteSetting = @"1";
    } else {
        [self.website_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(167, 169, 172)];
        self.websiteSetting = @"0";
    }
    if ([[response objectForKey:@"show_mobile"] intValue] == 1) {
        [self.tel_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(0, 174, 239)];
        self.telSetting = @"1";
    } else {
        [self.tel_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(167, 169, 172)];
        self.telSetting = @"0";
    }
    if ([[response objectForKey:@"show_gender"] intValue] == 1) {
        [self.gender_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(0, 174, 239)];
        self.genderSetting = @"1";
    } else {
        [self.gender_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(167, 169, 172)];
        self.genderSetting = @"0";
    }
    if ([[response objectForKey:@"show_birth_date"] intValue] == 1) {
        [self.birthday_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(0, 174, 239)];
        self.birthdaySetting = @"1";
    } else {
        [self.birthday_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(167, 169, 172)];
        self.birthdaySetting = @"0";
    }
    
}

- (void)PFRatreeSamosornApi:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

-(IBAction)editTapped:(id)sender{
    PFEditViewController *editView = [[PFEditViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editView = [[PFEditViewController alloc] initWithNibName:@"PFEditViewController_Wide" bundle:nil];
    } else {
        editView = [[PFEditViewController alloc] initWithNibName:@"PFEditViewController" bundle:nil];
    }
    editView.delegate = self;
    [self presentModalViewController:editView animated:YES];
}

- (IBAction)facebookTapped:(id)sender {
    if ([self.facebook_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.facebook_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(167, 169, 172)];
        self.facebookSetting = @"0";
    } else {
        [self.facebook_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(0, 174, 239)];
        self.facebookSetting = @"1";
    }
    [self.RatreeSamosornApi settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)emailTapped:(id)sender {
    if ([self.email_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.email_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(167, 169, 172)];
        self.emailSetting = @"0";
    } else {
        [self.email_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(0, 174, 239)];
        self.emailSetting = @"1";
    }
    [self.RatreeSamosornApi settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)websiteTapped:(id)sender {
    if ([self.website_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.website_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(167, 169, 172)];
        self.websiteSetting = @"0";
    } else {
        [self.website_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(0, 174, 239)];
        self.websiteSetting = @"1";
    }
    [self.RatreeSamosornApi settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)telTapped:(id)sender {
    if ([self.tel_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.tel_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(167, 169, 172)];
        self.telSetting = @"0";
    } else {
        [self.tel_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(0, 174, 239)];
        self.telSetting = @"1";
    }
    [self.RatreeSamosornApi settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)genderTapped:(id)sender {
    if ([self.gender_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.gender_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(167, 169, 172)];
        self.genderSetting = @"0";
    } else {
        [self.gender_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(0, 174, 239)];
        self.genderSetting = @"1";
    }
    [self.RatreeSamosornApi settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)birthdayTapped:(id)sender {
    if ([self.birthday_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.birthday_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(167, 169, 172)];
        self.birthdaySetting = @"0";
    } else {
        [self.birthday_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(0, 174, 239)];
        self.birthdaySetting = @"1";
    }
    [self.RatreeSamosornApi settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (void) PFEditViewControllerBack {
    [self viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFProfileViewControllerBack)]){
            [self.delegate PFProfileViewControllerBack];
        }
    }
    
}

@end
