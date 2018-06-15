//
//  ViewController.m
//  ZZWebImage
//
//  Created by jam on 17-12-9.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+ZZWebImage.h"
#import "ZZHttpTool.h"
#import "MyCell.h"

@interface ViewController ()

@property (nonatomic,strong) NSMutableArray* datasource;

@end

@implementation ViewController

-(NSMutableArray*)datasource
{
    if (_datasource==nil) {
        _datasource=[NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=100;
    
    [ZZHttpTool get:@"https://movie.douban.com/j/search_subjects?type=movie&tag=%E6%AC%A7%E7%BE%8E&page_limit=50&page_start=0" params:nil usingCache:NO success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSArray* subjects=[dict valueForKey:@"subjects"];
        [self.datasource removeAllObjects];
        [self.datasource addObjectsFromArray:subjects];
        [self.tableView reloadData];
    } failure:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    NSDictionary* dic=[self.datasource objectAtIndex:indexPath.row];
    cell.title.text=[dic valueForKey:@"title"];
    [cell.image zz_setImageUrl:[dic valueForKey:@"cover"]];
    cell.desc.text=[dic valueForKey:@"rate"];
    return cell;
}

@end
