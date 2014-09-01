//
//  PFMenuViewController.m
//  RatreeSamosorn
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import "PFMenuViewController.h"

@interface PFMenuViewController ()

@end

@implementation PFMenuViewController

BOOL loadMenu;
BOOL noDataMenu;
BOOL refreshDataMenu;

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
        self.navItem.title = @"Menu";
    } else {
        self.navItem.title = @"รายการ";
    }
    
    UIView *hv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    self.tableView.tableHeaderView = hv;
    UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)];
    self.tableView.tableFooterView = fv;
    
    self.CalendarView.hidden = YES;
    
    refreshDataMenu = YES;
    
    self.objFood = [[NSDictionary alloc] init];
    self.arrObjFood = [[NSMutableArray alloc] init];
    
    self.objDrink = [[NSDictionary alloc] init];
    self.arrObjDrink = [[NSMutableArray alloc] init];
    
    self.objGallery = [[NSDictionary alloc] init];
    self.arrObjGallery = [[NSMutableArray alloc] init];
    
    self.foodsBt.backgroundColor = [UIColor clearColor];
    [self.foodsBt.titleLabel setTextColor:[UIColor whiteColor]];
    self.drinksBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.drinksBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.activityBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.activityBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.galleryBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.galleryBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.menu = @"Foods";
    [self.RatreeSamosornApi getFoods];
    
    self.viewController = [PFActivityCalendarViewController new];
    [self.CalendarView addSubview:self.viewController.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)PFRatreeSamosornApi:(id)sender getFoodsResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    self.objFood = response;
    
    self.menu = @"Foods";
    
    if (!refreshDataMenu) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjFood addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjFood removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjFood addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getFoodsErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)PFRatreeSamosornApi:(id)sender getDrinksResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    self.objDrink = response;
    
    if (!refreshDataMenu) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjDrink addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjDrink removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjDrink addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getDrinksErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)PFRatreeSamosornApi:(id)sender getGalleryResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    self.objGallery = response;
    
    if (!refreshDataMenu) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjGallery addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjGallery removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjGallery addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getGalleryErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.menu isEqualToString:@"Foods"]) {
        return [self.arrObjFood count];
    }
    if ([self.menu isEqualToString:@"Drinks"]) {
        return [self.arrObjDrink count];
    }
    if ([self.menu isEqualToString:@"Activity"]) {
        return 0;
    }
    if ([self.menu isEqualToString:@"Gallery"]) {
        return [self.arrObjGallery count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.menu isEqualToString:@"Foods"]) {
        return 90;
    }
    if ([self.menu isEqualToString:@"Drinks"]) {
        return 90;
    }
    if ([self.menu isEqualToString:@"Activity"]) {
        return 0;
    }
    if ([self.menu isEqualToString:@"Gallery"]) {
        return 110;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if ([self.menu isEqualToString:@"Foods"]) {
        PFFoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFFoodsCell"];
        if(cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFFoodsCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *img = [[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"];
        NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"custom/100/100/"];
        
        [DLImageLoader loadImageFromURL:urlimg
                              completed:^(NSError *error, NSData *imgData) {
                                  cell.image.image = [UIImage imageWithData:imgData];
                              }];
        
        cell.name.text = [[NSString alloc] initWithString:[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"name"]];
        cell.price.text = [[NSString alloc] initWithFormat:@"%@",[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"price"]];
        
        cell.detail.text = [[NSString alloc] initWithString:[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"detail"]];
        
        return cell;
    }
    if ([self.menu isEqualToString:@"Drinks"]) {
        PFDrinkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFDrinkCell"];
        if(cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFDrinkCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *img = [[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"];
        NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"custom/100/100/"];
        
        [DLImageLoader loadImageFromURL:urlimg
                              completed:^(NSError *error, NSData *imgData) {
                                  cell.image.image = [UIImage imageWithData:imgData];
                              }];
        
        cell.name.text = [[NSString alloc] initWithString:[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"name"]];
        cell.price.text = [[NSString alloc] initWithFormat:@"%@",[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"price"]];
        
        cell.detail.text = [[NSString alloc] initWithString:[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"detail"]];
        
        return cell;
    }
    if ([self.menu isEqualToString:@"Gallery"]) {
        PFGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFGalleryCell"];
        if(cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFGalleryCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *img = [[[self.arrObjGallery objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"];
        NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"custom/79/79/"];
        
        [DLImageLoader loadImageFromURL:urlimg
                              completed:^(NSError *error, NSData *imgData) {
                                  cell.image.image = [UIImage imageWithData:imgData];
                              }];
        
        cell.name.text = [[NSString alloc] initWithString:[[self.arrObjGallery objectAtIndex:indexPath.row] objectForKey:@"name"]];
        cell.detail.text = [[NSString alloc] initWithString:[[self.arrObjGallery objectAtIndex:indexPath.row] objectForKey:@"detail"]];
        
        return cell;
    }
    
    return cell;
}

//food
- (IBAction)foodsTapped:(id)sender{
    self.tableView.hidden = NO;
    self.CalendarView.hidden = YES;
    self.foodsBt.backgroundColor = [UIColor clearColor];
    [self.foodsBt.titleLabel setTextColor:[UIColor whiteColor]];
    self.drinksBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.drinksBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.activityBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.activityBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.galleryBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.galleryBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.menu = @"Foods";
    [self.RatreeSamosornApi getFoods];
}

//drink
- (IBAction)drinksTapped:(id)sender{
    self.tableView.hidden = NO;
    self.CalendarView.hidden = YES;
    self.foodsBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.foodsBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.drinksBt.backgroundColor = [UIColor clearColor];
    [self.drinksBt.titleLabel setTextColor:[UIColor whiteColor]];
    self.activityBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.activityBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.galleryBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.galleryBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.menu = @"Drinks";
    [self.RatreeSamosornApi getDrinks];
}

//activity
- (IBAction)activityTapped:(id)sender{
    self.tableView.hidden = YES;
    self.CalendarView.hidden = NO;
    self.foodsBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.foodsBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.drinksBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.drinksBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.activityBt.backgroundColor = [UIColor clearColor];
    [self.activityBt.titleLabel setTextColor:[UIColor whiteColor]];
    self.galleryBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.galleryBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.menu = @"Activity";
}

//gallery
- (IBAction)galleryTapped:(id)sender{
    self.tableView.hidden = NO;
    self.CalendarView.hidden = YES;
    self.foodsBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.foodsBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.drinksBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.drinksBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.activityBt.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1];
    [self.activityBt.titleLabel setTextColor:RGB(109, 110, 113)];
    self.galleryBt.backgroundColor = [UIColor clearColor];
    [self.galleryBt.titleLabel setTextColor:[UIColor whiteColor]];
    self.menu = @"Gallery";
    [self.RatreeSamosornApi getGallery];
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
        refreshDataMenu = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ( scrollView.contentOffset.y < -100.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
        self.tableView.frame = CGRectMake(0, 50, 320, self.tableView.frame.size.height);
		[UIView commitAnimations];
        [self performSelector:@selector(resizeTable) withObject:nil afterDelay:2];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));
    if (offset >= 0 && offset <= 5) {
        if (!noDataMenu) {
            refreshDataMenu = NO;
            
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

@end
