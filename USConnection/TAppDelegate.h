//
//  TAppDelegate.h
//  USConnection
//
//  Created by Gintama on 14-5-4.
//  Copyright (c) 2014年 Gintama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartmentList.h"
#import "MyFavorite.h"
#import "AllNcuhomers.h"

@interface TAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UITabBarController *tabBar;
@property (strong,nonatomic) NSArray *controllers;

@end
