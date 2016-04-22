//
//  StudentListViewController.m
//  iosintershiptask1
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "StudentListViewController.h"
#import "StudentDetailsViewController.h"
#import "AddNewStudentViewController.h"
#import "StudentDataStorage.h"

@interface StudentListViewController ()

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"200"]];
    dataController = [[StudentDataStorage alloc]init];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor orangeColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTable)
                  forControlEvents:UIControlEventValueChanged];
    
    
    
//    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];

    
    
    
}


- (void)refreshTable {

    dataController = [[StudentDataStorage alloc]init];
    [dataController retrieveData];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];


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
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(editButton:)];
    [self.navigationItem setLeftBarButtonItem:editButton animated:YES];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url = [NSURL URLWithString:@"https://linneage.ru/studentlist/delete_student.php"];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        
        Student* cellStudent = [dataController.studentList objectAtIndex:indexPath.row];
        
        NSString *params = [NSString stringWithFormat:@"id=%@", cellStudent.studentID];
        
        NSLog(@"%@", params);
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];

        
        NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        }];
        
        [dataTask resume];

        [dataController deleteStudentWithIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (IBAction)cancel:(UIStoryboardSegue*)segue
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)save:(UIStoryboardSegue*)segue
{
    AddNewStudentViewController *addNewStudentController = [segue sourceViewController];
    Student* newStudent = [addNewStudentController addStudent];
    [self dismissViewControllerAnimated:true completion:nil];

    [dataController addNewStudent:newStudent];
    
    NSLog(@"new student = %@", newStudent);
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"detailSegue"])
    {
        StudentDetailsViewController* destination = [segue destinationViewController];
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        
        destination.selectedStudentId = index;
        
       
        Student* selectedStudent=[dataController.studentList objectAtIndex:index];
        destination.student = selectedStudent;
    
    
     //   dataController.studentList = @[];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataController.studentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    Student* cellStudent = [dataController.studentList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", cellStudent.firstName, cellStudent.lastName];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
