//
//  Student.h
//  studentListJson
//
//  Created by eugenerdx on 04.04.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString * studentID;
@property (strong, nonatomic) NSString * studentFirstName;
@property (strong, nonatomic) NSString * studentLastName;
@property (strong, nonatomic) NSString * studentEmail;
@property (strong, nonatomic) NSString * studentPhone;
@property (strong, nonatomic) NSString * studentPhoto;
@property (strong, nonatomic) NSString * studentDateCreated;
@property (strong, nonatomic) NSString * studentDateUpdated;


- (id) initWithStudentID: (NSString *) stID
andStudentFirstName: (NSString *) stFirstName
andStudentLastName: (NSString *) stLastName
andStudentEmail: (NSString *) stEmail
andStudentPhone: (NSString *) stPhone
andStudentPhoto: (NSString *) stPhoto
andStudentDateCreated: (NSString *) stDateCreated
andStudentDateUpdated: (NSString *) stDateUpdated;


@end
