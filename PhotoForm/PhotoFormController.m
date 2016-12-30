//
//  ViewController.m
//  PhotoForm
//
//  Created by zhaozq on 2016/12/30.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "PhotoFormController.h"

#import "PhotoCell.h"
#import "FormHeader.h"
#import "FormLayout.h"

static NSString *kBlankFooterView = @"kBlankFooterView";

@interface PhotoFormController () <UICollectionViewDelegate, UICollectionViewDataSource, PhotoCellDelegate>

@property (assign, nonatomic) NSInteger number0;
@property (assign, nonatomic) NSInteger number1;

@end

@implementation PhotoFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _number0 = 1;
    _number1 = 7;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:kPhotoCellIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kPhotoCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:kFormHeaderIdentifer bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFormHeaderIdentifer];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kBlankFooterView];
    
    FormLayout *layout = [[FormLayout alloc] init];
    layout.itemSize = CGSizeMake(80.0f, 80.0f);
    self.collectionView.collectionViewLayout = layout;
}

- (void)removePhotoCell:(PhotoCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath.section == 1) {
        if (_number1 > 0) {
            _number1 --;
        }
    }
    else
    {
        if (_number0 > 0) {
            _number0 --;
        }
    }
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1)
    {
        return _number1;
    }
    else
    {
        return _number0;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellIdentifier forIndexPath:indexPath];
    cell.indexPath = [indexPath copy];
    cell.delegate = self;
    
    cell.photo = [UIImage imageNamed:@"cat"];
    if (indexPath.section == 1) {
        cell.isAddItem = indexPath.row == _number1 - 1;
    }
    else
    {
        cell.isAddItem = indexPath.row == _number0 - 1;
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    //Warning layout.minimumLineSpacing是为了矫正ApplicationDataLayout最后一行FormLayoutAttributes多算一个 layout.minimumLineSpacing
    
    return CGSizeMake(self.view.frame.size.width, 12 + ((UICollectionViewFlowLayout *)collectionViewLayout).minimumLineSpacing);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        FormHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kFormHeaderIdentifer forIndexPath:indexPath];
        return header;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *blankFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kBlankFooterView forIndexPath:indexPath];
        return blankFooter;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected item!");
    
    if (indexPath.section == 1) {
        if (indexPath.row == _number1 - 1)  //TODO: 判断是否是最后一个  Y：添加photo N：展示大图
        {
            _number1 ++;
            [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
        }
    }
    else
    {
        if (indexPath.row == _number0 - 1)  //TODO: 判断是否是最后一个  Y：添加photo N：展示大图
        {
            _number0 ++;
            [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
