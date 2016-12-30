//
//  FormLayout.h
//  PhotoForm
//
//  Created by zhaozq on 2016/12/30.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormLayout : UICollectionViewFlowLayout

@end

@interface FormLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIColor *color;

@end

@interface FormReusableView : UICollectionReusableView

@end
