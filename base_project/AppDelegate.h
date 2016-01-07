//
//  AppDelegate.h
//  base_project
//  
//  Created by jangbuk on 15/10/30.
//  Copyright © 2015年 jangbuk. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BP_HomePageViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

/*
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
*/
@end

