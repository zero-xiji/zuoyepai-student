//
//  classTableViewCell.m
//  作业派-学生端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "classTableViewCell.h"

@implementation classTableViewCell
class_message *select_class_cell;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (highlighted == YES)
    {
        select_class_cell=[class_message classWithName:_class_name.text
                                           course_name:_course_name.text
                                          teacher_name:_teacher_name.text
                                           school_name:_school_name
                                            start_time:_start_time.text
                                             course_id:_course_id
                                              class_id:_class_id
                                            teacher_id:_teacher_id];
        NSLog(@"class_id = %@",select_class_cell.class_id);
    }
    else
    {
        
    }
    [super setHighlighted:highlighted animated:animated];
}
-(void)setModel:(class_message *)model{
    _model = model;
    _class_name.text=model.class_name;
    _course_name.text=model.course_name;
    _teacher_name.text=model.teacher_name;
    _start_time.text=model.start_time;
    _class_id_in_this_cell=model.class_id;
    self.school_name=model.school_name;
    self.course_id=model.course_id;
    self.class_id=model.class_id;
    self.teacher_id=model.teacher_id;
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
@end
