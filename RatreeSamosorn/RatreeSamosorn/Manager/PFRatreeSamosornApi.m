//
//  PFRatreeSamosornApi.m
//  RatreeSamosorn
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import "PFRatreeSamosornApi.h"

@implementation PFRatreeSamosornApi

- (id) init
{
    if (self = [super init])
    {
        self.manager = [AFHTTPRequestOperationManager manager];
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.urlStr = [[NSString alloc] init];
    }
    return self;
}

#pragma mark - Reset
- (void)saveReset:(NSString *)reset {
    [self.userDefaults setObject:reset forKey:@"reset"];
}

- (NSString *)getReset {
    return [self.userDefaults objectForKey:@"reset"];
}

#pragma mark - App Language
- (void)saveLanguage:(NSString *)language {
    [self.userDefaults setObject:language forKey:@"language"];
}

- (NSString *)getLanguage {
    return [self.userDefaults objectForKey:@"language"];
}

#pragma mark - Check Log in
- (BOOL)checkLogin {
    if ([self.userDefaults objectForKey:@"user_id"] != nil || [self.userDefaults objectForKey:@"access_token"] != nil) {
        return true;
    } else {
        return false;
    }
}

#pragma mark - Log out
- (void)logOut {
    [self.userDefaults removeObjectForKey:@"access_token"];
    [self.userDefaults removeObjectForKey:@"user_id"];
}

#pragma mark - User ID
- (void)saveUserId:(NSString *)user_id {
    [self.userDefaults setObject:user_id forKey:@"user_id"];
}

- (NSString *)getUserId {
    return [self.userDefaults objectForKey:@"user_id"];
}

#pragma mark - Access Token
- (void)saveAccessToken:(NSString *)access_token {
    [self.userDefaults setObject:access_token forKey:@"access_token"];
}

- (NSString *)getAccessToken {
    return [self.userDefaults objectForKey:@"access_token"];
}

#pragma mark - Login
- (void)loginWithFacebookToken:(NSString *)fb_token ios_device_token:(NSString *)ios_device_token {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@oauth/facebook",API_URL];
    NSDictionary *parameters = @{@"facebook_token":fb_token};
    [self.manager POST:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self loginWithFacebookTokenResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self loginWithFacebookTokenErrorResponse:[error localizedDescription]];
    }];
    
}

- (void)loginWithPassword:(NSString *)username password:(NSString *)password {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@oauth/password",API_URL];
    NSDictionary *parameters = @{@"username":username , @"password":password};
    [self.manager POST:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self loginWithPasswordResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self loginWithPasswordErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - Register
- (void)registerWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email birth_date:(NSString *)birth_date gender:(NSString *)gender {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@register",API_URL];
    NSDictionary *parameters = @{@"username":username , @"password":password , @"email":email ,@"birth_date":birth_date , @"gender":gender};
    [self.manager POST:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self registerWithUsernameResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self registerWithUsernameErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - Me
- (void)me {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@me?access_token=%@",API_URL,[self getAccessToken]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self meResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self meErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - User
- (void)getUserSetting {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/setting/%@",API_URL,[self getUserId]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getUserSettingResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getUserSettingErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - User Setting
- (void)settingNews:(NSString *)status {
    self.urlStr= [[NSString alloc] initWithFormat:@"%@user/setting/%@",API_URL,[self getUserId]];
    NSDictionary *parameters = @{@"notify_update":status };
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Auth-Token"];
    [self.manager PUT:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self settingNewsResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self settingNewsErrorResponse:[error localizedDescription]];
    }];
}

- (void)settingMessage:(NSString *)status {
    self.urlStr= [[NSString alloc] initWithFormat:@"%@user/setting/%@",API_URL,[self getUserId]];
    NSDictionary *parameters = @{@"notify_message":status };
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Auth-Token"];
    [self.manager PUT:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self settingNewsResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self settingNewsErrorResponse:[error localizedDescription]];
    }];
}

- (void)settingUser:(NSString *)obj1 email:(NSString *)obj2 website:(NSString *)obj3 tel:(NSString *)obj4 gender:(NSString *)obj5 birthday:(NSString *)obj6 {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/setting/%@",API_URL,[self getUserId]];
    NSDictionary *parameters = @{@"show_facebook":obj1 , @"show_email":obj2 , @"show_website":obj3 , @"show_mobile":obj4 , @"show_gender":obj5 , @"show_birth_date":obj6};
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Auth-Token"];
    [self.manager PUT:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getUserSettingResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getUserSettingErrorResponse:[error localizedDescription]];
    }];
}

