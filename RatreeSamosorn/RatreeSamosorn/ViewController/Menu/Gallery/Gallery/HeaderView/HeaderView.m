//
//  RecipeCollectionHeaderView.m
//  CollectionViewDemo
//
//  Created by Simon on 22/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)headerTapped:(id)sender {
    [self.delegate header];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
