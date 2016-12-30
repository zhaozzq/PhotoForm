//
//  PhotoCell.h
//  PhotoForm
//
//  Created by zhaozq on 2016/12/30.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoCell;
@protocol PhotoCellDelegate <NSObject>

- (void)removePhotoCell:(nullable PhotoCell *)cell;

@end

extern  NSString *_Nullable kPhotoCellIdentifier;

@interface PhotoCell : UICollectionViewCell

@property (strong, nonatomic, nullable) NSIndexPath *indexPath;

@property (assign, nonatomic) BOOL isAddItem;

@property (strong, nonatomic, nullable) UIImage *photo;

@property (weak, nonatomic, nullable) id<PhotoCellDelegate> delegate;

@end
