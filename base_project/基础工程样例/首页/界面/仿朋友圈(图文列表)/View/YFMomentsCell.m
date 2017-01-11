//
//  YFMomentsCell.m
//  base_project
//
//  Created by zyh on 17/1/11.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFMomentsCell.h"
#import "YFMomentsModel.h"
#import "YFMomentsPictureView.h"

@interface YFMomentsCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) YFMomentsPictureView *pictureView;
@end

@implementation YFMomentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (YFMomentsPictureView *)pictureView
{
    if (!_pictureView) {
        
        _pictureView = [[YFMomentsPictureView alloc] init];
        [self.contentView addSubview:_pictureView];
    }
    
    return _pictureView;
}

- (void)setModel:(YFMomentsModel *)model
{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[CommonImageUrl stringByAppendingString:model.imageStr]] placeholderImage:[UIImage imageNamed:@"头像"]];
    
    [self.aliasLabel setText:model.name];
    
    [self.contentLabel setText:model.content];
    
    if (model.pictureArray.count) {
        
        self.pictureView.hidden = NO;
        
        self.pictureView.frame = model.pictureViewFrame;
        
        self.pictureView.pictureArray = model.pictureArray;
        
    }else
    {
        self.pictureView.hidden = YES;
    }

}

@end
