//
//  ViewController.m
//  studentListJson
//
//  Created by eugenerdx on 04.04.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


#define getDataURL @"https://192.168.1.107/studentlist/json.php"

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Students of ios intership";
    [self retrieveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.studentsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
//    Student* cellStudent = [dataController.studentList objectAtIndex:indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", cellStudent.firstName, cellStudent.lastName];
    
    Student * currentStudent = [self.studentsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentStudent.studentFirstName;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - methods
-(void) retrieveData{
    NSURL *url = [NSURL URLWithString:getDataURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.studentsArray = [[NSMutableArray alloc] init];
    for (int i =0; i < self.json.count; i++) {
        NSString * stID = [[self.json objectAtIndex:i] objectForKey:@"id"];
        NSString * stFirstName = [[self.json objectAtIndex:i] objectForKey:@"first_name"];
        NSString * stLastName = [[self.json objectAtIndex:i] objectForKey:@"last_name"];
        NSString * stEmail = [[self.json objectAtIndex:i] objectForKey:@"phone_number"];
        NSString * stPhone = [[self.json objectAtIndex:i] objectForKey:@"e-mail"];
        NSString * stPhoto = [[self.json objectAtIndex:i] objectForKey:@"photo"];
        NSString * stDateCreated = [[self.json objectAtIndex:i] objectForKey:@"created_date"];
        NSString * stDateUpdated = [[self.json objectAtIndex:i] objectForKey:@"updated_date"];

        Student *myStudent = [[Student alloc] initWithStudentID:stID andStudentFirstName:stFirstName andStudentLastName:stLastName andStudentEmail:stEmail andStudentPhone:stPhone andStudentPhoto:stPhoto andStudentDateCreated:stDateCreated andStudentDateUpdated:stDateUpdated];
        [self.studentsArray addObject:myStudent];
    }
    [self.myTableView reloadData];
}
@end
