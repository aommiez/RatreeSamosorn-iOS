//
//  PFRatreeSamosornApi.h
//  RatreeSamosorn
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface PFRatreeSamosornApi : NSObject

#pragma mark - Property
@property (assign, nonatomic) id delegate;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;

#pragma mark - App Language
- (void)saveLanguage:(NSString *)language;
- (NSString *)getLanguage;

@end
