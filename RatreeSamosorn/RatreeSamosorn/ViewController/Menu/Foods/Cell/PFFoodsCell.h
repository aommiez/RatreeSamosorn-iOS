//
//  PFFoodsCell.h
//  RatreeSamosorn
//
//  Created by Pariwat on 8/2/14.
//  Copyright (c) 2014 platwofusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFFoodsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *detail;

@end
