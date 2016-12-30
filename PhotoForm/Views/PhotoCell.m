//
//  PhotoCell.m
//  PhotoForm
//
//  Created by zhaozq on 2016/12/30.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "PhotoCell.h"

NSString *kPhotoCellIdentifier = @"PhotoCell";

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsAddItem:(BOOL)isAddItem
{
    _isAddItem = isAddItem;
    _deleteButton.hidden = isAddItem;
    if (isAddItem) {
        _photoView.image = [UIImage imageNamed:@"add_photo"];
    }
}

- (void)setPhoto:(UIImage *)photo
{
    _photo = photo;
    _photoView.image = photo;
}
- (IBAction)deleteAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(removePhotoCell:)]) {
        [self.delegate removePhotoCell:self];
    }
}
@end
