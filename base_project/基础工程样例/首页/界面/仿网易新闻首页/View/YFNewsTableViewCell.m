//
//  YFNewsTableViewCell.m
//  base_project
//
//  Created by zyh on 16/12/29.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFNewsTableViewCell.h"

@interface YFNewsTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageViewLabel;

@end

@implementation YFNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsModel:(YFNewsModel *)newsModel
{
    _newsModel = newsModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[CommonImageUrl stringByAppendingString:newsModel.imgUrl]] placeholderImage:[UIImage imageNamed:@"list_image_bg.png"]];
    
    self.imgView.layer.cornerRadius = 5.0;
    self.imgView.layer.masksToBounds = YES;
    
    self.titleLabel.text = newsModel.title;
    self.subTitleLabel.text = newsModel.desc;
    
    //截取时间
    NSString *dateStr = [newsModel.addTime substringFromIndex:5];
    NSArray *dateArray = [dateStr componentsSeparatedByString:@"."];
    dateStr = [dateArray componentsJoinedByString:@"-"];
    
    self.timeLabel.text = dateStr;
    
    self.pageViewLabel.text = [NSString stringWithFormat:@"阅读量：%@",newsModel.clickCount];
}

@end
