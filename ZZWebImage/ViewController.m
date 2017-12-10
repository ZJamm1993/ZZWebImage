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
#import "VideoObject.h"

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
    
    [ZZHttpTool get:@"http://api.change.so/v1/videos.json?page=1&per_page=29" params:nil usingCache:YES success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSArray* videos=[dict valueForKey:@"videos"];
        for (NSDictionary* vid in videos) {
            VideoObject* vo=[[VideoObject alloc]initWithDictionary:vid];
            if (vo) {
                [self.datasource addObject:vo];
            }
        }
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
    VideoObject* vi=[self.datasource objectAtIndex:indexPath.row];
    [cell.image setImageUrl:vi.poster placeHolder:[UIImage imageNamed:@"placeHolder"]];
    cell.title.text=vi.name;
    cell.desc.text=vi.desc;
    return cell;
}

@end
