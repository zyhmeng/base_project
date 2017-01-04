//
//  YFRichTextViewController.m
//  base_project
//
//  Created by zyh on 17/1/3.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFRichTextViewController.h"
#import "WebViewModel.h"

@interface YFRichTextViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIWebView *webView;
@end

@implementation YFRichTextViewController

- (UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 300)];
    }
    
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Html富文本处理"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupWebView];
    
    [self setupTableView];
}

- (void)setupWebView
{
    NSString *string = @"测试一下<img src=\"http://s3.xtox.net:8180/yf_upload/image/20161229/20161229111500_609.jpg\" width=\"100px\" height=\"100px\" alt=\"\" />";
    
    NSString *htmlStr = [WebViewModel showInWebViewDataString:string];
    
    self.webView.delegate = self;
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableHeaderView = self.webView;
    tableView.tableFooterView = [UIView new];
    tableView.rowHeight = 60;
    
    [self.view addSubview:tableView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.yh_height = webView.scrollView.contentSize.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"Html富文本处理";
    cell.detailTextLabel.text = @"Html富文本处理测试";
    
    return cell;
}

@end
