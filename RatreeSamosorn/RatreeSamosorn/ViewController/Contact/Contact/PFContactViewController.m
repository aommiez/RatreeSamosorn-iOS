//
//  PFContactViewController.m
//  ราตรีสโมสร
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import "PFContactViewController.h"

@interface PFContactViewController ()

@end

@implementation PFContactViewController

BOOL loadContact;
BOOL noDataContact;
BOOL refreshDataContact;

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
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    // Navbar setup
    UIColor *firstColor = [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:107.0f/255.0f alpha:1.0f];
    UIColor *secondColor = [UIColor colorWithRed:255.0f/255.0f green:102.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    
    [self.navBar setBarTintGradientColors:colors];
    
    self.navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    self.RatreeSamosornApi = [[PFRatreeSamosornApi alloc] init];
    self.RatreeSamosornApi.delegate = self;
    
    if (![[self.RatreeSamosornApi getLanguage] isEqualToString:@"TH"]) {
        self.navItem.title = @"Contact Us";
    } else {
        self.navItem.title = @"ติดต่อ";
    }
    
    CALayer *mapView = [self.mapView layer];
    [mapView setMasksToBounds:YES];
    [mapView setCornerRadius:7.0f];
    
    CALayer *mapImage = [self.mapImage layer];
    [mapImage setMasksToBounds:YES];
    [mapImage setCornerRadius:7.0f];
    
    NSString *urlmap = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"http://maps.googleapis.com/maps/api/staticmap?center=",@"18.789622",@",",@"98.982788",@"&zoom=16&size=6400x280&sensor=false&markers=color:red%7Clabel:Satit%7C",@"18.789622",@",",@"98.982788"];
    
    [DLImageLoader loadImageFromURL:urlmap
                          completed:^(NSError *error, NSData *imgData) {
                              self.mapImage.image = [UIImage imageWithData:imgData];
                          }];
    
    loadContact = NO;
    noDataContact = NO;
    refreshDataContact = NO;
    
    [self.RatreeSamosornApi getContact];
    
    self.locationTxt.text = @"12/21 หมู่ 4 ถ.เชียงใหม่ - ลำปาง ต.ท่าศาลา อ.เมือง จ.เชียงใหม่ 50000";
    //12/21 หมู่ 4 ถ.เชียงใหม่ - ลำปาง ต.ท่าศาลา อ.เมือง จ.เชียงใหม่ 50000
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)PFRatreeSamosornApi:(id)sender getContactResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"%@",response);
    
    [self.waitView removeFromSuperview];
    
    //Content Label
    self.contentTxt.text = [self.obj objectForKey:@"info"];
    CGRect frame = self.contentTxt.frame;
    frame.size = [self.contentTxt sizeOfMultiLineLabel];
    [self.contentTxt sizeOfMultiLineLabel];
    [self.contentTxt setFrame:frame];
    int lines = self.contentTxt.frame.size.height/15;
    
    if (lines > 2) {
        self.contentTxt.numberOfLines = 2;
        UILabel *descText = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 6.0f, 300.0f, 42.0f)];
        descText.text = self.contentTxt.text;
        descText.numberOfLines = 2;
        [descText setFont:[UIFont systemFontOfSize:15]];
        descText.textColor = [UIColor colorWithRed:104.0/255.0 green:71.0/255.0 blue:56.0/255.0 alpha:1.0];
        self.contentTxt.alpha = 0;
        [self.contentView addSubview:descText];
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, 54);
        
    } else {
        self.contentTxt.numberOfLines = lines;
        UILabel *descText = [[UILabel alloc] initWithFrame:frame];
        descText.text = self.contentTxt.text;
        descText.numberOfLines = lines;
        [descText setFont:[UIFont systemFontOfSize:15]];
        descText.textColor = [UIColor colorWithRed:104.0/255.0 green:71.0/255.0 blue:56.0/255.0 alpha:1.0];
        self.contentTxt.alpha = 0;
        [self.contentView addSubview:descText];
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, descText.frame.size.height+18);
    }
    
    self.mapView.frame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y+self.contentView.frame.size.height-37, self.mapView.frame.size.width, self.mapView.frame.size.height);
    
    self.buttonView.frame = CGRectMake(self.buttonView.frame.origin.x, self.buttonView.frame.origin.y+self.contentView.frame.size.height-37, self.buttonView.frame.size.width, self.buttonView.frame.size.height);
    
    self.powerbyView.frame = CGRectMake(self.powerbyView.frame.origin.x, self.powerbyView.frame.origin.y+self.contentView.frame.size.height-37, self.powerbyView.frame.size.width, self.powerbyView.frame.size.height);
    
    self.headerView.frame = CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height+self.contentView.frame.size.height-37);
    
    self.phoneTxt.text = [response objectForKey:@"phone"];
    self.websiteTxt.text = [response objectForKey:@"website"];
    self.emailTxt.text = [response objectForKey:@"email"];
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (void)PFRatreeSamosornApi:(id)sender getContactErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (IBAction)mapTapped:(id)sender{
    
    [self.delegate HideTabbar];
    
    PFMapViewController *mapView = [[PFMapViewController alloc] init];
    if(IS_WIDESCREEN) {
        mapView = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController_Wide" bundle:nil];
    } else {
        mapView = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController" bundle:nil];
    }
    mapView.delegate = self;
    [self.navController pushViewController:mapView animated:YES];
}

- (IBAction)phoneTapped:(id)sender{
    NSString *phone = [[NSString alloc] initWithFormat:@"telprompt://%@",self.phoneTxt.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

- (IBAction)websiteTapped:(id)sender{
    NSString *website = [[NSString alloc] initWithFormat:@"%@",self.websiteTxt.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}

- (IBAction)emailTapped:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Select Menu"
                                  delegate:self
                                  cancelButtonTitle:@"cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Send Email", nil];
    [actionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Send Email"]) {
        [self.delegate HideTabbar];
        NSLog(@"Send Email");
        // Email Subject
        NSString *emailTitle = @"ราตรีสโมสร";
        // Email Content
        NSString *messageBody = @"ราตรีสโมสร!";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:self.emailTxt.text];
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0f/255.0f green:102.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        
        [mc.navigationBar setTintColor:[UIColor whiteColor]];
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    if ([buttonTitle isEqualToString:@"Cancel"]) {
        NSLog(@"Cancel");
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //[self reloadView];
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.delegate ShowTabbar];
}

- (IBAction)powerbyTapped:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://pla2fusion.com/"]];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ( scrollView.contentOffset.y < 0.0f ) {
        
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        self.loadLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:[NSDate date]]];
        self.act.alpha =1;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -60.0f ) {
        refreshDataContact = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ( scrollView.contentOffset.y < -100.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
        self.tableView.frame = CGRectMake(0, 60, 320, self.tableView.frame.size.height);
		[UIView commitAnimations];
        [self performSelector:@selector(resizeTable) withObject:nil afterDelay:2];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));
    if (offset >= 0 && offset <= 5) {
        if (!noDataContact) {
            refreshDataContact = NO;
            
            /*
            self.mingmitrSDK = [[PFMingMitrSDK alloc] init];
            self.mingmitrSDK.delegate = self;
            
            [self.mingmitrSDK getNews:@"NO" next:self.paging];
             */
        }
    }
}

- (void)resizeTable {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
}

- (void)PFMapViewControllerBack {
    [self.delegate ShowTabbar];
}

@end
