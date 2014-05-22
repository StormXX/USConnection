//
//  PartmentList.m
//  USConnect
//
//  Created by Gintama on 14-4-24.
//  Copyright (c) 2014年 Gintama. All rights reserved.
//

#import "PartmentList.h"

@interface PartmentList ()

@end

@implementation PartmentList
@synthesize partmentList=_partmentList;
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
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    NSLog(@"request begin");
    [self getPartment];
    NSLog(@"request end");
    if(_partmentList.count!=0)
    {
        NSLog(@"partment values :%@",[_partmentList objectAtIndex:0]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _partmentList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[[_partmentList objectAtIndex:indexPath.row] objectForKey:@"Dep_Name"];
    // Configure the cell...
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleInPartment * p=[[PeopleInPartment alloc] init];
    p.dep_ID=[[_partmentList objectAtIndex:indexPath.row] objectForKey:@"Dep_ID"];
    [self.navigationController pushViewController:p animated:YES];
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


-(void)getPartment
{
    NSMutableDictionary * header=[[NSMutableDictionary alloc] init];
    [header setValue:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    NSString *path=[[NSString alloc] initWithFormat:@"/NcuhomeUS.asmx/getDepartmentInfo"];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:@"webservice.ncuhome.cn" customHeaderFields:header];
    MKNetworkOperation *op=[engine operationWithPath:path params:nil httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        //NSLog(@"responseData:%@",[operation responseString]);
        NSData *data=[operation responseData];
        NSDictionary *resDict=[NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingAllowFragments
                                                                error:nil];
        _partmentList=[resDict objectForKey:@"d"];
        NSLog(@"partment values :%@",[[_partmentList objectAtIndex:0] objectForKey:@"Dep_Name"]);
        [self.tableView reloadData];
        
    } errorHandler:^(MKNetworkOperation *errorOp,NSError *err){
        NSLog(@"MKNetwork请求错误:%@",[err localizedDescription]);
    }];
    [engine enqueueOperation:op];
}

@end
