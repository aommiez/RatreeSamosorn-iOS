//
//  PFContactViewController.h
//  ราตรีสโมสร
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"
#import <MessageUI/MessageUI.h>
#import "CRGradientNavigationBar.h"
#import "UILabel+UILabelDynamicHeight.h"

#import "PFRatreeSamosornApi.h"

#import "PFMapViewController.h"

@protocol PFContactViewControllerDelegate <NSObject>

//- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current;
//- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link;
- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFContactViewController : UIViewController <MFMailComposeViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFRatreeSamosornApi *RatreeSamosornApi;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (strong, nonatomic) IBOutlet UILabel *loadLabel;

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (strong, nonatomic) IBOutlet CRGradientNavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *contentTxt;

@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;

@property (strong, nonatomic) IBOutlet UILabel *locationTxt;

@property (strong, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutlet UILabel *phoneTxt;
@property (strong, nonatomic) IBOutlet UILabel *websiteTxt;
@property (strong, nonatomic) IBOutlet UILabel *emailTxt;

@property (strong, nonatomic) IBOutlet UIView *powerbyView;

- (IBAction)mapTapped:(id)sender;
- (IBAction)phoneTapped:(id)sender;
- (IBAction)websiteTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)powerbyTapped:(id)sender;

@end
