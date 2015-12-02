//
//  BP_HomePageViewController.m
//  base_project
//
//  Created by jangbuk on 15/10/30.
//  Copyright © 2015年 jangbuk. All rights reserved.
//

#import "BP_HomePageViewController.h"
#import "UIImage+YF.h"
@interface BP_HomePageViewController ()

//功能模块儿列表

@property (strong, nonatomic) IBOutlet UITableView *moduleTableView;

@end

@implementation BP_HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ALOCenteredButton *button= [ALOCenteredButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"测试一下" forState:UIControlStateNormal];
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:8]];
    [button setImageLabelSpacing:20];

    
    [button setButtonOrientation:ALOCenteredButtonOrientationRightToLeft];

    [button setImage:[[UIImage imageNamed:@"btn_img"] scaleToSize:CGSizeMake(20, 20)]forState:UIControlStateNormal];

    [button setFrame:CGRectMake(100, 100, 200, 200)];
  //  [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.laberColor=[UIColor redColor];
    [self.view addSubview:button];
    
    self.TestBT.laberColor=[UIColor yellowColor];
    
    
    
    selectedIndex = -1;
    
 
    CLLocation *location = [[CLLocation alloc] initWithLatitude:34.052337 longitude:-118.243680];
       /*
    ARGeoCoordinate *la = [ARGeoCoordinate coordinateWithLocation:location];
    la.dataObject = @"Los Angeles";
    */
    
    /*
    location = [[CLLocation alloc] initWithLatitude:40.71448 longitude:-74.00598];
    ARGeoCoordinate *ny = [ARGeoCoordinate coordinateWithLocation:location];
    ny.dataObject = @"New York";
    */
    location = [[CLLocation alloc] initWithLatitude:51.500622 longitude:-0.126662];
    ARGeoCoordinate *london = [ARGeoCoordinate coordinateWithLocation:location];
    london.dataObject = @"伦敦";
    
    location = [[CLLocation alloc] initWithLatitude:39.904459 longitude:116.406847];
    ARGeoCoordinate *pekin = [ARGeoCoordinate coordinateWithLocation:location];
    pekin.dataObject = @"北京";
    
    location = [[CLLocation alloc] initWithLatitude:55.756151 longitude:37.61727];
    ARGeoCoordinate *mos = [ARGeoCoordinate coordinateWithLocation:location];
    mos.dataObject = @"莫斯科";
    
    points = @[ london, pekin, mos];

    [HttpTool Post:@"UserLogin" RequestSerializerType:RequestSerializerTypeHTTP Params:nil  UseCache:YES HttpHeaderToken:@"" Success:^(id json) {
   
    } Failure:^(NSString *error) {
        
    }];
    
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
- (IBAction)arbt:(id)sender {
    // Create the location
    CLLocation *location = [[CLLocation alloc] initWithLatitude:51.500622 longitude:-0.126662];
    ARGeoCoordinate *london = [ARGeoCoordinate coordinateWithLocation:location];
    london.dataObject = @"London";
    
    // Given that self is the ARViewDelegate
    ARKitConfig *config = [ARKitConfig defaultConfigFor:self];
    config.radarPoint=CGPointMake(100, 100);
    
    // Instantiate the engine
    engine = [[ARKitEngine alloc] initWithConfig:config];
    // Provide coordinates to show
    [engine addCoordinates:points];
    // And fire it up!
    
    
    [engine startListening];
    
}
- (ARObjectView *)viewForCoordinate:(ARGeoCoordinate *)coordinate floorLooking:(BOOL)floorLooking {
    NSString *text = (NSString *)coordinate.dataObject;
    
    ARObjectView *view = nil;
    
    if (floorLooking) {
        UIImage *arrowImg = [UIImage imageNamed:@"ar_arrow.png"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:arrowImg];
        view = [[ARObjectView alloc] initWithFrame:arrowView.bounds];
        [view addSubview:arrowView];
        view.displayed = YES;
    } else {
        UIImageView *boxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"box.png"]];
        boxView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(4, 16, boxView.frame.size.width - 8, 20)];
        lbl.font = [UIFont systemFontOfSize:17];
        lbl.minimumFontSize = 2;
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor whiteColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = text;
        lbl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        view = [[ARObjectView alloc] initWithFrame:boxView.frame];
        [view addSubview:boxView];
        [view addSubview:lbl];
    }
    
    [view sizeToFit];
    return view;
}

- (void) itemTouchedWithIndex:(NSInteger)index {
    // An item has been touched. React accordingly (if necessary)
    selectedIndex = index;
    
    NSString *name = (NSString *)[engine dataObjectWithIndex:index];
    
    [engine removeCoordinates:points];
    
    /*
    currentDetailView = [[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:nil options:nil][0];
    currentDetailView.nameLbl.text = name;
    [engine addExtraView:currentDetailView];
    */
}

- (void) didChangeLooking:(BOOL)floorLooking {
    if (floorLooking) {
        // The user has began looking at the floor
    } else {
        // The user has began looking front
    }
}
@end
