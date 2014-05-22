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
    cell.textLabel.text=[[_peopleList objectAtIndex:indexPath.row] objectForKey:@"Emp_Name"];
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
    //NSString * partmentUrl=@"http://webservice.ncuhome.cn/NcuhomeUS.asmx/getEmployeeInfoByDep_ID";
    //NSDate * date=[NSDate date];
    //NSString *timeSp=[NSString stringWithFormat:@"%0.f",[date timeIntervalSince1970]];
    //NSLog(@"timeSP=:%@",timeSp);
    NSString *urlString=@"http://www.weather.com.cn/data/sk/101240101.html";
    //NSURL *url=[NSURL URLWithString:partmentUrl];
    //NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSMutableDictionary * people=[[NSMutableDictionary alloc] init];
    [people setValue:_dep_ID forKey:@"Dep_ID"];
    NSURLRequest * request=[[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:nil error:nil];
    AFHTTPRequestOperation *op=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer=[AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON :%@",responseObject);
        _peopleList=[responseObject objectForKey:@"d"];
        [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error:%@",error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

@end
