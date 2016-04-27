//
//  Student.m
//  iosintership
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 Evgeny Ulyankin. All rights reserved.
//

#import "Student.h"

@implementation Student

- (Student *)initWithId:(NSString *)studentId
              firstName:(NSString *)firstName
               lastName:(NSString *)lastName
                  email:(NSString *)email
                  phone:(NSString *)phone
            createdDate:(NSString *)created
            updatedDate:(NSString *)updated
                  image:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _studentId = studentId;
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _phone = phone;
        _created = created;
        _updated = updated;
        _image = image;
    }
    
    return self;
}

+ (Student *)studentWithId:(NSString *)studentId
                 firstName:(NSString *)firstName
                  lastName:(NSString *)lastName
                     email:(NSString *)email
                     phone:(NSString *)phone
               createdDate:(NSString *)created
               updatedDate:(NSString *)updated
                     image:(UIImage *)image
{
    return [[Student alloc] initWithId:(NSString *)studentId
                             firstName:(NSString *)firstName
                              lastName:(NSString *)lastName
                                 email:(NSString *)email
                                 phone:(NSString *)phone
                           createdDate:(NSString *)created
                           updatedDate:(NSString *)updated
                                 image:(UIImage *)image];

}

@end


