//
//  PEActivityCalendarViewController.h
//  ราตรีสโมสร
//
//  Created by Pariwat on 7/30/14.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import "TKCalendarMonthTableViewController.h"
#import "TapkuLibrary.h"
#import "NSDate+Helper.h"
#import "AFNetworking.h"
#import "monthCell.h"

@protocol PFActivityCalendarViewControllerDelegate <NSObject>

//- (void)PFActivityCalendarViewController:(id)sender viewPicture:(NSString *)link;

@end

@interface PFActivityCalendarViewController : TKCalendarMonthTableViewController

@property (assign, nonatomic) id delegate;
@property (nonatomic, strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *actArray;
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;
@property (nonatomic, strong) NSMutableDictionary *stuDictionary;
@property (nonatomic, strong) NSMutableDictionary *actDictionary;
@property (nonatomic, strong) NSDictionary *obj;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, strong) NSMutableArray *allDataArray;

- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;

@end
