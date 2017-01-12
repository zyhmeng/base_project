//
//  UseSwiftViewController.m
//  base_project
//
//  Created by 李恒昌 on 2017/1/11.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "UseSwiftViewController.h"
#import "base_project-Swift.h" //该文件是系统自动帮你生成的文件,并且在项目中不可见的,使用时候直接import即可
@interface UseSwiftViewController ()

@end

//调用 Swift文件步骤
//1 新建一个swift类型文件,此时会提醒你是否创建 bridging文件  点YES
//2 在需要使用的文件中,直接import "你的项目名称-Swift.h" (此处可能没有代码提示,直接写上去就行)
//3 像下面方法一样,直接调用即可

// 注意事项: 可能过程中会提示错误,先cmd+B 编译一下
// 如果使用swift封装好的第三方库,则需要先导入第三方,然后建立swift类型文件去调用,最后通过这个swift文件去使用. Objc无法直接调用swift的第三方库文件
@implementation UseSwiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button  =  [[UIButton alloc]init];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"点击调用swift实例的func,成功有log信息,具体说明请看文件注释" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    [button addTarget:self action:@selector(useSwiftMethod) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(50, 50, 200, 200);
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
-(void)useSwiftMethod{
    //此处cmd 点击 可以看到 系统自动生成的base_project-Swift.h文件,会把swift中的实例方法自动编译成objc语言,因此直接调用即可
    SwiftFile * file = [[SwiftFile alloc]init];
    [file useSwift];
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
