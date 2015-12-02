//
//  ABStyleViewController.m
//  CustomCollectionView
//
//  Created by zx on 15/11/13.
//  Copyright © 2015年 yunfeng. All rights reserved.
//

#import "ABStyleViewController.h"
#import "ACollectionViewCell.h"
#import "BCollectionViewCell.h"
#import "CollectionReusableView.h"

#define DeviceW [[UIScreen mainScreen] bounds].size.width
#define DeviceH [[UIScreen mainScreen] bounds].size.height

@interface ABStyleViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>{

    UICollectionView *ABStyleCollectionView;
}

@end

static NSString *AcollectionIdentifier=@"Acollectionidentifier";
static NSString *BcollectionIdentifier=@"Bcollectionidentifier";
static NSString *collectionHeaderIdentifier=@"collectionHeaderidentifier";

@implementation ABStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    //    flowlayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;//设置横向移动
    
    
    ABStyleCollectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowlayout];
    ABStyleCollectionView.delegate=self;
    ABStyleCollectionView.dataSource=self;
    
    [ABStyleCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ABStyleCollectionView];
    
    [self registerCell];
    
    
}
#pragma mark 注册cell
-(void)registerCell{
    
    [ABStyleCollectionView registerNib:[UINib nibWithNibName:@"ACollectionViewCell" bundle:nil] forCellWithReuseIdentifier:AcollectionIdentifier];
    
    [ABStyleCollectionView registerNib:[UINib nibWithNibName:@"BCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:BcollectionIdentifier];
    
    [ABStyleCollectionView registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderIdentifier];

    
}

#pragma mark collectionviewdatasource代理函数
//collectionview分几个段
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
    
}
//每个段里面几个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }return 5;
    
}
//cell上的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        ACollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:AcollectionIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    BCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:BcollectionIdentifier forIndexPath:indexPath];
    
    
    UILongPressGestureRecognizer *LongPresssGR=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPresssGR:)];
    [cell addGestureRecognizer:LongPresssGR];
   
    return cell;
    
}
//段头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CollectionReusableView *headerview=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeaderIdentifier forIndexPath:indexPath];
    
   
    return headerview;
}
#pragma mark collectionviewdelegateflowlayout代理函数
//设置每个cell距离边框及相邻cell的距离   上 左 下  右
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets insets=UIEdgeInsetsMake(50, 80, 10,80);
    return insets;
    
    
}
//两个相邻cell水平之间的最小距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20;
    
}
//两个相邻cell垂直之间的最小距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
    
}
//段头的宽高设置
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size=CGSizeMake(10, 10);
    return size;
    
    
}
//设置每个cell的宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size=CGSizeZero;
    if (indexPath.section==0) {
        size=CGSizeMake(50, 100);
        return size;
    }
    size=CGSizeMake(340, 100);
    return size;
    
    
}
#pragma mark cell长按手势事件
-(void)LongPresssGR:(UIGestureRecognizer *)LongPresssGR{

    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"确定要删除吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
