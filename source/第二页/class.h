//
//  class.h
//  作业派-学生端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface class_message : NSObject
@property (copy, nonatomic) NSString *class_id;
@property (copy, nonatomic) NSString *class_name;
@property (copy, nonatomic) NSString *course_id;
@property (copy, nonatomic) NSString *course_name;
@property (copy, nonatomic) NSString *teacher_name;
@property (copy, nonatomic) NSString *school_name;
@property (copy, nonatomic) NSString *start_time;
@property (copy, nonatomic) NSString *teacher_id;

- (instancetype)initWithName:(NSString *)class_name
                 course_name:(NSString *)course_name
                teacher_name:(NSString *)teacher_name
                 school_name:(NSString *)school_name
                  start_time:(NSString *)start_time
                   course_id:(NSString *)course_id
                    class_id:(NSString *)class_id
                   teacher_id:(NSString *)teacher_id;
+ (instancetype)classWithName:(NSString *)class_name
                  course_name:(NSString *)course_name
                 teacher_name:(NSString *)teacher_name
                  school_name:(NSString *)school_name
                   start_time:(NSString *)start_time
                    course_id:(NSString *)course_id
                     class_id:(NSString *)class_id
                   teacher_id:(NSString *)teacher_id;

@end
