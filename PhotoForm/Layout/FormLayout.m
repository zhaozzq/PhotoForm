//
//  FormLayout.h
//  PhotoForm
//
//  Created by zhaozq on 2016/12/30.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "FormLayout.h"

static NSString *kDecorationReuseIdentifier = @"section_background";

@implementation FormLayout

+ (Class)layoutAttributesClass
{
    return [FormLayoutAttributes class];
}

- (void)prepareLayout {
    [super prepareLayout];

    //self.itemSize = CGSizeMake(80.0f, 80.0f);
    //self.estimatedItemSize = CGSizeMake(100, 100);
    self.sectionInset = UIEdgeInsetsMake(0, 20, 6, 20);
    self.minimumInteritemSpacing = 1.0f;
    self.minimumLineSpacing = 10.f;
    
    [self registerClass:[FormReusableView class] forDecorationViewOfKind:kDecorationReuseIdentifier];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:attributes];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        // Look for the first item in a row
        if (attribute.representedElementCategory == UICollectionElementCategoryCell
            && attribute.frame.origin.x == self.sectionInset.left) {
            
            // Create decoration attributes
            FormLayoutAttributes *decorationAttributes =
            [FormLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationReuseIdentifier
                                                                        withIndexPath:attribute.indexPath];
            
            // Make the decoration view span the entire row (you can do item by item as well.  I just
            // chose to do it this way)
            decorationAttributes.frame =
            CGRectMake(0,
                       attribute.frame.origin.y - self.sectionInset.top,
                       self.collectionViewContentSize.width,
                       self.itemSize.height + (self.minimumLineSpacing + self.sectionInset.top + self.sectionInset.bottom));
            //Warning: 最后一行多算一个 self.minimumLineSpacing
            
            // Set the zIndex to be behind the item
            decorationAttributes.zIndex = attribute.zIndex-1;
            
            // Add the attribute to the list
            [allAttributes addObject:decorationAttributes];
            
        }
        
    }
    
    return allAttributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:kDecorationReuseIdentifier]) {
        FormLayoutAttributes *decorationAttributes = [FormLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationReuseIdentifier
                                                                                                                           withIndexPath:indexPath];
        return decorationAttributes;
    }
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
    return attributes;
}
@end

@implementation FormLayoutAttributes

+ (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind
                                                                withIndexPath:(NSIndexPath *)indexPath {
    
    FormLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:decorationViewKind
                                                                                         withIndexPath:indexPath];
    layoutAttributes.color = [UIColor whiteColor];
    return layoutAttributes;
}

- (id)copyWithZone:(NSZone *)zone {
    FormLayoutAttributes *newAttributes = [super copyWithZone:zone];
    newAttributes.color = [self.color copyWithZone:zone];
    return newAttributes;
}

@end

@implementation FormReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    FormLayoutAttributes *attributes = (FormLayoutAttributes*)layoutAttributes;
    self.backgroundColor = attributes.color;
}

@end
