//
//  PFMenuViewController.h
//  ราตรีสโมสร
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRGradientNavigationBar.h"

#import "PFRatreeSamosornApi.h"

#import "PFFoodsCell.h"
#import "PFGalleryCell.h"

@protocol PFMenuViewControllerDelegate <NSObject>

//- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current;
//- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link;
- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFRatreeSamosornApi *RatreeSamosornApi;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (strong, nonatomic) IBOutlet UILabel *loadLabel;

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (strong, nonatomic) IBOutlet CRGradientNavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *foodsBt;
@property (strong, nonatomic) IBOutlet UIButton *drinksBt;
@property (strong, nonatomic) IBOutlet UIButton *activityBt;
@property (strong, nonatomic) IBOutlet UIButton *galleryBt;

@property (strong, nonatomic) NSString *menu;

- (IBAction)foodsTapped:(id)sender;
- (IBAction)drinksTapped:(id)sender;
- (IBAction)activityTapped:(id)sender;
- (IBAction)galleryTapped:(id)sender;

@end
