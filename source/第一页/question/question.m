//
//  question.m
//  作业派-学生端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import "question.h"

@implementation question
- (instancetype)initWithName:(NSString *)question_id
                 homework_id:(NSString *)homework_id
             question_detail:(NSString *)question_detail
             question_answer:(NSString *)question_answer
              question_score:(NSString *)question_score
               question_type:(NSString *)question_type
                   is_submit:(NSString *)is_submit
                   my_answer:(NSString *)my_answer
                    my_score:(NSString *)my_score
               is_correcting:(int)is_correcting
{
    self = [super init];
    if (self) {
        self.question_id = question_id;
        self.homework_id=homework_id;
        self.question_detail=question_detail;
        self.question_answer=question_answer;
        self.question_score=question_score;
        self.question_type=question_type;
        self.is_submit=is_submit;
        self.my_answer=my_answer;
        self.my_score=my_score;
        self.is_correcting=is_correcting;
    }
    return self;

}
+ (instancetype)question_in_homeworkWithName:(NSString *)question_id
                                 homework_id:(NSString *)homework_id
                             question_detail:(NSString *)question_detail
                             question_answer:(NSString *)question_answer
                              question_score:(NSString *)question_score
                               question_type:(NSString *)question_type
                                   is_submit:(NSString *)is_submit
                                   my_answer:(NSString *)my_answer
                                    my_score:(NSString *)my_score
                               is_correcting:(int)is_correcting

{
    return [[question alloc] initWithName:question_id
                              homework_id:homework_id
                          question_detail:question_detail
                          question_answer:question_answer
                           question_score:question_score
                            question_type:question_type
                                is_submit:is_submit
                                my_answer:my_answer
                                 my_score:my_score
                            is_correcting:is_correcting];
}

@end
