

#import "BTWChooseImageController.h"

//#import <Masonry.h>

#import "BTWChooseImageCell.h"

static NSString * const kCSChooseImageCellID = @"kCSChooseImageCellID";

@interface BTWChooseImageController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *chooseImageFlowLayout;
@property (nonatomic, strong) UICollectionView *chooseImageCollectionView;
@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation BTWChooseImageController

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setup subViews

- (void)setupSubViews
{
//    [self.view addSubview:self.chooseImageCollectionView];

//    [self.chooseImageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
}

#pragma mark - public

- (void)addLocalImageData:(NSData *)imageData
{
    BTWChooseImageItem *tempItem = [[BTWChooseImageItem alloc] init];
    tempItem.itemImageType = BTWCIImageTypeLocal;
    tempItem.itemLocalImageData = imageData;
    [self.modelArray insertObject:tempItem atIndex:(self.modelArray.count - 1)]; // ---core---
    [self.chooseImageCollectionView reloadData];
}

- (void)removeImageWithIndex:(NSInteger)imageIndex
{
    [self.modelArray removeObjectAtIndex:imageIndex]; // ---core--- 
    
    [self.chooseImageCollectionView reloadData];
}

- (void)replaceImageWithIndex:(NSInteger)replaceIndex newImageData:(NSData *)newImageData
{
    BTWChooseImageItem *tempItem = [[BTWChooseImageItem alloc] init];
    tempItem.itemImageType = BTWCIImageTypeLocal;
    tempItem.itemLocalImageData = newImageData;
    [self.modelArray replaceObjectAtIndex:replaceIndex withObject:tempItem]; // ---core---
    [self.chooseImageCollectionView reloadData];
}

- (void)addTargetViewController:(UIViewController *)targetVC chooseControllerViewFrame:(CGRect)viewFrame
{
    [targetVC addChildViewController:self];
    self.view.frame = viewFrame;
    self.view.autoresizingMask = UIViewAutoresizingNone;
    [targetVC.view addSubview:self.view];
    [self didMoveToParentViewController:targetVC];
}

#pragma mark - collectionView data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MIN(self.modelArray.count, self.chooseImageMaxCount); // ---core---
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BTWChooseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCSChooseImageCellID forIndexPath:indexPath];
    
    cell.chooseImageItem = self.modelArray[indexPath.item];
    
    return cell;
}

#pragma mark - collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BTWChooseImageItem *tempItem = self.modelArray[indexPath.item];
    
    if (self.selectCellBlock) {
        self.selectCellBlock(tempItem, indexPath.item, self.modelArray.count - 1);
    }
}

#pragma mark - setter

- (void)setRemoteItemArray:(NSArray<BTWChooseImageItem *> *)remoteItemArray
{
    _remoteItemArray = remoteItemArray;
    
    NSRange removeRange = NSMakeRange(0, self.modelArray.count - 1);
    [self.modelArray removeObjectsInRange:removeRange];
    
    [remoteItemArray enumerateObjectsUsingBlock:^(CSChooseImageItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.itemImageType = CSCIImageTypeRemote;
    }];
    
    NSRange addItemRange = NSMakeRange(self.modelArray.count - 1, remoteItemArray.count);
    NSIndexSet *addItemIndexSet = [NSIndexSet indexSetWithIndexesInRange:addItemRange];
    
    [self.modelArray insertObjects:remoteItemArray atIndexes:addItemIndexSet]; // ---core---
    
    [self.chooseImageCollectionView reloadData];
}

#pragma mark - lazy

- (UICollectionViewFlowLayout *)chooseImageFlowLayout {
    if (_chooseImageFlowLayout == nil) {
        _chooseImageFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _chooseImageFlowLayout.itemSize = self.imgItemSize;
        NSInteger singleLineMaxCount = self.view.bounds.size.width / self.imgItemSize.width;
        CGFloat interItemSpace = (self.view.bounds.size.width - self.imgItemSize.width * singleLineMaxCount) / (singleLineMaxCount - 1);
        _chooseImageFlowLayout.minimumLineSpacing = (singleLineMaxCount > 1) ? interItemSpace : 0;
        _chooseImageFlowLayout.minimumInteritemSpacing = interItemSpace;
    }
    return _chooseImageFlowLayout;
}

- (UICollectionView *)chooseImageCollectionView {
    if (_chooseImageCollectionView == nil) {
        _chooseImageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.chooseImageFlowLayout];
        _chooseImageCollectionView.dataSource = self;
        _chooseImageCollectionView.delegate = self;
        _chooseImageCollectionView.showsHorizontalScrollIndicator = NO;
        _chooseImageCollectionView.showsVerticalScrollIndicator = NO;
        _chooseImageCollectionView.backgroundColor = [UIColor whiteColor];
        [_chooseImageCollectionView registerClass:[BTWChooseImageCell class] forCellWithReuseIdentifier:kCSChooseImageCellID];
    }
    return _chooseImageCollectionView;
}

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
        
        BTWChooseImageItem *chooseItem = [[BTWChooseImageItem alloc] init];
        chooseItem.itemImageType = BTWCIImageTypeAdd;
        chooseItem.itemAddImageNameStr = self.addImageNameStr;
        [self.modelArray addObject:chooseItem];
        
//        [self.chooseImageCollectionView reloadData];
    }
    return _modelArray;
}

@end
