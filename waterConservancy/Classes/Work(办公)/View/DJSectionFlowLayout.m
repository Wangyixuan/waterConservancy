//
//  DJSectionFlowLayout.m
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJSectionFlowLayout.h"
#import "DJSectionReuseView.h"

@implementation DJSectionFlowLayout
+ (Class)layoutAttributesClass
{
    return [UICollectionViewLayoutAttributes class];
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = 8.0f;
    self.minimumInteritemSpacing = 8.0f;
    self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    self.itemSize = CGSizeMake(148.0f, 115.0f);
    
    [self registerClass:[DJSectionReuseView class] forDecorationViewOfKind:@"collectionReuseid"];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:attributes];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        // Look for the first item in a row
        if (attribute.representedElementKind == UICollectionElementCategoryCell
            && attribute.frame.origin.x == self.sectionInset.left) {
            
            // Create decoration attributes
            UICollectionViewLayoutAttributes *decorationAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"collectionReuseid"
                                                                        withIndexPath:attribute.indexPath];
            
            // Make the decoration view span the entire row (you can do item by item as well.  I just
            // chose to do it this way)
            decorationAttributes.frame =
            CGRectMake(0,
                       attribute.frame.origin.y-(self.sectionInset.top),
                       self.collectionViewContentSize.width,
                       self.itemSize.height+(self.minimumLineSpacing+self.sectionInset.top+self.sectionInset.bottom));
            
            // Set the zIndex to be behind the item
            decorationAttributes.zIndex = attribute.zIndex-1;
            
            // Add the attribute to the list
            [allAttributes addObject:decorationAttributes];
            
        }
        
    }
    
    return allAttributes;
}

@end
