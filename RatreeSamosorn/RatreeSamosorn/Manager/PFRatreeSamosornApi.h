//
//  PFRatreeSamosornApi.h
//  RatreeSamosorn
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol PFRatreeSamosornApiDelegate <NSObject>

#pragma mark - login facebook token
- (void)PFRatreeSamosornApi:(id)sender loginWithFacebookTokenResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender loginWithFacebookTokenErrorResponse:(NSString *)errorResponse;

#pragma mark - login with username password
- (void)PFRatreeSamosornApi:(id)sender loginWithPasswordResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender loginWithPasswordErrorResponse:(NSString *)errorResponse;

#pragma mark - Register
- (void)PFRatreeSamosornApi:(id)sender registerWithUsernameResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender registerWithUsernameErrorResponse:(NSString *)errorResponse;

#pragma mark - User
- (void)PFRatreeSamosornApi:(id)sender meResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender meErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getUserSettingResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse;

#pragma mark - User Setting
- (void)PFRatreeSamosornApi:(id)sender settingNewsResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender settingNewsErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender settingMessageResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender settingMessageErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender changPasswordResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender changPasswordErrorResponse:(NSString *)errorResponse;

#pragma mark - Menu Protocal Delegate
- (void)PFRatreeSamosornApi:(id)sender getFoodsResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getFoodsErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getFoodsAndDrinkByURLResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getFoodsAndDrinkByURLErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getDrinksResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getDrinksErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getFolderTypeByURLResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getFolderTypeByURLErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getGalleryResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getGalleryErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender galleryPictureByURLResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender galleryPictureByURLErrorResponse:(NSString *)errorResponse;

#pragma mark - Member Protocal Delegate
- (void)PFRatreeSamosornApi:(id)sender getStampStyleResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getStampStyleErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getStampResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getStampErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender addPointResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender addPointErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getHistoryResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getHistoryErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getRewardResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getRewardErrorResponse:(NSString *)errorResponse;

#pragma mark - Contact Protocal Delegate
- (void)PFRatreeSamosornApi:(id)sender getContactResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getContactErrorResponse:(NSString *)errorResponse;

- (void)PFRatreeSamosornApi:(id)sender getContactGalleryResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getContactGalleryErrorResponse:(NSString *)errorResponse;

@end

@interface PFRatreeSamosornApi : NSObject

#pragma mark - Property
@property (assign, nonatomic) id delegate;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;
@property NSString *urlStr;

#pragma mark - Reset App
- (void)saveReset:(NSString *)reset;
- (NSString *)getReset;

#pragma mark - App Language
- (void)saveLanguage:(NSString *)language;
- (NSString *)getLanguage;

#pragma mark - User_id
- (void)saveUserId:(NSString *)user_id;
- (void)saveAccessToken:(NSString *)access_token;

- (NSString *)getUserId;
- (NSString *)getAccessToken;

#pragma mark - Check Login
- (BOOL)checkLogin;

#pragma mark - Login
- (void)loginWithFacebookToken:(NSString *)fb_token ios_device_token:(NSString *)ios_device_token;
- (void)loginWithPassword:(NSString *)username password:(NSString *)password;

#pragma mark - LogOut
- (void)logOut;

#pragma mark - Register
- (void)registerWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email birth_date:(NSString *)birth_date gender:(NSString *)gender;

#pragma mark - User
- (void)me;
- (void)getUserSetting;

#pragma mark - User Setting
- (void)settingNews:(NSString *)status;
- (void)settingMessage:(NSString *)status;
- (void)settingUser:(NSString *)obj1 email:(NSString *)obj2 website:(NSString *)obj3 tel:(NSString *)obj4 gender:(NSString *)obj5 birthday:(NSString *)obj6;
- (void)userPictureUpload:(NSString *)picture_base64;
- (void)updateSetting:(NSString *)profilename email:(NSString *)email website:(NSString *)website tel:(NSString *)tel gender:(NSString *)gender birthday:(NSString *)birthday;
- (void)changePassword:(NSString *)old_password new_password:(NSString *)new_password;

#pragma mark - Menu
- (void)getFoods;
- (void)getFoodsAndDrinkByURL:(NSString *)url;
- (void)getDrinks;
- (void)getFolderTypeByURL:(NSString *)url;
- (void)getGallery;
- (void)galleryPictureByURL:(NSString *)url;

#pragma mark - Member
- (void)getStampStyle;
- (void)getStamp;
- (void)addPoint:(NSString *)point password:(NSString *)password;
- (void)history;
- (void)getReward;

#pragma mark - Contact
- (void)getContact;
- (void)getContactGallery;

@end
