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
    NSString * partmentUrl=@"http://webservice.ncuhome.cn/NcuhomeUS.asmx/getDepartmentInfo";
    //NSURL *url=[NSURL URLWithString:partmentUrl];
    //NSURLRequest *request=[NSURLRequest requestWithURL:url];
   NSMutableDictionary * people=[[NSMutableDictionary alloc] init];
   //[people setValue:@"廖肇兴" forKey:@"Emp_Name"];
    NSURLRequest * request=[[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:partmentUrl parameters:people error:nil];
    AFHTTPRequestOperation *op=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer=[AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON :%@",responseObject);
        //NSData * data=[responseObject responseData];
//        NSDictionary *resDic=[NSJSONSerialization JSONObjectWithData:data
//                                                             options:NSJSONReadingAllowFragments
//                                                               error:nil];
        _partmentList=[responseObject objectForKey:@"d"];
        NSLog(@"partment values :%@",[[_partmentList objectAtIndex:0] objectForKey:@"Dep_Name"]);
        [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error:%@",error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

@end
