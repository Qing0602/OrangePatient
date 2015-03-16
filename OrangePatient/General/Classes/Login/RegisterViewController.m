//
//  RegisterViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 3/11/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = REGISTER_PAGE_TITLE;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:REGISTER_PAGE_TEXT_LOGIN style:UIBarButtonItemStyleDone target:self action:@selector(backToLogin)];
    
    UITableView *registerTable = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, Register_TableviewCell_Height*4+1) style:UITableViewStylePlain];
    registerTable.delegate = self;
    registerTable.dataSource = self;
    registerTable.scrollEnabled = NO;
    //registerTable.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    registerTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:registerTable];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewControllerMethod
- (void)backToLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Register_TableviewCell_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIden = @"registerTableViewCellIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"姓名:";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"出生日期:";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"手机号码:";
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"验证码:";
            }
                break;
            default:
                break;
        }
    }
    
    
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
