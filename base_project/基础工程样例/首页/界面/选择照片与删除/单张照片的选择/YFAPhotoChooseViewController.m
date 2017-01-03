//
//  YFAPhotoChooseViewController.m
//  base_project
//
//  Created by zyh on 16/12/22.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFAPhotoChooseViewController.h"
#import "YFAPhotoChoose.h"
#import "UIActionSheet+Blocks.h"
#import "RIButtonItem.h"

@interface YFAPhotoChooseViewController ()<UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *photoButton;
@end

@implementation YFAPhotoChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"选择一张图片"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChoosePhotoButton];
}

- (void)setupChoosePhotoButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(100, 100, 60, 60);
    
    [button setImage:[UIImage imageNamed:@"btn_cammer"] forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor lightGrayColor];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoButton = button;
    
    [self.view addSubview:button];
    
}

- (void)buttonClick:(UIButton *)button
{
    [[[UIActionSheet alloc] initWithTitle:nil cancelButtonItem:[RIButtonItem itemWithLabel:@"取消"] destructiveButtonItem:nil otherButtonItems:[RIButtonItem itemWithLabel:@"拍照" action:^{
        
        [self takePhoto];
        
    }], [RIButtonItem itemWithLabel:@"从手机相册选择" action:^{
        
        [self LocalPhoto];
        
    }],nil] showInView:self.view];
    
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:^{
            
            
        }];
    }else
    {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    // for iphone
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.photoButton setImage:img forState:UIControlStateNormal];
    }];
    
}



@end
