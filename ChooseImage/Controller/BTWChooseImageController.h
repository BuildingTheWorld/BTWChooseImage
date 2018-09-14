

#import <UIKit/UIKit.h>

@class BTWChooseImageItem;

/**
 ChooseImageCell 被点击

 @param chooseImageItem BTWChooseImageItem 模型
 @param imageIndex 数据源数组的索引
 @param oppositeAddImageCount 图片数量(不包括加号图片)
 */
typedef void(^BTWCISelectCellBlock)(BTWChooseImageItem *chooseImageItem, NSInteger imageIndex, NSInteger oppositeAddImageCount);

@interface BTWChooseImageController : UIViewController

/// 配置 item size
@property (nonatomic, assign) CGSize imgItemSize;

/// 配置 item 最大个数
@property (nonatomic, assign) NSInteger chooseImageMaxCount;

/// 配置 加号图片 name
@property (nonatomic, strong) NSString *addImageNameStr;

/// 配置 从服务器获取的图片的模型数组
@property (nonatomic, strong) NSArray <BTWChooseImageItem *> *remoteItemArray;

@property (nonatomic, strong) BTWCISelectCellBlock selectCellBlock;

/**
 新增一张 本地 图片

 @param imageData 本地图片数据
 */
- (void)addLocalImageData:(NSData *)imageData;

/**
 根据 index 删除一张图片

 @param imageIndex 图片的索引
 */
- (void)removeImageWithIndex:(NSInteger)imageIndex; 

/**
 替换一张图片

 @param replaceIndex 被替换图片的索引
 @param newImageData 新图片的数据
 */
- (void)replaceImageWithIndex:(NSInteger)replaceIndex newImageData:(NSData *)newImageData;

/**
 添加到 targetVC

 @param targetVC 目标VC
 @param viewFrame ChooseImageVC 控制器的 View 的 Frame
 */
- (void)addTargetViewController:(UIViewController *)targetVC chooseControllerViewFrame:(CGRect)viewFrame;

@end
