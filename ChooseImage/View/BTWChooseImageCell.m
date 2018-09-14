

#import "BTWChooseImageCell.h"

//#import <Masonry.h>
//#import <UIImageView+WebCache.h>
//#import "UIImage+borderCorner.h"

@interface BTWChooseImageCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation BTWChooseImageCell

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self setupSubViews];
    }
    return self;
}

#pragma mark - setup subViews

- (void)setupSubViews
{
//    [self.contentView addSubview:self.iconImageView];
//    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
}

#pragma mark - setter

- (void)setChooseImageItem:(BTWChooseImageItem *)chooseImageItem
{
    _chooseImageItem = chooseImageItem;
    
    if (chooseImageItem.itemImageType == BTWCIImageTypeAdd)
    {
        self.iconImageView.image = [UIImage imageNamed:chooseImageItem.itemAddImageNameStr];
    }
    else if (chooseImageItem.itemImageType == BTWCIImageTypeLocal)
    {
        self.iconImageView.image = [UIImage imageWithData:chooseImageItem.itemLocalImageData];
    }
    else
    {
        if (chooseImageItem.itemImageUrlStr.length != 0) {
            
            NSURL *imageUrl = [NSURL URLWithString:chooseImageItem.itemImageUrlStr];
            
            __weak typeof(self) weakSelf = self;
//            [self.iconImageView sd_setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//                if (image == nil) {
//                    return ;
//                }
//                UIImage *resultImage = [UIImage roundedImageWithOriginalImage:image originalImageSize:CGSizeMake(75, 75) roundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
//                weakSelf.iconImageView.image = resultImage;
//            }];
        }
    }

}

#pragma mark - lazy

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

@end
