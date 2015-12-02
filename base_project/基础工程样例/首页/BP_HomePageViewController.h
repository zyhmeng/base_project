//
//  BP_HomePageViewController.h
//  base_project
//  
//  Created by jangbuk on 15/10/30.
//  Copyright © 2015年 jangbuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALOCenteredButton.h"
#import "UIImage+YF.h"
#import "ARKit.h"

@interface BP_HomePageViewController : UIViewController<ARViewDelegate>
{
    NSArray *points;
    ARKitEngine *engine;
    
    NSInteger selectedIndex;
    //DetailView *currentDetailView;
}

@property (strong, nonatomic) IBOutlet ALOCenteredButton *TestBT;
@end
