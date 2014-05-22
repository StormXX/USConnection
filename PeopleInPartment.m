//
//  PeopleInPartment.m
//  USConnect
//
//  Created by Gintama on 14-5-3.
//  Copyright (c) 2014年 Gintama. All rights reserved.
//

#import "PeopleInPartment.h"

@interface PeopleInPartment ()

@end

@implementation PeopleInPartment
@synthesize dep_ID=_dep_ID;
@synthesize peopleList=_peopleList;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    NSLog(@"dep_id=%@",_dep_ID);
    [self getPeopleInPartment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _peopleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //cell.textLabel.text=[[_peopleList objectAtIndex:indexPath.row] objectForKey:@"Emp_Name"];
    cell.textLabel.text=@"11";
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getPeopleInPartment
{
    //NSMutableDictionary * header=[NSMutableDictionary dictionary];
    //[header setValue:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    //[header setValue:@"application/json" forKey:@"Accept"];
    //NSString *path=[[NSString alloc] initWithFormat:@"NcuhomeUS.asmx/getEmployeeInfoByEmp_Name"];
    //MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:@"webservice.ncuhome.cn" customHeaderFields:header ];
    //NSMutableDictionary * param=[[NSMutableDictionary alloc] init];
    //[param setValue:@"廖肇兴" forKey:@"Emp_Name"];
    NSString *path=[[NSString alloc] initWithFormat:@"data/101240101.html"];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:@"m.weather.com.cn/" customHeaderFields:nil ];
    MKNetworkOperation *op=[engine operationWithPath:path params:nil httpMethod:@"GET" ];
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        //NSLog(@"responseData:%@",[operation responseString]);
        NSData *data=[operation responseData];
        NSDictionary *resDict=[NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                                error:nil];
        _peopleList=[resDict objectForKey:@"d"];
        NSLog(@"people name :%@",[[resDict objectForKey:@"weatherinfo"] objectForKey:@"city"]);
        [self.tableView reloadData];
        
    } errorHandler:^(MKNetworkOperation *errorOp,NSError *err){
        NSLog(@"MKNetwork请求错误:%@",[err localizedDescription]);
    }];
    [engine enqueueOperation:op];
}

@end
