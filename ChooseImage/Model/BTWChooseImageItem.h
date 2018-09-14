

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

/**
 图片类型

 - BTWCIImageTypeAdd: 加号图片
 - BTWCIImageTypeRemote: 服务器资源图片
 - BTWCIImageTypeLocal: 本地资源图片
 */
typedef NS_ENUM(NSUInteger, BTWCIImageType) {
    BTWCIImageTypeAdd,
    BTWCIImageTypeRemote,
    BTWCIImageTypeLocal,
};

@interface BTWChooseImageItem : NSObject

/// 图片类型
@property (nonatomic, assign) BTWCIImageType itemImageType;

/// 加号图片名称
@property (nonatomic, strong) NSString *itemAddImageNameStr;

/// 本地图片 NSData 类型
@property (nonatomic, strong) NSData *itemLocalImageData;

// 服务器 JSON 字段
@property (nonatomic, assign) long long itemUserID;
@property (nonatomic, assign) long long itemImageID;
@property (nonatomic, strong) NSString *itemImageUrlStr;

@end
