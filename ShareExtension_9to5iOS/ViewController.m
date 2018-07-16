//
//  ViewController.m
//  ShareExtension_9to5iOS
//
//  Created by admin on 16/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewController.h"
static NSString *const AppGrpId = @"group.tag.AppDemoGroup";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:AppGrpId];
    arr_shareLinks = [NSMutableArray arrayWithArray:[sharedUserDefaults valueForKey:@"9to5iOS_SharedExtension"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_shareLinks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text = [[arr_shareLinks objectAtIndex:indexPath.row] valueForKey:@"URL"];
    cell.detailTextLabel.text = [[arr_shareLinks objectAtIndex:indexPath.row] valueForKey:@"contentText"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[arr_shareLinks objectAtIndex:indexPath.row] valueForKey:@"URL"]]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
