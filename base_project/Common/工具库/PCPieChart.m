/**
 * Copyright (c) 2011 Muh Hon Cheng
 * Created by honcheng on 28/4/11.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject
 * to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @author 		Muh Hon Cheng <honcheng@gmail.com>
 * @copyright	2011	Muh Hon Cheng
 * @version
 *
 */

#import "PCPieChart.h"

@implementation PCPieComponent
@synthesize value, title, colour, startDeg, endDeg, bedged;

- (id)initWithTitle:(NSString*)_title value:(float)_value bedged:(NSString *)_bedged
{
    self = [super init];
    if (self)
    {
        self.title = _title;
        self.value = _value;
        self.bedged = _bedged;
        self.colour = PCColorDefault;
    }
    return self;
}

+ (id)pieComponentWithTitle:(NSString*)_title value:(float)_value bedged:(NSString *)_bedged
{
    return [[super alloc] initWithTitle:_title value:_value bedged:_bedged];
}

- (NSString*)description
{
    NSMutableString *text = [NSMutableString string];
    [text appendFormat:@"title: %@\n", self.title];
    [text appendFormat:@"value: %f\n", self.value];
    return text;
}

@end

@implementation PCPieChart
@synthesize  components;
@synthesize diameter;
@synthesize titleFont, percentageFont;
@synthesize showArrow, sameColorLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.titleFont = [UIFont systemFontOfSize:10];//名称字体
        self.percentageFont = [UIFont systemFontOfSize:14];//百分比字体
        self.showArrow = YES;//是否显示箭头
        self.sameColorLabel = NO;//标注颜色是否和饼状图颜色相同
    }
    return self;
}

