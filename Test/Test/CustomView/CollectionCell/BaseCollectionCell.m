//
//  BaseCollectionCell.m
//  Test
//
//  Created by qiandong on 15/7/9.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell

- (void)awakeFromNib
{
    // Initialization code

}

+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}

+ (NSString *)nibName
{
    return [self identifier];
}

+ (UINib *)nib
{
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    return [UINib nibWithNibName:[self nibName] bundle:classBundle];
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
}

@end
