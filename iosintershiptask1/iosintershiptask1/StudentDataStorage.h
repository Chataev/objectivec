//
//  StudentDataStorage.h
//  iosintership
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 Evgeny Ulyankin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface StudentDataStorage : NSObject

@property (strong, nonatomic, readonly) NSArray* studentList;
@property (strong, nonatomic) NSMutableArray *json;
@property (strong, nonatomic) NSMutableArray *studentsArray;

- (void) retrieveData;
- (void)addNewStudent: (Student*)newStudent;
- (void)deleteStudentWithIndex: (NSUInteger)index;
- (void)editStudentWithIndex: (Student*)student;

@end