#define LABEL_TOP_MARGIN 15
#define ARROW_HEAD_LENGTH 3 //箭头长
#define ARROW_HEAD_WIDTH 2  //箭头宽

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    float margin = 15;
    if (self.diameter==0)
    {
        diameter = MIN(rect.size.width, rect.size.height) - 2*margin;//直径
    }
    float x = (rect.size.width - diameter)/2;//左
    float y = (rect.size.height - diameter)/2;//上
    float gap = 0;//间隙
    float inner_radius = diameter/2;//半径
    float origin_x = x + diameter/2;//中心点
    float origin_y = y + diameter/2;
    
    // label stuff
    float left_label_y = LABEL_TOP_MARGIN;
    float right_label_y = LABEL_TOP_MARGIN;
    
    
    if ([components count]>0)
    {
        
        float total = 0;
        for (PCPieComponent *component in components)
        {
            total += component.value;
        }
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();//相当于画布
        UIGraphicsPushContext(ctx);
        CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);  //填充颜色 white color
        //		CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), margin);
        CGContextFillEllipseInRect(ctx, CGRectMake(x, y, diameter, diameter));  //画椭圆 a white filled circle with a diameter of 100 pixels, centered in (60, 60)
        UIGraphicsPopContext();
        //		CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 0);
        
        float nextStartDeg = 0;//开始角度
        float endDeg = 0;//结束角度
        float arrowDeg = 0;//箭头所处角度
        NSMutableArray *tmpComponents = [NSMutableArray array];
        int last_insert = -1;
        for (int i=0; i<[components count]; i++)
        {
            PCPieComponent *component  = [components objectAtIndex:i];
            float perc = [component value]/total;//比例
            endDeg = nextStartDeg+perc*360;
            
            CGContextSetFillColorWithColor(ctx, [component.colour CGColor]);//填充色
            CGContextMoveToPoint(ctx, origin_x, origin_y);//画笔移到圆的中心点
            CGContextAddArc(ctx, origin_x, origin_y, inner_radius, (nextStartDeg-90)*M_PI/180.0, (endDeg-90)*M_PI/180.0, 0);//中心点，半径，开始弧度，结束弧度，顺时针方向1，逆时针0
            CGContextClosePath(ctx);
            CGContextFillPath(ctx);
            
            //画边界
            CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);//画笔颜色
            CGContextSetLineWidth(ctx, gap);//画笔宽度
            CGContextMoveToPoint(ctx, origin_x, origin_y);
            CGContextAddArc(ctx, origin_x, origin_y, inner_radius, (nextStartDeg-90)*M_PI/180.0, (endDeg-90)*M_PI/180.0, 0);
            CGContextClosePath(ctx);
            CGContextStrokePath(ctx);
            
            [component setStartDeg:nextStartDeg];
            [component setEndDeg:endDeg];
            if (nextStartDeg<180)
            {
                [tmpComponents addObject:component];
            }
            else
            {
                if (last_insert==-1)
                {
                    last_insert = i;
                    [tmpComponents addObject:component];
                }
                else
                {
                    [tmpComponents insertObject:component atIndex:last_insert];
                }
            }
            
            nextStartDeg = endDeg;
        }
        
        nextStartDeg = 0;
        endDeg = 0;
        float max_text_width = x - 10;
        for (int i=0; i<[tmpComponents count]; i++)
        {
            PCPieComponent *component  = [tmpComponents objectAtIndex:i];
            nextStartDeg = component.startDeg;
            endDeg = component.endDeg;
            
            if ((endDeg/2 + nextStartDeg/2)>180)
            {
                //添加左侧标注
                
                // display percentage label
                if (self.sameColorLabel)
                {
                    CGContextSetFillColorWithColor(ctx, [component.colour CGColor]);
                }
                else
                {
                    CGContextSetRGBFillColor(ctx, 0.1f, 0.1f, 0.1f, 1.0f);
                }
                //CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                //CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                //				CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 3);
                
                //float text_x = x + 10;
                
                NSString *percentageText = [NSString stringWithFormat:@" %@ %.0f%% ",component.bedged,component.value/total*100];
                CGSize optimumSize = [percentageText sizeWithFont:self.percentageFont constrainedToSize:CGSizeMake(max_text_width,100)];
                
                
                if ((endDeg/2 + nextStartDeg/2)<270)
                {
                    if (((endDeg/2 + nextStartDeg/2) - arrowDeg)<45)
                    {
                        left_label_y = rect.size.height-30-2*optimumSize.height;
                    }
                    else
                    {
                        left_label_y = rect.size.height-15-optimumSize.height;
                    }
                }
                else
                {
                    if (((endDeg/2 + nextStartDeg/2) - arrowDeg)<45)
                    {
                        left_label_y = 30+optimumSize.height;
                    }
                    else
                    {
                        left_label_y = 15;
                    }
                }
                
                CGRect percFrame = CGRectMake(5, left_label_y,  max_text_width, optimumSize.height);
                [percentageText drawInRect:percFrame withFont:self.percentageFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
                
                //画线和箭头
                if (self.showArrow)
                {
                    // draw line to point to chart
                    CGContextSetRGBStrokeColor(ctx, 0.2f, 0.2f, 0.2f, 1);
                    CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                    //CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                    //CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                    //CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 5);
                    
                    
                    int x1 = inner_radius/4*3*cos((nextStartDeg+component.value/total*360/2-90)*M_PI/180.0)+origin_x;
                    int y1 = inner_radius/4*3*sin((nextStartDeg+component.value/total*360/2-90)*M_PI/180.0)+origin_y;
                    CGContextSetLineWidth(ctx, 1);
                    if (left_label_y + optimumSize.height/2 < y)//(left_label_y==LABEL_TOP_MARGIN)
                    {
                        
                        CGContextMoveToPoint(ctx, 5 + max_text_width, left_label_y + optimumSize.height/2);
                        CGContextAddLineToPoint(ctx, x1, left_label_y + optimumSize.height/2);
                        CGContextAddLineToPoint(ctx, x1, y1);
                        CGContextStrokePath(ctx);
                        
                        //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                        CGContextMoveToPoint(ctx, x1-ARROW_HEAD_WIDTH/2, y1);
                        CGContextAddLineToPoint(ctx, x1, y1+ARROW_HEAD_LENGTH);
                        CGContextAddLineToPoint(ctx, x1+ARROW_HEAD_WIDTH/2, y1);
                        CGContextClosePath(ctx);
                        CGContextFillPath(ctx);
                        
                    }
                    else
                    {
                        
                        CGContextMoveToPoint(ctx, 5 + max_text_width, left_label_y + optimumSize.height/2);
                        if (left_label_y + optimumSize.height/2 > y + diameter)
                        {
                            CGContextAddLineToPoint(ctx, x1, left_label_y + optimumSize.height/2);
                            CGContextAddLineToPoint(ctx, x1, y1);
                            CGContextStrokePath(ctx);
                            
                            //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                            CGContextMoveToPoint(ctx, x1-ARROW_HEAD_WIDTH/2, y1);
                            CGContextAddLineToPoint(ctx, x1, y1-ARROW_HEAD_LENGTH);
                            CGContextAddLineToPoint(ctx, x1+ARROW_HEAD_WIDTH/2, y1);
                            CGContextClosePath(ctx);
                            CGContextFillPath(ctx);
                        }
                        else
                        {
                            float y_diff = y1 - (left_label_y + optimumSize.height/2);
                            if ( (y_diff < 2*ARROW_HEAD_LENGTH && y_diff>0) || (-1*y_diff < 2*ARROW_HEAD_LENGTH && y_diff<0))
                            {
                                
                                // straight arrow
                                y1 = left_label_y + optimumSize.height/2;
                                
                                CGContextAddLineToPoint(ctx, x1, y1);
                                CGContextStrokePath(ctx);
                                
                                //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                                CGContextMoveToPoint(ctx, x1, y1-ARROW_HEAD_WIDTH/2);
                                CGContextAddLineToPoint(ctx, x1+ARROW_HEAD_LENGTH, y1);
                                CGContextAddLineToPoint(ctx, x1, y1+ARROW_HEAD_WIDTH/2);
                                CGContextClosePath(ctx);
                                CGContextFillPath(ctx);
                            }
                            else if (left_label_y + optimumSize.height/2<y1)
                            {
                                // arrow point down
                                
                                y1 -= ARROW_HEAD_LENGTH;
                                CGContextAddLineToPoint(ctx, x1, left_label_y + optimumSize.height/2);
                                CGContextAddLineToPoint(ctx, x1, y1);
                                CGContextStrokePath(ctx);
                                
                                //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                                CGContextMoveToPoint(ctx, x1-ARROW_HEAD_WIDTH/2, y1);
                                CGContextAddLineToPoint(ctx, x1, y1+ARROW_HEAD_LENGTH);
                                CGContextAddLineToPoint(ctx, x1+ARROW_HEAD_WIDTH/2, y1);
                                CGContextClosePath(ctx);
                                CGContextFillPath(ctx);
                            }
                            else
                            {
                                // arrow point up
                                
                                y1 += ARROW_HEAD_LENGTH;
                                CGContextAddLineToPoint(ctx, x1, left_label_y + optimumSize.height/2);
                                CGContextAddLineToPoint(ctx, x1, y1);
                                CGContextStrokePath(ctx);
                                
                                //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                                CGContextMoveToPoint(ctx, x1-ARROW_HEAD_WIDTH/2, y1);
                                CGContextAddLineToPoint(ctx, x1, y1-ARROW_HEAD_LENGTH);
                                CGContextAddLineToPoint(ctx, x1+ARROW_HEAD_WIDTH/2, y1);
                                CGContextClosePath(ctx);
                                CGContextFillPath(ctx);
                            }
                        }
                    }
                    
                }
                // 标题
                CGContextSetRGBFillColor(ctx, 0.4f, 0.4f, 0.4f, 1.0f);
                left_label_y += optimumSize.height - 4;
                optimumSize = [component.title sizeWithFont:self.titleFont constrainedToSize:CGSizeMake(max_text_width,100)];
                CGRect titleFrame = CGRectMake(5, left_label_y, max_text_width, optimumSize.height);
                [component.title drawInRect:titleFrame withFont:self.titleFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
                left_label_y += optimumSize.height + 10;
            }
            else
            {
                //添加右侧标注
                
                // display percentage label
                if (self.sameColorLabel)
                {
                    CGContextSetFillColorWithColor(ctx, [component.colour CGColor]);
                    //CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 0.5);
                    //CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
                }
                else
                {
                    CGContextSetRGBFillColor(ctx, 0.1f, 0.1f, 0.1f, 1.0f);
                }
                //CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                //CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                //				CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 2);
                
                float text_x = x + diameter + 10;
                NSString *percentageText = [NSString stringWithFormat:@" %@ %.0f%%",component.bedged,component.value/total*100];
                CGSize optimumSize = [percentageText sizeWithFont:self.percentageFont constrainedToSize:CGSizeMake(max_text_width,100)];
                
                if ((endDeg/2 + nextStartDeg/2)>90)
                {
                    if (((endDeg/2 + nextStartDeg/2) - arrowDeg)<45)
                    {
                        right_label_y = rect.size.height-30-2*optimumSize.height;
                    }
                    else
                    {
                        right_label_y = rect.size.height-15-optimumSize.height;
                    }
                }
                else
                {
                    if (((endDeg/2 + nextStartDeg/2) - arrowDeg)<45 && arrowDeg>0)
                    {
                        right_label_y = 30+optimumSize.height;
                    }
                    else
                    {
                        right_label_y = 15;
                    }
                }
                
                CGRect percFrame = CGRectMake(text_x, right_label_y, optimumSize.width, optimumSize.height);
                [percentageText drawInRect:percFrame withFont:self.percentageFont];
                
                //画线和箭头
                if (self.showArrow)
                {
                    // draw line to point to chart
                    CGContextSetRGBStrokeColor(ctx, 0.2f, 0.2f, 0.2f, 1);
                    CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                    //CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                    //CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
                    //CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 5);
                    
                    CGContextSetLineWidth(ctx, 1);
                    int x1 = inner_radius/4*3*cos((nextStartDeg+component.value/total*360/2-90)*M_PI/180.0)+origin_x;
                    int y1 = inner_radius/4*3*sin((nextStartDeg+component.value/total*360/2-90)*M_PI/180.0)+origin_y;
                    
                    
                    if (right_label_y + optimumSize.height/2 < y)//(right_label_y==LABEL_TOP_MARGIN)
                    {
                        
                        CGContextMoveToPoint(ctx, text_x - 3, right_label_y + optimumSize.height/2);
                        CGContextAddLineToPoint(ctx, x1, right_label_y + optimumSize.height/2);
                        CGContextAddLineToPoint(ctx, x1, y1);
                        CGContextStrokePath(ctx);
                        
                        //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                        CGContextMoveToPoint(ctx, x1-ARROW_HEAD_WIDTH/2, y1);
                        CGContextAddLineToPoint(ctx, x1, y1+ARROW_HEAD_LENGTH);
                        CGContextAddLineToPoint(ctx, x1+ARROW_HEAD_WIDTH/2, y1);
                        CGContextClosePath(ctx);
                        CGContextFillPath(ctx);
                    }
                    else
                    {
                        float y_diff = y1 - (right_label_y + optimumSize.height/2);
                        if ( (y_diff < 2*ARROW_HEAD_LENGTH && y_diff>0) || (-1*y_diff < 2*ARROW_HEAD_LENGTH && y_diff<0))
                        {
                            // straight arrow
                            y1 = right_label_y + optimumSize.height/2;
                            
                            CGContextMoveToPoint(ctx, text_x, right_label_y + optimumSize.height/2);
                            CGContextAddLineToPoint(ctx, x1, y1);
                            CGContextStrokePath(ctx);
                            
                            //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                            CGContextMoveToPoint(ctx, x1, y1-ARROW_HEAD_WIDTH/2);
                            CGContextAddLineToPoint(ctx, x1-ARROW_HEAD_LENGTH, y1);
                            CGContextAddLineToPoint(ctx, x1, y1+ARROW_HEAD_WIDTH/2);
                            CGContextClosePath(ctx);
                            CGContextFillPath(ctx);
                        }
                        else if (right_label_y + optimumSize.height/2<y1)
                        {
                            // arrow point down
                            
                            y1 -= ARROW_HEAD_LENGTH;
                            
                            CGContextMoveToPoint(ctx, text_x, right_label_y + optimumSize.height/2);
                            CGContextAddLineToPoint(ctx, x1, right_label_y + optimumSize.height/2);
                            //CGContextAddLineToPoint(ctx, x1+5, y1);
                            CGContextAddLineToPoint(ctx, x1, y1);
                            CGContextStrokePath(ctx); 
                            
                            //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                            CGContextMoveToPoint(ctx, x1+ARROW_HEAD_WIDTH/2, y1);
                            CGContextAddLineToPoint(ctx, x1, y1+ARROW_HEAD_LENGTH);
                            CGContextAddLineToPoint(ctx, x1-ARROW_HEAD_WIDTH/2, y1);
                            CGContextClosePath(ctx);
                            CGContextFillPath(ctx);
                        } 
                        else //if (nextStartDeg<180 && endDeg>180)
                        {
                            // arrow point up
                            y1 += ARROW_HEAD_LENGTH;
                            
                            CGContextMoveToPoint(ctx, text_x, right_label_y + optimumSize.height/2);
                            CGContextAddLineToPoint(ctx, x1, right_label_y + optimumSize.height/2);
                            CGContextAddLineToPoint(ctx, x1, y1);
                            CGContextStrokePath(ctx);
                            
                            //CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
                            CGContextMoveToPoint(ctx, x1+ARROW_HEAD_WIDTH/2, y1);
                            CGContextAddLineToPoint(ctx, x1, y1-ARROW_HEAD_LENGTH);
                            CGContextAddLineToPoint(ctx, x1-ARROW_HEAD_WIDTH/2, y1);
                            CGContextClosePath(ctx);
                            CGContextFillPath(ctx);
                        }
                    }
                }
                
                // 题目
                CGContextSetRGBFillColor(ctx, 0.4f, 0.4f, 0.4f, 1.0f);
                right_label_y += optimumSize.height - 4;
                optimumSize = [component.title sizeWithFont:self.titleFont constrainedToSize:CGSizeMake(max_text_width,100)];
                CGRect titleFrame = CGRectMake(text_x, right_label_y, optimumSize.width, optimumSize.height);
                [component.title drawInRect:titleFrame withFont:self.titleFont];
                right_label_y += optimumSize.height + 10;
            }
            
            arrowDeg = endDeg/2 + nextStartDeg/2;
            nextStartDeg = endDeg;
        }
    }
    
    
}


@end
