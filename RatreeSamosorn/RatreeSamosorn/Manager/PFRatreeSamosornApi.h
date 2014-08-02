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

#pragma mark - Contact Protocal Delegate
- (void)PFRatreeSamosornApi:(id)sender getContactResponse:(NSDictionary *)response;
- (void)PFRatreeSamosornApi:(id)sender getContactErrorResponse:(NSString *)errorResponse;

@end

@interface PFRatreeSamosornApi : NSObject

#pragma mark - Property
@property (assign, nonatomic) id delegate;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;

#pragma mark - App Language
- (void)saveLanguage:(NSString *)language;
- (NSString *)getLanguage;

#pragma mark - Contact
- (void)getContact;

@end
