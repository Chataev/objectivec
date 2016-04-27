//
//  StudentListViewController.m
//  iosintershiptask1
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "StudentListViewController.h"
#import "StudentDetailsViewController.h"
#import "StudentAddViewController.h"
#import "StudentsService.h"

@interface StudentListViewController ()
{

}


@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"200"]];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor orangeColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTable)
                  forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleStudentsListUpdated) name:NotificationStudentsServiceStudentsListUpdated object:nil];
}

- (void)handleStudentsListUpdated
{
    [self.tableView reloadData];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void)refreshTable
{
    [self.refreshControl endRefreshing];

    [[StudentsService sharedService] updateStudentsList];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButton:(UIBarButtonItem *)sender{
    BOOL isEditing = self.tableView.editing;
    [self.tableView setEditing:!isEditing animated:YES];
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    if(self.tableView.editing)
    {
        item=UIBarButtonSystemItemDone;
    }
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(editButton:)];
    [self.navigationItem setLeftBarButtonItem:editButton
                                     animated:YES];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
       
        Student* cellStudent = [[StudentsService sharedService].studentsList objectAtIndex:indexPath.row];
        
        NSString *studentID =  cellStudent.studentId;
        
        
        [[StudentsService sharedService] studentDelete:[Student studentWithId:studentID firstName:nil lastName:nil email:nil phone:nil createdDate:nil updatedDate:nil image:nil]];
        
        
        
        [[StudentsService sharedService] updateStudentsList];

        [self.tableView reloadData];

        
      
    }
}

- (IBAction)cancel:(UIStoryboardSegue*)segue
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)save:(UIStoryboardSegue*)segue
{
//AddNewStudentViewController *addNewStudentController = [segue sourceViewController];
//Student* newStudent = [addNewStudentController addStudent];
    
    [self dismissViewControllerAnimated:true
                             completion:nil];

//[[StudentsService sharedService] studentAdd:newStudent];
    
   // NSLog(@"new student = %@", newStudent);
    
    [[StudentsService sharedService] updateStudentsList];
    
    [self.tableView reloadData];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"detailSegue"])
    {
        StudentDetailsViewController* destination = [segue destinationViewController];
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        
        destination.selectedStudentId = index;
        
       
        Student* selectedStudent=[[StudentsService sharedService].studentsList objectAtIndex:index];
        destination.student = selectedStudent;
    
    
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [StudentsService sharedService].studentsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell"
                                                            forIndexPath:indexPath];
    Student* cellStudent = [[StudentsService sharedService].studentsList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", cellStudent.firstName, cellStudent.lastName];

    return cell;
}


@end
