//
//  AddNewStudentViewController.h
//  iosintershiptask1
//
//  Created by eugenerdx on 31.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
@interface AddNewStudentViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) Student* addStudent;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *arrayFields;
@property (strong, nonatomic) IBOutlet UIImageView* imageView;
@property (assign, nonatomic) BOOL atPresent;

- (IBAction) pickImage:(id)sender;

@end