//
//  PFAccountViewController.m
//  ราตรีสโมสร
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFAccountViewController.h"

@interface PFAccountViewController () <UIScrollViewDelegate>

@end

@implementation PFAccountViewController

NSString *removeBreckets;

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
    
    self.navigationItem.title = @"Setting";
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    self.bgEditView.layer.shadowOffset = CGSizeMake(0.5, -0.5);
    self.bgEditView.layer.shadowRadius = 2;
    self.bgEditView.layer.shadowOpacity = 0.1;
    
    CALayer *logoutButton = [self.logoutButton layer];
    [logoutButton setMasksToBounds:YES];
    [logoutButton setCornerRadius:5.0f];
    
    self.RatreeSamosornApi = [[PFRatreeSamosornApi alloc] init];
    self.RatreeSamosornApi.delegate = self;
    
    self.obj = [[NSDictionary alloc] init];
    self.rowCount = [[NSString alloc] init];
    
    [self.RatreeSamosornApi me];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)PFRatreeSamosornApi:(id)sender meResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"Me %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"url"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    [self.RatreeSamosornApi getUserSetting];
    
}

- (void)PFRatreeSamosornApi:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)PFRatreeSamosornApi:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"getUserSetting %@",response);
    
    //switch
    
    if ([[response objectForKey:@"notify_update"] intValue] == 1) {
        self.switchNews.on = YES;
    } else {
        self.switchNews.on = NO;
    }
    
    if ([[response objectForKey:@"notify_message"] intValue] == 1) {
        self.switchMessage.on = YES;
    } else {
        self.switchMessage.on = NO;
    }
    
}

- (void)PFRatreeSamosornApi:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)switchNewsonoff:(id)sender{
    
    if(self.switchNews.on) {
        [self.RatreeSamosornApi settingNews:@"1"];
    } else {
        [self.RatreeSamosornApi settingNews:@"0"];
    }
    
}

- (IBAction)switchMessageonoff:(id)sender{
    
    if(self.switchMessage.on) {
        [self.RatreeSamosornApi settingMessage:@"1"];
    } else {
        [self.RatreeSamosornApi settingMessage:@"0"];
    }
    
}

- (void)PFRatreeSamosornApi:(id)sender settingNewsResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
}

- (void)PFRatreeSamosornApi:(id)sender settingNewsErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)editProfile:(id)sender {
    PFProfileViewController *profileView = [[PFProfileViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        profileView = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController_Wide" bundle:nil];
    } else {
        profileView = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController" bundle:nil];
    }
    
    profileView.delegate = self;
    profileView.objAccount = self.obj;
    [self.navigationController pushViewController:profileView animated:YES];
}

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link{
    [self.delegate PFAccountViewController:self viewPicture:link];
}

- (IBAction)applanguage:(id)sender {
    NSLog(@"applanguage");
}

- (IBAction)logoutTapped:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
    [self.RatreeSamosornApi logOut];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) PFProfileViewControllerBack {
    [self viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFAccountViewControllerBack)]){
            [self.delegate PFAccountViewControllerBack];
        }
    }
    
}

@end
