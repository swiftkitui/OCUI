//
//  DemoCollectionController.m
//  DriverListExample
//
//  Created by 张行 on 2019/8/20.
//  Copyright © 2019 张行. All rights reserved.
//

#import "DemoCollectionController.h"

@interface DemoCollectionController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DemoCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    if (self.configCollectionViewDriver) {
        self.configCollectionViewDriver(self.collectionView);
    }
}

#pragma mark - Getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
