//
//  HealthInformationTableViewCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/25.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#define ImageWidth 75.f
#define CellPadding 5.f
#import "HealthInformationTableViewCell.h"

@implementation HealthInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellImageview = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"Information_Cell_DefaultImage"]];
        _cellImageview.translatesAutoresizingMaskIntoConstraints = NO;
        _cellImageview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_cellImageview];
        
        _cellTitle = [[UILabel alloc] init];
        _cellTitle.font = [UIFont systemFontOfSize:14.f];
        _cellTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellTitle];
        
        _cellContent = [[UIWebView alloc] init];
        _cellContent.scrollView.showsHorizontalScrollIndicator = NO;
        _cellContent.scrollView.showsVerticalScrollIndicator = NO;
        _cellContent.scrollView.scrollEnabled = NO;
        _cellContent.delegate = self;
        _cellContent.userInteractionEnabled = NO;
        //_cellContent.font = [UIFont systemFontOfSize:12.f];
        //_cellContent.textColor = [UIColor lightGrayColor];
        //_cellContent.numberOfLines = 3;
        //_cellContent.backgroundColor = [UIColor greenColor];
        _cellContent.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellContent];
        
        [_cellImageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(CellPadding);
            make.left.mas_equalTo(CellPadding);
            make.width.mas_equalTo(ImageWidth);
            make.height.mas_equalTo(ImageWidth);
        }];
        
        [_cellTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(CellPadding);
            make.left.equalTo(_cellImageview.mas_right).with.offset(10);
            make.right.mas_equalTo(-CellPadding);
            make.height.mas_equalTo(14);
        }];
        
        [_cellContent mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_cellTitle.mas_bottom).with.offset(6);
            make.left.equalTo(_cellTitle.mas_left);
            make.right.mas_equalTo(-CellPadding);
            make.bottom.mas_equalTo(-CellPadding);
        }];
        
        /*
        NSDictionary *views = NSDictionaryOfVariableBindings(_cellImageview,_cellTitle,_cellContent);
        NSDictionary *metrics = @{@"ImageWidth":@ImageWidth,@"CellPadding":@CellPadding};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellTitle(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellContent(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellImageview(ImageWidth)]-CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellTitle(14)]->=6-[_cellContent(>=50)]-CellPadding-|" options:0 metrics:metrics views:views]];
        */
    }
    return self;
}

- (void)setContentByInfoModel:(HealthInfomationModel *)model
{
    [self.cellImageview setImageURL:model.bigImageUrl];
    [self.cellTitle setText:model.infoTitle];
    [self.cellContent loadHTMLString:model.infoContent baseURL:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar

    [self.cellContent stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'"];
    [self.cellContent stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'lightGray'"];
}
@end
