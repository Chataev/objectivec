//
//  Student.m
//  iosintership
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 Evgeny Ulyankin. All rights reserved.
//

#import "Student.h"

@implementation Student

- (Student *)initWithName:(NSString *)firstName
                 lastName:(NSString *)lastName
                    email:(NSString *)email
                    phone:(NSString *)phoneNumber
                    imageData:(NSData  *)imageData
                    image:(UIImage *) studentImage
                studentID:(NSString *)studentID;

{
    self = [super init];
    if (self)
    {
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _phoneNumber = phoneNumber;
        _studentImage = studentImage;
        _imageData = imageData;
        _studentID = studentID;
    }
        return self;
}

+ (Student *)initWithName:(NSString *)firstName
                 lastName:(NSString *)lastName
                    email:(NSString *)email
                    phone:(NSString *)phoneNumber
                    image:(UIImage *)studentImage
                    imageData:(NSData  *)imageData
                studentID:(NSString *)studentID

{
    return [[Student alloc] initWithName:firstName lastName:lastName email:email phone:phoneNumber imageData:imageData image:studentImage studentID:studentID];
}


@end


