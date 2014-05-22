//
//  PeopleInPartment.h
//  USConnect
//
//  Created by Gintama on 14-5-3.
//  Copyright (c) 2014年 Gintama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleInPartment : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSString * dep_ID;
@property (nonatomic,strong) NSMutableArray * peopleList;
-(void) getPeopleInPartment;
@end
