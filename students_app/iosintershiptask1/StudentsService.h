//
//  StudentDataStorage.h
//  iosintership
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 Evgeny Ulyankin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

//#define NotificationStudentsServiceHasHTTPRequests @"NotificationStudentsServiceHasHTTPRequests";
//#define NotificationStudentsServiceHasNoHTTPRequests @"NotificationStudentsServiceHasNoHTTPRequests";
//#define NotificationStudentsServiceStudentsListUpdated @"NotificationStudentsServiceStudentsListUpdated";
//#define NotificationStudentsServiceStudentUpdated @"NotificationStudentsServiceStudentUpdated";
extern NSString * const NotificationStudentsServiceHasHTTPRequests;
extern NSString * const NotificationStudentsServiceHasNoHTTPRequests;
extern NSString * const NotificationStudentsServiceStudentsListUpdated;
extern NSString * const NotificationStudentsServiceStudentUpdated;

@interface StudentsService : NSObject <NSURLSessionDelegate>

@property (strong, nonatomic, readonly) NSArray *studentsList;

- (void)updateStudentsList;
- (void)studentAdd:(Student *)student;
- (void)studentDelete:(Student *)student;
- (void)studentEdit:(Student *)student;

+ (StudentsService *)sharedService;

+ (StudentsService *)alloc __attribute__((unavailable("alloc not available, call sharedService instead.")));
- (StudentsService *)init  __attribute__((unavailable("init not available, call sharedService instead.")));
+ (StudentsService *)new   __attribute__((unavailable("new not available, call sharedService instead.")));

@end
