//
//  Student.m
//  studentListJson
//
//  Created by eugenerdx on 04.04.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "Student.h"

@implementation Student
- (id) initWithStudentID: (NSString *) stID
     andStudentFirstName: (NSString *) stFirstName
      andStudentLastName: (NSString *) stLastName
         andStudentEmail: (NSString *) stEmail
         andStudentPhone: (NSString *) stPhone
         andStudentPhoto: (NSString *) stPhoto
   andStudentDateCreated: (NSString *) stDateCreated
   andStudentDateUpdated: (NSString *) stDateUpdated
{
    if(self){
        self.studentID = stID;
        self.studentFirstName = stFirstName;
        self.studentLastName = stLastName;
        self.studentEmail = stEmail;
        self.studentPhone = stPhone;
        self.studentPhoto= stPhoto;
        self.studentDateCreated = stDateCreated;
        self.studentDateUpdated = stDateUpdated;

 
    }
    return self;
}
@end
