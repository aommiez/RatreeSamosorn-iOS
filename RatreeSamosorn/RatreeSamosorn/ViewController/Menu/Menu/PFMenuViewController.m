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

NSString *totalImg;
NSString *titleText;
NSString *detailText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        self.foodOffline = [NSUserDefaults standardUserDefaults];
        self.drinkOffline = [NSUserDefaults standardUserDefaults];
        self.galleryOffline = [NSUserDefaults standardUserDefaults];
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
        [self.foodsBt setTitle:@"Foods" forState:UIControlStateNormal];
        [self.drinksBt setTitle:@"Drinks" forState:UIControlStateNormal];
        [self.activityBt setTitle:@"Activity" forState:UIControlStateNormal];
        [self.galleryBt setTitle:@"Gallery" forState:UIControlStateNormal];
    } else {
        self.navItem.title = @"รายการ";
        [self.foodsBt setTitle:@"อาหาร" forState:UIControlStateNormal];
        [self.drinksBt setTitle:@"เครื่องดื่ม" forState:UIControlStateNormal];
        [self.activityBt setTitle:@"กิจกรรม" forState:UIControlStateNormal];
        [self.galleryBt setTitle:@"อัลบั้ม" forState:UIControlStateNormal];
    }
    
    UIView *hv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    self.tableView.tableHeaderView = hv;
    UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)];
    self.tableView.tableFooterView = fv;
    
    self.CalendarView.hidden = YES;
    
    refreshDataMenu = YES;
    
    self.arrObjFood = [[NSMutableArray alloc] init];
    self.arrObjDrink = [[NSMutableArray alloc] init];
    self.arrObjGallery = [[NSMutableArray alloc] init];
    self.arrObjGalleryAlbum = [[NSMutableArray alloc] init];
    self.sum = [[NSMutableArray alloc] init];
    
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
    
    //self.viewController = [PFActivityCalendarViewController new];
    //[self.CalendarView addSubview:self.viewController.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)PFRatreeSamosornApi:(id)sender getFoodsResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
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
    
    [self.foodOffline setObject:response forKey:@"foodArray"];
    [self.foodOffline synchronize];
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getFoodsErrorResponse:(NSString *)errorResponse {
    //NSLog(@"%@",errorResponse);
    
    self.menu = @"Foods";
    
    if (!refreshDataMenu) {
        for (int i=0; i<[[[self.foodOffline objectForKey:@"foodArray"] objectForKey:@"data"] count]; ++i) {
            [self.arrObjFood addObject:[[[self.foodOffline objectForKey:@"foodArray"] objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjFood removeAllObjects];
        for (int i=0; i<[[[self.foodOffline objectForKey:@"foodArray"] objectForKey:@"data"] count]; ++i) {
            [self.arrObjFood addObject:[[[self.foodOffline objectForKey:@"foodArray"] objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getDrinksResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
    self.menu = @"Drinks";
    
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
    
    [self.drinkOffline setObject:response forKey:@"drinkArray"];
    [self.drinkOffline synchronize];
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getDrinksErrorResponse:(NSString *)errorResponse {
    //NSLog(@"%@",errorResponse);
    
    self.menu = @"Drinks";
    
    if (!refreshDataMenu) {
        for (int i=0; i<[[[self.drinkOffline objectForKey:@"drinkArray"] objectForKey:@"data"] count]; ++i) {
            [self.arrObjDrink addObject:[[[self.drinkOffline objectForKey:@"drinkArray"] objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjDrink removeAllObjects];
        for (int i=0; i<[[[self.drinkOffline objectForKey:@"drinkArray"] objectForKey:@"data"] count]; ++i) {
            [self.arrObjDrink addObject:[[[self.drinkOffline objectForKey:@"drinkArray"] objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getGalleryResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
    self.menu = @"Gallery";
    
    if (!refreshDataMenu) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjGalleryAlbum addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjGalleryAlbum removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjGalleryAlbum addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.galleryOffline setObject:response forKey:@"galleryArray"];
    [self.galleryOffline synchronize];
    
    [self.tableView reloadData];
}

- (void)PFRatreeSamosornApi:(id)sender getGalleryErrorResponse:(NSString *)errorResponse {
    //NSLog(@"%@",errorResponse);
    
    self.menu = @"Gallery";
    
    if (!refreshDataMenu) {
        for (int i=0; i<[[[self.galleryOffline objectForKey:@"galleryArray"] objectForKey:@"data"] count]; ++i) {
            [self.arrObjGalleryAlbum addObject:[[[self.galleryOffline objectForKey:@"galleryArray"] objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjGalleryAlbum removeAllObjects];
        for (int i=0; i<[[[self.galleryOffline objectForKey:@"galleryArray"] objectForKey:@"data"] count]; ++i) {
            [self.arrObjGalleryAlbum addObject:[[[self.galleryOffline objectForKey:@"galleryArray"] objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
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
        return [self.arrObjGalleryAlbum count];
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
        
        if ([[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"product"]) {
        
            PFFoldertypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFFoldertypeCell"];
            if(cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFFoldertypeCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.image.layer.masksToBounds = YES;
            cell.image.contentMode = UIViewContentModeScaleAspectFill;
            
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
            
        } else {
        
            PFFoldertype1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFFoldertype1Cell"];
            if(cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFFoldertype1Cell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.thumbnails.layer.masksToBounds = YES;
            cell.thumbnails.contentMode = UIViewContentModeScaleAspectFill;
            
            NSString *img = [[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"];
            NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"custom/100/100/"];
            
            [DLImageLoader loadImageFromURL:urlimg
                                  completed:^(NSError *error, NSData *imgData) {
                                      cell.thumbnails.image = [UIImage imageWithData:imgData];
                                  }];
            
            cell.name.text = [[NSString alloc] initWithString:[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            return cell;
            
        }
        
    }
    if ([self.menu isEqualToString:@"Drinks"]) {
        
        if ([[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"product"]) {
            
            PFFoldertypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFFoldertypeCell"];
            if(cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFFoldertypeCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.image.layer.masksToBounds = YES;
            cell.image.contentMode = UIViewContentModeScaleAspectFill;
            
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
            
        } else {
            
            PFFoldertype1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFFoldertype1Cell"];
            if(cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFFoldertype1Cell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.thumbnails.layer.masksToBounds = YES;
            cell.thumbnails.contentMode = UIViewContentModeScaleAspectFill;
            
            NSString *img = [[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"];
            NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"custom/100/100/"];
            
            [DLImageLoader loadImageFromURL:urlimg
                                  completed:^(NSError *error, NSData *imgData) {
                                      cell.thumbnails.image = [UIImage imageWithData:imgData];
                                  }];
            
            cell.name.text = [[NSString alloc] initWithString:[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            return cell;
            
        }

    }
    if ([self.menu isEqualToString:@"Gallery"]) {
        PFGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFGalleryCell"];
        if(cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFGalleryCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.image.layer.masksToBounds = YES;
        cell.image.contentMode = UIViewContentModeScaleAspectFill;
        
        NSString *img = [[[self.arrObjGalleryAlbum objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"];
        NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"custom/79/79/"];
        
        [DLImageLoader loadImageFromURL:urlimg
                              completed:^(NSError *error, NSData *imgData) {
                                  cell.image.image = [UIImage imageWithData:imgData];
                              }];
        
        cell.name.text = [[NSString alloc] initWithString:[[self.arrObjGalleryAlbum objectAtIndex:indexPath.row] objectForKey:@"name"]];
        cell.detail.text = [[NSString alloc] initWithString:[[self.arrObjGalleryAlbum objectAtIndex:indexPath.row] objectForKey:@"detail"]];
        
        return cell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.menu isEqualToString:@"Foods"]) {
        
        self.navItem.title = @" ";
        [self.delegate HideTabbar];
        
        if ([[[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"product"]) {
            
            PFFoodAndDrinkDetailViewController *detailView = [[PFFoodAndDrinkDetailViewController alloc] init];
            if(IS_WIDESCREEN) {
                detailView = [[PFFoodAndDrinkDetailViewController alloc] initWithNibName:@"PFFoodAndDrinkDetailViewController_Wide" bundle:nil];
            } else {
                detailView = [[PFFoodAndDrinkDetailViewController alloc] initWithNibName:@"PFFoodAndDrinkDetailViewController" bundle:nil];
            }
            detailView.obj = [self.arrObjFood objectAtIndex:indexPath.row];
            detailView.delegate = self;
            [self.navController pushViewController:detailView animated:YES];
            
        } else {
            
            PFDetailFoldertypeViewController *foldertypeView = [[PFDetailFoldertypeViewController alloc] init];
            if(IS_WIDESCREEN) {
                foldertypeView = [[PFDetailFoldertypeViewController alloc] initWithNibName:@"PFDetailFoldertypeViewController_Wide" bundle:nil];
            } else {
                foldertypeView = [[PFDetailFoldertypeViewController alloc] initWithNibName:@"PFDetailFoldertypeViewController" bundle:nil];
            }
            foldertypeView.obj = [self.arrObjFood objectAtIndex:indexPath.row];
            foldertypeView.folder_id = [[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"id"];
            foldertypeView.delegate = self;
            [self.navController pushViewController:foldertypeView animated:YES];
        
        }
    }
    if ([self.menu isEqualToString:@"Drinks"]) {
        
        self.navItem.title = @" ";
        [self.delegate HideTabbar];
        
        if ([[[self.arrObjDrink objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"product"]) {
            
            PFFoodAndDrinkDetailViewController *detailView = [[PFFoodAndDrinkDetailViewController alloc] init];
            if(IS_WIDESCREEN) {
                detailView = [[PFFoodAndDrinkDetailViewController alloc] initWithNibName:@"PFFoodAndDrinkDetailViewController_Wide" bundle:nil];
            } else {
                detailView = [[PFFoodAndDrinkDetailViewController alloc] initWithNibName:@"PFFoodAndDrinkDetailViewController" bundle:nil];
            }
            detailView.obj = [self.arrObjDrink objectAtIndex:indexPath.row];
            detailView.delegate = self;
            [self.navController pushViewController:detailView animated:YES];
            
        } else {
            
            PFDetailFoldertypeViewController *foldertypeView = [[PFDetailFoldertypeViewController alloc] init];
            if(IS_WIDESCREEN) {
                foldertypeView = [[PFDetailFoldertypeViewController alloc] initWithNibName:@"PFDetailFoldertypeViewController_Wide" bundle:nil];
            } else {
                foldertypeView = [[PFDetailFoldertypeViewController alloc] initWithNibName:@"PFDetailFoldertypeViewController" bundle:nil];
            }
            foldertypeView.obj = [self.arrObjFood objectAtIndex:indexPath.row];
            foldertypeView.folder_id = [[self.arrObjFood objectAtIndex:indexPath.row] objectForKey:@"id"];
            foldertypeView.delegate = self;
            [self.navController pushViewController:foldertypeView animated:YES];
            
        }
        
    }
    if ([self.menu isEqualToString:@"Gallery"]) {
        
        totalImg = [[self.arrObjGalleryAlbum objectAtIndex:indexPath.row] objectForKey:@"picture_length"];
        titleText = [[self.arrObjGalleryAlbum objectAtIndex:indexPath.row] objectForKey:@"name"];
        detailText = [[self.arrObjGalleryAlbum objectAtIndex:indexPath.row] objectForKey:@"detail"];
        
        [self.arrObjGallery removeAllObjects];
        [self.sum removeAllObjects];
        
        [self.RatreeSamosornApi galleryPictureByURL:[[[self.arrObjGalleryAlbum objectAtIndex:indexPath.row] objectForKey:@"node"] objectForKey:@"pictures"]];
        
    }
    
}

- (void)PFRatreeSamosornApi:(id)sender galleryPictureByURLResponse:(NSDictionary *)response {
    
    for (int i = 0; i < [[response objectForKey:@"data"] count]; i++) {
        
        [self.arrObjGallery addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        
    }
    
    for (int i = 0; i < [[response objectForKey:@"data"] count]; i++) {
        
        [self.sum addObject:[[self.arrObjGallery objectAtIndex:i] objectForKey:@"url"]];
        
    }
    
    self.navItem.title = @" ";
    
    [self.delegate HideTabbar];
    
    PFGalleryViewController *showcaseGallery = [[PFGalleryViewController alloc] init];
    
    if (IS_WIDESCREEN) {
        showcaseGallery = [[PFGalleryViewController alloc] initWithNibName:@"PFGalleryViewController_Wide" bundle:nil];
    } else {
        showcaseGallery = [[PFGalleryViewController alloc] initWithNibName:@"PFGalleryViewController" bundle:nil];
    }
    
    showcaseGallery.delegate = self;
    
    showcaseGallery.arrObj = self.arrObjGallery;
    showcaseGallery.sumimg = self.sum;
    showcaseGallery.totalImg = totalImg;
    showcaseGallery.titleText = titleText;
    showcaseGallery.detailText = detailText;
    
    [self.navController pushViewController:showcaseGallery animated:YES];
    
}

- (void)PFRatreeSamosornApi:(id)sender galleryPictureByURLErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
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
        
        self.RatreeSamosornApi = [[PFRatreeSamosornApi alloc] init];
        self.RatreeSamosornApi.delegate = self;
        
        if ([self.menu isEqualToString:@"Foods"]) {
            NSLog(@"Foods");
            [self.RatreeSamosornApi getFoods];
        } else if ([self.menu isEqualToString:@"Drinks"]) {
            NSLog(@"Drinks");
            [self.RatreeSamosornApi getDrinks];
        } else if ([self.menu isEqualToString:@"Gallery"]) {
            NSLog(@"Gallery");
            [self.RatreeSamosornApi getGallery];
        }
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
            
             self.RatreeSamosornApi = [[PFRatreeSamosornApi alloc] init];
             self.RatreeSamosornApi.delegate = self;
            
            if ([self.menu isEqualToString:@"Foods"]) {
                NSLog(@"Foods");
                [self.RatreeSamosornApi getFoods];
            } else if ([self.menu isEqualToString:@"Drinks"]) {
                NSLog(@"Drinks");
                [self.RatreeSamosornApi getDrinks];
            } else if ([self.menu isEqualToString:@"Gallery"]) {
                NSLog(@"Gallery");
                [self.RatreeSamosornApi getGallery];
            }
        }
    }
}

- (void)resizeTable {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
}

- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link{
    [self.delegate PFImageViewController:self viewPicture:link];
}

- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current{
    [self.delegate PFGalleryViewController:self sum:sum current:current];
}

- (void)PFDetailFoldertypeViewControllerBack {
    [self.delegate ShowTabbar];
    if (![[self.RatreeSamosornApi getLanguage] isEqualToString:@"TH"]) {
        self.navItem.title = @"Menu";
    } else {
        self.navItem.title = @"รายการ";
    }
}

- (void)PFFoodAndDrinkDetailViewControllerBack {
    [self.delegate ShowTabbar];
    if (![[self.RatreeSamosornApi getLanguage] isEqualToString:@"TH"]) {
        self.navItem.title = @"Menu";
    } else {
        self.navItem.title = @"รายการ";
    }
}

- (void)PFGalleryViewControllerBack {
    [self.delegate ShowTabbar];
    if (![[self.RatreeSamosornApi getLanguage] isEqualToString:@"TH"]) {
        self.navItem.title = @"Menu";
    } else {
        self.navItem.title = @"รายการ";
    }
}

@end
