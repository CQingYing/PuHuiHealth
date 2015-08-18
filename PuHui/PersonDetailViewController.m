//
//  PersonDetailViewController.m
//  PuHui
//
//  Created by administrator on 15/8/14.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "PersonDetailCell.h"

@interface PersonDetailViewController ()

@property (strong, nonatomic) UITableView *mainView;

@end

@implementation PersonDetailViewController

- (NSMutableArray *)data {
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (instancetype)initWithData:(NSMutableArray *)mydata {
    self = [super init];
    if (self) {
        _data = mydata;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.mainView];
    [self.mainView setDelegate:self];
    [self.mainView setDataSource:self];
    self.mainView.rowHeight = 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ids = @"cells";
    PersonDetailCell *cell = [self.mainView dequeueReusableCellWithIdentifier:ids];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonDetailCell" owner:nil options:nil] lastObject];
    }
    
    cell.Name.text = (NSString *)([self.data objectAtIndex:indexPath.row][@"itemName"]);
    
    //NSLog(@"^^^%@",[self.data objectAtIndex:indexPath.row][@"itemRetail"]);
    NSNumber *temp = [self.data objectAtIndex:indexPath.row][@"itemRetail"];
    cell.Retail.text = [NSString stringWithFormat:@"原价：¥%@",temp];
    temp = [self.data objectAtIndex:indexPath.row][@"itemCost"];
    cell.Cost.text = [NSString stringWithFormat:@"折扣价：¥%@",temp];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
