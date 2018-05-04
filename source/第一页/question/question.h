//
//  question.h
//  作业派-学生端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface question : NSObject

@property NSString *question_id;
@property NSString *homework_id;
@property NSString *question_detail;
@property NSString *question_answer;
@property NSString *question_score;
@property NSString *question_type;
@property NSString *is_submit;
@property int is_correcting;
@property NSString *my_answer;
@property NSString *my_score;
- (instancetype)initWithName:(NSString *)question_id
                 homework_id:(NSString *)homework_id
             question_detail:(NSString *)question_detail
             question_answer:(NSString *)question_answer
              question_score:(NSString *)question_score
               question_type:(NSString *)question_type
                   is_submit:(NSString *)is_submit
                   my_answer:(NSString *)my_answer
                    my_score:(NSString *)my_score
               is_correcting:(int)is_correcting;
+ (instancetype)question_in_homeworkWithName:(NSString *)question_id
                                 homework_id:(NSString *)homework_id
                             question_detail:(NSString *)question_detail
                             question_answer:(NSString *)question_answer
                              question_score:(NSString *)question_score
                               question_type:(NSString *)question_type
                                   is_submit:(NSString *)is_submit
                                   my_answer:(NSString *)my_answer
                                    my_score:(NSString *)my_score
                               is_correcting:(int)is_correcting;
@end
