//
//  PartmentList.h
//  USConnect
//
//  Created by Gintama on 14-4-24.
//  Copyright (c) 2014年 Gintama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleInPartment.h"
@interface PartmentList : UITableViewController<UITableViewDataSource,UITableViewDelegate>

-(void)getPartment;
@property (nonatomic,strong) NSMutableArray * partmentList;
@end
