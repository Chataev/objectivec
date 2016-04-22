//
//  StudentDetailsViewController.h
//  iosintershiptask1
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
@interface StudentDetailsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageStudent;

@property (strong, nonatomic) Student* student;
@property (strong, nonatomic) Student* editStudent;


- (IBAction)editButton:(id)sender;

@property (assign) NSInteger selectedStudentId;


@end
