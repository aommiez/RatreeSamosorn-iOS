//
//  PFRewardViewController.h
//  ราตรีสโมสร
//
//  Created by Pariwat on 8/1/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFRewardViewControllerDelegate <NSObject>

- (void)PFRewardViewControllerBack;

@end

@interface PFRewardViewController : UIViewController

@property (assign, nonatomic) id delegate;

@end
