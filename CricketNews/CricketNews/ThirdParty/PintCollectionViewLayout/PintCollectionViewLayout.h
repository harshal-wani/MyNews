//
//  PintCollectionViewLayout.h
//
//  Created by Jay Slupesky on 10/3/12.
//  jay@fallcreek.com
//

#import <UIKit/UICollectionViewFlowLayout.h>
#import <UIKit/UICollectionView.h>
#import <UIKit/UIKitDefines.h>
#import <Foundation/Foundation.h>


@protocol UICollectionViewDelegateJSPintLayout <UICollectionViewDelegate>
@optional

- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath*)indexPath;

- (CGFloat)columnWidthForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;

- (NSUInteger)maximumNumberOfColumnsForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;

@end


NS_CLASS_AVAILABLE_IOS(6_0) @interface PintCollectionViewLayout : UICollectionViewFlowLayout

- (id)init;

@property (nonatomic) CGFloat lineSpacing;
@property (nonatomic) CGFloat interitemSpacing;
@property (nonatomic) CGFloat itemHeight;
@property (nonatomic) CGFloat columnWidth;
@property (nonatomic) NSUInteger numberOfColumns;

@end
