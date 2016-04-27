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

@property (nonatomic, copy, readonly) NSString *studentId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, strong) UIImage *image;

#pragma mark - Methods

+ (Student *)studentWithId:(NSString *)studentId
                 firstName:(NSString *)firstName
                  lastName:(NSString *)lastName
                     email:(NSString *)email
                     phone:(NSString *)phone
               createdDate:(NSString *)created
               updatedDate:(NSString *)updated
                     image:(UIImage *)image;

@end
