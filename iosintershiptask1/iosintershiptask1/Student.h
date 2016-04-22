//
//  Student.h
//  iosintership
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 Evgeny Ulyankin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Student : NSObject

#pragma mark - properties

@property (nonatomic, copy, readwrite) NSString * studentID;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* phoneNumber;

@property (nonatomic, copy) NSURL* url;
@property (nonatomic, copy) UIImage* studentImage;

@property (nonatomic, copy) NSData* imageData;

#pragma mark - Methods

+ (Student *)initWithName:(NSString *)firstName
                lastName:(NSString *)lastName
                   email:(NSString *)email
                   phone:(NSString *)phoneNumber
                    image:(UIImage *)studentImage
                   imageData:(NSData *)imageData
               studentID:(NSString *)studentID;

+ (Student *)studentFromURL:(NSString *)URL
               firstName: (NSString *)firstName
                 lastName:(NSString *)lastName
                    email:(NSString *)email
                    phone:(NSString *)phoneNumber
                      image:(UIImage *)studentImage
                    imageData:(NSData *)imageData
                studentID:(NSString *)studentID;

@end
