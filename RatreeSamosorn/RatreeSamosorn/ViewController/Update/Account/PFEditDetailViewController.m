//
//  PFEditDetailViewController.m
//  ราตรีสโมสร
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFEditDetailViewController.h"

@interface PFEditDetailViewController ()

@end

@implementation PFEditDetailViewController

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
    
    self.RatreeSamosornApi = [[PFRatreeSamosornApi alloc] init];
    self.RatreeSamosornApi.delegate = self;
    
    if ([self.checkstatus isEqualToString:@"displayname"]) {
        self.navigationItem.title = @"Display Name";
        self.tableView.tableHeaderView = self.displaynameView;
        
        self.displayname.text = [self.obj objectForKey:@"display_name"];
        
        CALayer *displayname_bt = [self.displayname_bt layer];
        [displayname_bt setMasksToBounds:YES];
        [displayname_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"password"]) {
        self.navigationItem.title = @"Password";
        self.tableView.tableHeaderView = self.passwordView;
        
        CALayer *password_bt = [self.password_bt layer];
        [password_bt setMasksToBounds:YES];
        [password_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"email"]) {
        self.navigationItem.title = @"E-mail Address";
        self.tableView.tableHeaderView = self.emailView;
        
        self.email.text = [self.obj objectForKey:@"email"];
        
        CALayer *email_bt = [self.email_bt layer];
        [email_bt setMasksToBounds:YES];
        [email_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"website"]) {
        self.navigationItem.title = @"Website";
        self.tableView.tableHeaderView = self.websiteView;
        
        self.website.text = [self.obj objectForKey:@"website"];
        
        CALayer *website_bt = [self.website_bt layer];
        [website_bt setMasksToBounds:YES];
        [website_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"phone"]) {
        self.navigationItem.title = @"Phone Number";
        self.tableView.tableHeaderView = self.phoneView;
        
        self.phone.text = [self.obj objectForKey:@"mobile"];
        
        CALayer *phone_bt = [self.phone_bt layer];
        [phone_bt setMasksToBounds:YES];
        [phone_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"gender"]) {
        self.navigationItem.title = @"Gender";
        self.tableView.tableHeaderView = self.genderView;
        
        if ([[self.obj objectForKey:@"gender"] isEqualToString:@"Male"] || [[self.obj objectForKey:@"gender"] isEqualToString:@"male"]) {
            [self.male_bt setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
            [self.female_bt setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            self.checkgender = @"male";
        } else {
            [self.male_bt setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [self.female_bt setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
            self.checkgender = @"female";
        }
        
        CALayer *gender_bt = [self.gender_bt layer];
        [gender_bt setMasksToBounds:YES];
        [gender_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"birthday"]) {
        self.navigationItem.title = @"Birthday";
        self.tableView.tableHeaderView = self.birthdayView;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSString *myString = [[NSString alloc] initWithFormat:@"%@",[self.obj objectForKey:@"birth_date"]];
        NSString *mySmallerString = [myString substringToIndex:10];
    
        NSString *finalstr = [NSString stringWithFormat:@"%@",mySmallerString];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
        NSDate *date = [dateFormat dateFromString:finalstr];
        [self.Date setDate:date];
        
        CALayer *birthday_bt = [self.birthday_bt layer];
        [birthday_bt setMasksToBounds:YES];
        [birthday_bt setCornerRadius:5.0f];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)PFRatreeSamosornApi:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"settingUser %@",response);
}

- (void)PFRatreeSamosornApi:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)PFRatreeSamosornApi:(id)sender changPasswordResponse:(NSDictionary *)response {
    NSLog(@"changPassword %@",response);
    if ([[[response objectForKey:@"error"] objectForKey:@"type"] isEqualToString:@"Main\\CTL\\Exception\\NeedParameterException"] || [[[response objectForKey:@"error"] objectForKey:@"type"] isEqualToString:@"Main\\CTL\\Exception\\UnAuthorizedException"]) {
        [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                    message:[[response objectForKey:@"error"] objectForKey:@"message"]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                    message:@"Save complete."
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)PFRatreeSamosornApi:(id)sender changPasswordErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)displaynameTapped:(id)sender{
    
    [self.displayname resignFirstResponder];
    
    [self.RatreeSamosornApi updateSetting:self.displayname.text
                          email:[self.obj objectForKey:@"email"]
                        website:[self.obj objectForKey:@"website"]
                            tel:[self.obj objectForKey:@"mobile"]
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[self.obj objectForKey:@"birth_date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)passwordTapped:(id)sender{
    if (![self.newpassword.text isEqualToString:self.confirmpassword.text]) {
        [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                    message:@"You must enter the same password twice in order to confirm it."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else {
        [self.RatreeSamosornApi changePassword:self.password.text new_password:self.newpassword.text];
    }
}

- (IBAction)emailTapped:(id)sender{
    
    [self.email resignFirstResponder];
    
    [self.RatreeSamosornApi updateSetting:[self.obj objectForKey:@"display_name"]
                          email:self.email.text
                        website:[self.obj objectForKey:@"website"]
                            tel:[self.obj objectForKey:@"mobile"]
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[self.obj objectForKey:@"birth_date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)websiteTapped:(id)sender{
    
    [self.website resignFirstResponder];
    
    [self.RatreeSamosornApi updateSetting:[self.obj objectForKey:@"display_name"]
                          email:[self.obj objectForKey:@"email"]
                        website:self.website.text
                            tel:[self.obj objectForKey:@"mobile"]
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[self.obj objectForKey:@"birth_date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)phoneTapped:(id)sender{
    
    [self.phone resignFirstResponder];
    
    [self.RatreeSamosornApi updateSetting:[self.obj objectForKey:@"display_name"]
                          email:[self.obj objectForKey:@"email"]
                        website:[self.obj objectForKey:@"website"]
                            tel:self.phone.text
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[self.obj objectForKey:@"birth_date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)maleTapped:(id)sender {
    [self.male_bt setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [self.female_bt setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    self.checkgender = @"male";
}

- (IBAction)femaleTapped:(id)sender {
    [self.male_bt setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [self.female_bt setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    self.checkgender = @"female";
}

- (IBAction)genderTapped:(id)sender {
        [self.RatreeSamosornApi updateSetting:[self.obj objectForKey:@"display_name"]
                                email:[self.obj objectForKey:@"email"]
                            website:[self.obj objectForKey:@"website"]
                                tel:[self.obj objectForKey:@"mobile"]
                                gender:self.checkgender
                            birthday:[self.obj objectForKey:@"birth_date"]];
    
        [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                    message:@"Save complete."
                                    delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil] show];
}

- (IBAction)birthdayTapped:(id)sender {
    
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    date.dateFormat = @"yyyy/MM/dd";
    NSArray *temp = [[NSString stringWithFormat:@"%@",[date stringFromDate:self.Date.date]] componentsSeparatedByString:@""];
    NSString *dateString = [[NSString alloc] init];
    dateString = [[NSString alloc] initWithString:[temp objectAtIndex:0]];
    
    [self.RatreeSamosornApi updateSetting:[self.obj objectForKey:@"display_name"]
                          email:[self.obj objectForKey:@"email"]
                        website:[self.obj objectForKey:@"website"]
                            tel:[self.obj objectForKey:@"mobile"]
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:dateString];
    
    [[[UIAlertView alloc] initWithTitle:@"ราตรีสโมสร"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField  {
    [self.email resignFirstResponder];
    [self.website resignFirstResponder];
    [self.phone resignFirstResponder];
    
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFEditDetailViewControllerBack)]){
            [self.delegate PFEditDetailViewControllerBack];
        }
    }
    
}

@end
