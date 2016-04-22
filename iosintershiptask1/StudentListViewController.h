//
//  StudentListViewController.h
//  iosintershiptask1
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentDataStorage.h"
#import "Student.h"
@interface StudentListViewController : UITableViewController
{
    StudentDataStorage* dataController;
}

- (IBAction)cancel:(UIStoryboardSegue*)segue;
- (IBAction)save:(UIStoryboardSegue*)segue;
- (IBAction)editButton:(UIBarButtonItem *)sender;

@property (copy, nonatomic) NSMutableArray * studentsArray;
@property (strong, nonatomic) Student* student;

@end
