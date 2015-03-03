//
//

#import "UILabel+Base.h"

@implementation UILabel (Base)
+ (UILabel *)getNavBarTitleLabel:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.text = text;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.minimumScaleFactor = 0.5;
    titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9];
    titleLabel.shadowColor = [UIColor darkGrayColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor clearColor];
    return titleLabel;
}
@end


@implementation UILabel (ContentSize)

- (CGSize)contentSize {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:self.frame.size
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}
@end