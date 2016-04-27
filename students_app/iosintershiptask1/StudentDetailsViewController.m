//
//  StudentDetailsViewController.m
//  iosintershiptask1
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "StudentDetailsViewController.h"


@interface StudentDetailsViewController ()
{
}

@end
 @implementation StudentDetailsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"200"]];
    [self.firstNameTextField setText:[self.student firstName]];
    [self.lastNameTextField setText:[self.student lastName]];
    [self.phoneNumberTextField setText:[self.student phone]];
    [self.emailTextField setText:[self.student email]];
    NSLog(@"%d", self.editing);
    
    NSString *imageURL = [NSString stringWithFormat:@"https://linneage.ru/phpuploadtutorial/showimage.php?id=%@", [self.student studentId]];
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.imageStudent.image = [UIImage imageWithData:data];
    
    
    [self.firstNameTextField setEnabled:NO];
    [self.lastNameTextField setEnabled:NO];
    [self.phoneNumberTextField setEnabled:NO];
    [self.emailTextField setEnabled:NO];
    
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                            target:self
                         action:@selector(editButton:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)editButton:(UIBarButtonItem *)sender
{
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    item = UIBarButtonSystemItemEdit;

    if(self.editing == NO){
        self.editing = YES;

        item = UIBarButtonSystemItemDone;
        [self.firstNameTextField setEnabled:YES];
        [self.lastNameTextField setEnabled:YES];
        [self.phoneNumberTextField setEnabled:YES];
        [self.emailTextField setEnabled:YES];
        
        NSLog(@"%d", self.editing);
    }else if(self.editing == YES){
        self.editing = NO;
        item = UIBarButtonSystemItemEdit;
        [self.firstNameTextField setEnabled:NO];
        [self.lastNameTextField setEnabled:NO];
        [self.phoneNumberTextField setEnabled:NO];
        [self.emailTextField setEnabled:NO];
        
        NSLog(@"%d", self.editing);

        NSString* firstName   = [self.firstNameTextField text];
        NSString* lastName    = [self.lastNameTextField text];
        NSString* email       = [self.emailTextField text];
        NSString* phone = [self.phoneNumberTextField text];
        NSString * studentID = self.student.studentId;

        
    [[StudentsService sharedService] studentEdit:[Student studentWithId:studentID firstName:firstName lastName:lastName email:email phone:phone createdDate:nil updatedDate:nil image:nil]];
        NSLog(@"%@ %@ %@ %@", firstName, lastName, email, phone);
        





    }
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(editButton:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:NO];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


@end
