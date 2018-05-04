//
//  class.m
//  作业派-学生端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "class.h"

@implementation class_message
- (instancetype)initWithName:(NSString *)class_name
                 course_name:(NSString *)course_name
                teacher_name:(NSString *)teacher_name
                 school_name:(NSString *)school_name
                  start_time:(NSString *)start_time
                   course_id:(NSString *)course_id
                    class_id:(NSString *)class_id
                  teacher_id:(NSString *)teacher_id;
{
    self = [super init];
    if (self) {
        self.teacher_name = teacher_name;
        self.course_name = course_name;
        self.class_name=class_name;
        self.school_name=school_name;
        self.start_time=start_time;
        self.course_id=course_id;
        self.class_id=class_id;
        self.teacher_id=teacher_id;
    }
    return self;
}
+ (instancetype)classWithName:(NSString *)class_name
                  course_name:(NSString *)course_name
                 teacher_name:(NSString *)teacher_name
                  school_name:(NSString *)school_name
                   start_time:(NSString *)start_time
                    course_id:(NSString *)course_id
                     class_id:(NSString *)class_id
                   teacher_id:(NSString *)teacher_id;
{
    return [[class_message alloc] initWithName:class_name
                                   course_name:course_name
                                  teacher_name:teacher_name
                                   school_name:school_name
                                    start_time:start_time
                                     course_id:course_id
                                      class_id:class_id
                                    teacher_id:teacher_id];
}

@end