- (void)userPictureUpload:(NSString *)picture_base64 {
    NSDictionary *parameters = @{@"picture":picture_base64};
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/%@",API_URL,[self getUserId]];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Auth-Token"];
    [self.manager PUT:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self meResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self meErrorResponse:[error localizedDescription]];
    }];
}

- (void)updateSetting:(NSString *)profilename email:(NSString *)email website:(NSString *)website tel:(NSString *)tel gender:(NSString *)gender birthday:(NSString *)birthday {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/%@",API_URL,[self getUserId]];
    NSDictionary *parameters = @{@"display_name":profilename , @"email":email , @"website":website , @"mobile":tel , @"gender":gender , @"birth_date":birthday};
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Auth-Token"];
    [self.manager PUT:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getUserSettingResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getUserSettingErrorResponse:[error localizedDescription]];
    }];
}

- (void)changePassword:(NSString *)old_password new_password:(NSString *)new_password {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/change_password/%@",API_URL,[self getUserId]];
    NSDictionary *parameters = @{@"old_password":old_password , @"new_password":new_password  };
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Auth-Token"];
    [self.manager PUT:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self changPasswordResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self changPasswordErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - Menu
- (void)getFoods {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@node/food",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getFoodsResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getFoodsErrorResponse:[error localizedDescription]];
    }];
}

- (void)getFoodsAndDrinkByURL:(NSString *)url {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@",url];
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getFoodsAndDrinkByURLResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getFoodsAndDrinkByURLErrorResponse:[error localizedDescription]];
    }];
}

- (void)getDrinks {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@node/drink",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getDrinksResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getDrinksErrorResponse:[error localizedDescription]];
    }];
}

- (void)getFolderTypeByURL:(NSString *)url {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@",url];
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getFolderTypeByURLResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getFolderTypeByURLErrorResponse:[error localizedDescription]];
    }];
}

- (void)getGallery {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@node/gallery",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getGalleryResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getGalleryErrorResponse:[error localizedDescription]];
    }];
}

- (void)galleryPictureByURL:(NSString *)url {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@%@",url,@"?limit=100"];
    self.manager = [AFHTTPRequestOperationManager manager];
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self galleryPictureByURLResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self galleryPictureByURLErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - Member
- (void)getStampStyle {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@stamp/style",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getStampStyleResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getStampStyleErrorResponse:[error localizedDescription]];
    }];
}

- (void)getStamp {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/stamp/%@",API_URL,[self getUserId]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getStampResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getStampErrorResponse:[error localizedDescription]];
    }];
}

- (void)addPoint:(NSString *)point password:(NSString *)password {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/stamp/add/%@",API_URL,[self getUserId]];
    NSDictionary *parameters = @{@"point":point , @"password":password  };
    [self.manager POST:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self addPointResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self addPointErrorResponse:[error localizedDescription]];
    }];
}

- (void)history {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/history/%@",API_URL,[self getUserId]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getHistoryResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getHistoryErrorResponse:[error localizedDescription]];
    }];
}

- (void)getReward {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@reward",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getRewardResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getRewardErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - contact
- (void)getContact {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@contact",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getContactResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getContactErrorResponse:[error localizedDescription]];
    }];
}

- (void)getContactGallery {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@contact/picture",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFRatreeSamosornApi:self getContactGalleryResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFRatreeSamosornApi:self getContactGalleryErrorResponse:[error localizedDescription]];
    }];
}

@end
