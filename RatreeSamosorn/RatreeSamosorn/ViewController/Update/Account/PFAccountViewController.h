//
//  PFAccountViewController.h
//  RatreeSamosorn
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AsyncImageView.h"

#import "PFRatreeSamosornApi.h"

#import "PFAccountCell.h"
#import "PFProfileViewController.h"
#import "PFLanguageViewController.h"

@protocol PFAccountViewControllerDelegate <NSObject>

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFAccountViewControllerBack;

@end

@interface PFAccountViewController : UIViewController < UITextViewDelegate >

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFRatreeSamosornApi *RatreeSamosornApi;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *bgEditView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) NSString *rowCount;

@property (strong, nonatomic) IBOutlet UIView *bgnewsView;
@property (strong, nonatomic) IBOutlet UIView *bgmessageView;

@property (strong, nonatomic) IBOutlet AsyncImageView *thumUser;
@property (strong, nonatomic) IBOutlet UITextField *display_name;

@property (strong, nonatomic) IBOutlet UIButton *logoutButton;

- (IBAction)editProfile:(id)sender;
- (IBAction)applanguage:(id)sender;

- (IBAction)switchNewsonoff:(id)sender;
- (IBAction)switchMessageonoff:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *switchNews;
@property (strong, nonatomic) IBOutlet UISwitch *switchMessage;

- (IBAction)logoutTapped:(id)sender;


@end