//
//  PersonListDataController.m
//  iosintership
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 Evgeny Ulyankin. All rights reserved.
//



#import "StudentsService.h"

NSString * const NotificationStudentsServiceHasHTTPRequests = @"NotificationStudentsServiceHasHTTPRequests";
NSString * const NotificationStudentsServiceStudentsListUpdated = @"NotificationStudentsServiceStudentsListUpdated";

@interface StudentsService()
{
    NSInteger requestsCount;

    
}

@end

@implementation StudentsService

+ (StudentsService *)sharedService
{
    static dispatch_once_t pred;
    static StudentsService *sharedService = nil;
    dispatch_once(&pred, ^
    {
        sharedService = [[super alloc] initUniqueInstance];
    });
    return sharedService;
}

- (StudentsService *)initUniqueInstance
{
    self = [super init];
    if (self)
    {
        [self updateStudentsList];
    }
    
    return self;
}

#pragma mark Internal methods

- (void)increaseRequestsCount
{
    if (requestsCount == 0)
    {
        

        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationStudentsServiceHasHTTPRequests
                                                            object:nil];
    }
    
    requestsCount++;
}

- (void)decreaseRequestsCount
{
    requestsCount--;
    
    if (requestsCount <= 0)
    {
        requestsCount = 0;
         NSString * const NotificationStudentsServiceHasNoHTTPRequests = @"NotificationStudentsServiceHasNoHTTPRequests";
       [[NSNotificationCenter defaultCenter] postNotificationName:NotificationStudentsServiceHasNoHTTPRequests
                                                                                       object:nil];
    }
}

#pragma mark External methods

- (void)updateStudentsList
{
    [self retrieveStudents];
}

- (void)studentAdd:(Student *)student
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:@"https://linneage.ru/studentlist/create_student.php"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"first_name=%@&last_name=%@&phone_number=%@&email=%@&photo=%@", student.firstName, student.lastName, student.phone, student.email, student.phone];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    }];
    
    [dataTask resume];
    
    
    

    NSLog(@"%@ %@ %@ %@", student.firstName, student.lastName, student.email, student.phone);

}

- (void)studentDelete:(Student *)student
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                 delegate: nil
                                                            delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"https://linneage.ru/studentlist/delete_student.php"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *params = [NSString stringWithFormat:@"id=%@", student.studentId];
    
    NSLog(@"%@", params);
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       }];
    
    [dataTask resume];
    
    
 
}

- (void)studentEdit:(Student *)student
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                 delegate: nil
                                                            delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"https://linneage.ru/studentlist/update_student.php"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"id=%@&first_name=%@&last_name=%@&phone_number=%@&email=%@", student.studentId, student.firstName, student.lastName, student.phone, student.email];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       }];
    
    [dataTask resume];
    
    
    
    
    

}

#pragma mark Network requests

- (void)retrieveStudents
{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                 delegate:nil
                                                            delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"https://linneage.ru/studentlist/all_students.php"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (data)
        {
            NSArray *studentsArray = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
            NSMutableArray *tempStudentsArray = [NSMutableArray new];
            for (NSDictionary *student in studentsArray)
            {
                NSString *studentId = [student objectForKey:@"id"];
                NSString *firstName = [student objectForKey:@"first_name"];
                NSString *lastName = [student objectForKey:@"last_name"];
                NSString *email = [student objectForKey:@"email"];
                NSString *phone = [student objectForKey:@"phone_number"];
                NSString *createdDate = [student objectForKey:@"created_date"];
                NSString *updatedDate = [student objectForKey:@"updated_date"];
                
                Student *student = [Student studentWithId:studentId
                                                firstName:firstName
                                                 lastName:lastName
                                                    email:email
                                                    phone:phone
                                              createdDate:createdDate
                                              updatedDate:updatedDate
                                                    image:nil];
                
                [tempStudentsArray addObject:student];
            }
            
            _studentsList = tempStudentsArray;

            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationStudentsServiceStudentsListUpdated object:nil];
        }
        
        [self decreaseRequestsCount];
    }];
    
    [self increaseRequestsCount];
    [dataTask resume];
}



@end
