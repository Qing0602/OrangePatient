//
//  OrangeDropControl.m
//  OrangePatient
//
//  Created by ZhangQing on 15/5/8.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "OrangeDropControl.h"

@implementation OrangeDropControl
-(NSArray *)tableviewData
{
    if (!_tableviewData) {
        _tableviewData = [self.datasouce arrarOfDropControl:self];
        if (_tableviewData.count > 0) {
            [_bgBtn setTitle:[_tableviewData objectAtIndex:0] forState:UIControlStateNormal];
        }
    }
    return _tableviewData;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.backgroundColor = [UIColor greenColor];
        [_bgBtn setFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];
        _bgBtn.tag = 1;
        if ([self.datasouce arrarOfDropControl:self].count > 0) {
            [self.bgBtn setTitle:[self.tableviewData objectAtIndex:0] forState:UIControlStateNormal];
        }
        [_bgBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender){
            switch (_bgBtn.tag) {
                case 1:
                {
                    [self openTableview];
                }
                    break;
                case 2:
                {
                    [self closeTableview];
                }
                    break;
                default:
                    break;
            }
        }];
        [self addSubview:_bgBtn];
        
        _dropControlTableview = [[UITableView alloc] initWithFrame:CGRectMake(0.f, frame.size.height, frame.size.width, 0.f) style:UITableViewStylePlain];
        _dropControlTableview.delegate = self;
        _dropControlTableview.dataSource = self;
        _dropControlTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_dropControlTableview];
        
        
        
    }
    return self;
}
-(void)openTableview
{
    _bgBtn.tag = 2;
    [UIView animateWithDuration:0.4 animations:^{
        [self.dropControlTableview setFrame:CGRectMake(0.f, self.frame.size.height, self.frame.size.width, 100.f)];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+self.dropControlTableview.frame.size.height)];
    }];
}
-(void)closeTableview
{
    _bgBtn.tag= 1;
    [UIView animateWithDuration:0.4 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-self.dropControlTableview.frame.size.height)];
        [self.dropControlTableview setFrame:CGRectMake(0.f, self.frame.size.height, self.frame.size.width, 0.f)];
        
    }];
}
-(NSString *)currentTitle
{
    return _bgBtn.titleLabel.text;
}
-(void)setCurrentTitle:(NSString *)title
{
    [_bgBtn setTitle:title forState:UIControlStateNormal];
}
#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableviewData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIden = @"dropControlCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    cell.textLabel.text = [self.tableviewData  objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *chooseTitle = [self.tableviewData objectAtIndex:indexPath.row] ;
    [self.bgBtn setTitle:chooseTitle forState:UIControlStateNormal];
    [self closeTableview];
    
    if ([self.delegate respondsToSelector:@selector(valueChanged:withChooseTitle:)]) {
        [self.delegate valueChanged:self withChooseTitle:chooseTitle];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
