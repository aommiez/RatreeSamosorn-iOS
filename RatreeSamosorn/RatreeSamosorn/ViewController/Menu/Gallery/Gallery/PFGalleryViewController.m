//
//  ViewController.m
//  TestCollectionViewWithXIB
//
//  Created by Quy Sang Le on 2/3/13.
//  Copyright (c) 2013 Quy Sang Le. All rights reserved.
//

#import "PFGalleryViewController.h"
#import "HeaderView.h"

@interface PFGalleryViewController ()

@end

@implementation PFGalleryViewController

NSArray *image;
UIImage *theimage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *headerNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.totalImg intValue];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    headerView.title.text = self.titleText;
    headerView.detail.text = self.detailText;
    
    return headerView;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (MyCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@",[self.sumimg objectAtIndex:indexPath.row]];
    
    cell.img.layer.masksToBounds = YES;
    cell.img.contentMode = UIViewContentModeScaleAspectFill;
    
    [DLImageLoader loadImageFromURL:url
                          completed:^(NSError *error, NSData *imgData) {
                              cell.img.image = [UIImage imageWithData:imgData];
                          }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *num = [NSString stringWithFormat:@"%lu",indexPath.row];
    //[self.delegate PFFullimageViewController:self.sumimg current:num];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if (self.navigationController.visibleViewController != self) {
        if([self.delegate respondsToSelector:@selector(PFGalleryViewControllerBack)]){
            [self.delegate PFGalleryViewControllerBack];
        }
    }
    
}

@end