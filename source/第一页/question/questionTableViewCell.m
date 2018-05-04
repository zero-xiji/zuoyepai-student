//
//  questionTableViewCell.m
//  作业派-学生端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import "questionTableViewCell.h"
#import "homeworkViewController.h"
@implementation questionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//使用懒加载创建分割线view,保证一个cell只有一条
-(UIView *)separatorView
{
    if (_separatorView == nil) {
        UIView *separatorView = [[UIView alloc]init];
        self.separatorView = separatorView;
        separatorView.backgroundColor = [UIColor brownColor];
        [self addSubview:separatorView];
    }
    return _separatorView;
}

//重写layoutSubViews方法，设置位置及尺寸
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.separatorView.frame = CGRectMake(0, self.bounds.size.height-1,     self.bounds.size.width, 2);
}

-(void)setModel:(question *)model{
    _model = model;
    _question_id=model.question_id;
    self.is_submit=model.is_submit;
    _question_type_Str=model.question_type;
    _question_score_Str=model.question_score;
    _question_detail.text=model.question_detail;
    _question_answer=model.question_answer;
    _my_answer=model.my_answer;
    _my_score=model.my_score;
    _is_correcting=model.is_correcting;
    _my_question_answer.hidden=YES;
    _l_question_answer.text=model.question_answer;
    _l_my_question_answer.text=model.my_answer;
    if(![model.my_answer isEqualToString:@"空"])
    {
        _l_my_question_answer.textColor=[UIColor blackColor];
    }
    else
    {
        _l_my_question_answer.textColor=[UIColor darkGrayColor];
        if(select_homework_cell.is_time_over==YES && [select_homework_cell.is_submit isEqualToString:@"0"])
        {
            _l_my_question_answer.text=@"点击作答";
            _l_my_question_answer.textColor=[UIColor greenColor];
        }
    }
    if(model.is_correcting==0)
    {
        _question_score.text=[NSString stringWithFormat:@"分数：%@",model.question_score];
    }
    else
    {
        if(![model.my_score isEqualToString:model.question_score])
        {
            _question_score.textColor=[UIColor redColor];
            _l_my_question_answer.textColor=[UIColor redColor];
        }
        else
        {
            _question_score.textColor=[UIColor greenColor];
            _l_my_question_answer.textColor=[UIColor greenColor];
        }
        _question_score.text=[NSString stringWithFormat:@"分数：%@/%@",model.my_score,model.question_score];
    }
    if([model.question_type isEqualToString:@"0"])
    {
        _question_type.text=@" 单选题 ";
    }
    else if([model.question_type isEqualToString:@"1"])
    {
        _question_type.text=@" 判断题 ";
    }
    else
    {
        _question_type.text=@" 填空／简答题 ";
    }
}
@end
