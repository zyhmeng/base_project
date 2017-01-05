//
//  YFTextField.m
//  YFTextField
//
//  Created by zyh on 15/12/16.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "YFTextField.h"

@interface YFTextField()
@property (nonatomic) BOOL underLine;


@property (nonatomic, strong) UIColor *borderLineColor;
@property (nonatomic) CGFloat borderLineWidth;
@property (nonatomic) CGFloat borderCornerRadius;
@property (nonatomic) CGFloat yfTextFieldHight;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) NSString *placeholderText;

@property (nonatomic) YFTextAlignmentType type;
@end

@implementation YFTextField

#pragma mark - 系统方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.yfTextFieldHight = self.frame.size.height;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.yfTextFieldHight = self.frame.size.height;
        
    }
    return self;
}


#pragma mark - 枚举设置textField的类型
- (void)setYFTextFieldBorderStyle:(YFTextFieldBorderStyle)style
{
    switch (style) {
        case YFTextFieldBorderStyleNone:
        {
            self.borderStyle = UITextBorderStyleNone;
        }
            break;
        case YFTextFieldBorderStyleUnderLine:
        {
            self.borderStyle = UITextBorderStyleNone;
            
            _underLine = YES;
        }
            break;
        case YFTextFieldBorderStyleCustomRoundedRect:
        {
            
        }
            break;
        case YFTextFieldBorderStyleSystemRoundedRect:
        {
            self.borderStyle = UITextBorderStyleRoundedRect;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 只有图片的leftView
- (void)setYFTextFieldWithLeftViewImage:(UIImage *)leftImage spacing:(CGFloat)spacing imageWH:(CGSize)imageWH
{
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imageWH.width + spacing + 8, imageWH.height)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 0, imageWH.width, imageWH.height)];
    //设置图片
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;

}

#pragma mark - 只有文字的leftView
- (void)setYFTextFieldWithLeftViewText:(NSString *)leftViewText spacing:(CGFloat)spacing textFont:(UIFont *)textFont andTextColor:(UIColor *)textColor
{
    // 根据字数得到view尺寸
    CGRect textRect = [self computeTextRectWith:leftViewText andTextFont:textFont];
    
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, textRect.size.width + spacing + 8, self.yfTextFieldHight)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 0, textRect.size.width, self.yfTextFieldHight)];
    
    [leftButton setTitle:leftViewText forState:UIControlStateNormal];
    [leftButton setTitleColor:textColor forState:UIControlStateNormal];
    //设置leftText font
    leftButton.titleLabel.font = textFont;
    
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - setup border line
- (void)setYFTextFieldWithBorderLineColor:(UIColor *)color andWidth:(CGFloat)width
{
    _borderLineColor = color;
    _borderLineWidth = width;
}

#pragma mark - setup border corner radius
- (void)setYFTextFieldWithBorderCornerRadius:(CGFloat)radius
{
    _borderCornerRadius = radius;
    
}

#pragma mark - setup placeholder
- (void)setYFTextFieldWithPlaceholderText:(NSString *)placeholderText alignment:(YFTextAlignmentType)type textFont:(UIFont *)font andTextColor:(UIColor *)color
{
    _placeholderColor = color;
    _placeholderFont = font;
    _placeholderText = placeholderText;
    
    _type = type;
    
    [self setPlaceholder:placeholderText];
    
}

- (void)setYFTextFieldWithPlaceholderText:(NSString *)placeholderText textFont:(UIFont *)font andTextColor:(UIColor *)color
{
    _placeholderColor = color;
    _placeholderFont = font;
    _placeholderText = placeholderText;
    
    [self setPlaceholder:placeholderText];
    
}

#pragma mark - 根据字体大小多少计算尺寸
- (CGRect)computeTextRectWith:(NSString *)text andTextFont:(UIFont *)textFont
{
    //根据字数设置leftViewText的尺寸
    CGFloat maxWidth = 200;
    CGSize maxSize = CGSizeMake(maxWidth,CGFLOAT_MAX);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : textFont, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    return rect;
    
}

#pragma mark - 画下划线和边框
- (void)drawRect:(CGRect)rect {
    
    if (self.underLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, self.borderLineColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - self.borderLineWidth, CGRectGetWidth(self.frame), self.borderLineWidth));
    }
    if (self.borderCornerRadius) {
        [self.layer setBorderColor:self.borderLineColor.CGColor];
        [self.layer setBorderWidth:self.borderLineWidth];
        [self.layer setCornerRadius:self.borderCornerRadius];
    }
    
}


#pragma mark - 居中placeholder的文字
- (void)drawPlaceholderInRect:(CGRect)rect {
    //draw place holder.
    if (self.placeholderText != nil && self.placeholderFont != nil) {
        {
            if (_type == YFTextAlignmentRight) {
                CGRect placeholderTextRect = [self computeTextRectWith:self.placeholderText andTextFont:self.placeholderFont];

                CGPoint placeholderPoint = CGPointMake(rect.size.width - placeholderTextRect.size.width - 8, (self.frame.size.height-placeholderTextRect.size.height)*0.5);
                
                [[self placeholder] drawAtPoint:placeholderPoint withAttributes:@{NSForegroundColorAttributeName:self.placeholderColor,NSFontAttributeName:self.placeholderFont}];

                
            }else if (_type == YFTextAlignmentLeft)
            {
                CGRect placeholderTextRect = [self computeTextRectWith:self.placeholderText andTextFont:self.placeholderFont];
                CGRect placeholderRect = CGRectMake(0, (self.frame.size.height-placeholderTextRect.size.height)*0.5, rect.size.width, rect.size.height);
                
                [[self placeholder] drawInRect:placeholderRect withAttributes:@{NSForegroundColorAttributeName:self.placeholderColor,NSFontAttributeName:self.placeholderFont}];
            }
            
            
        }
    }
}



@end

