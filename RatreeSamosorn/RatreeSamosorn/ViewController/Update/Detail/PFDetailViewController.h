//
//  PFDetailViewController.h
//  ราตรีสโมสร
//
//  Created by Pariwat on 8/1/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFDetailCell.h"

@protocol PFDetailViewControllerDelegate <NSObject>

- (void)PFDetailViewControllerBack;

@end

@interface PFDetailViewController : UIViewController

@property (assign, nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *detailView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *textCommentView;

@end
