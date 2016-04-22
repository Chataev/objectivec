//
//  PersonListDataController.m
//  iosintership
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 Evgeny Ulyankin. All rights reserved.
//

#import "StudentDataStorage.h"

#define getDataURL @"https://linneage.ru/studentlist/all_students.php"

@interface StudentDataStorage ()
{
//    __strong
    NSMutableArray *tempStudentsArray;
//    __weak NSMutableArray *tempStudentsArray2;
//    __unsafe_unretained

}

@end
@implementation StudentDataStorage
- (id)init
{
    self = [super init];
    if(self)
    {
//        Student* student1 = [Student initWithName:@"Eugene" lastName:@"Ulyankin" email:@"thelikelove@gmail.com" phone:@"+7930111222" image:[UIImage imageNamed:@"eugene"] studentID:@""];
//        Student* student2 = [Student initWithName:@"Gleb" lastName:@"Chataev" email:@"gleb@ya.ru" phone:@"+7930111333" image:[UIImage imageNamed:@"gleb"] studentID:@""];
//        Student* student3 = [Student initWithName:@"Ekaterina" lastName:@"Shiryaeva" email:@"shiryaeva@ya.ru" phone:@"+7930111444"  image:[UIImage imageNamed:@"kate"] studentID:@""];
//        Student* student4 = [Student initWithName:@"Daria" lastName:@"Krupnova" email:@"krupnova@ya.ru" phone:@"+7930111555"  image:[UIImage imageNamed:@"daria"]studentID:@""];
//        Student* student5 = [Student initWithName:@"Anna" lastName:@"Ilicheva" email:@"ilicheva@ya.ru" phone:@"+7930111666" image:[UIImage imageNamed:@"anna"]studentID:@""];
//       
//        tempStudentsArray = [NSMutableArray arrayWithObjects:student1, student2, student3, student4, student5, nil];
//        
//       _studentList = [tempStudentsArray copy];
//
        [self retrieveData];

    }
    return self;
}



#pragma mark - methods
-(void) retrieveData{
    NSURL *url = [NSURL URLWithString:getDataURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.studentsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.json.count; i++) {
        NSString * stID = [[self.json objectAtIndex:i] objectForKey:@"id"];
        NSString * stFirstName = [[self.json objectAtIndex:i] objectForKey:@"first_name"];
        NSString * stLastName = [[self.json objectAtIndex:i] objectForKey:@"last_name"];
        NSString * stEmail = [[self.json objectAtIndex:i] objectForKey:@"email"];
        NSString * stPhone = [[self.json objectAtIndex:i] objectForKey:@"phone_number"];
        NSData * stPhoto = [[self.json objectAtIndex:i] objectForKey:@"photo"];
    //   UIImage * stImage = [UIImage initWithData:stPhoto];
       // NSData *imageData = (self.student.imageData);
      //  self.imageStudent.image = [[UIImage alloc]initWithData:imageData];
      //  UIImage *img = [UIImage imageWithData:stPhoto];
        //self.imageStudent.image = img;
        NSString * stDateCreated = [[self.json objectAtIndex:i] objectForKey:@"created_date"];
        NSString * stDateUpdated = [[self. json objectAtIndex:i] objectForKey:@"updated_date"];
        
        Student *newStudent = [Student initWithName:stFirstName lastName:stLastName email:stEmail phone:stPhone image:nil imageData:stPhoto studentID:stID];
        [self.studentsArray addObject:newStudent];
        _studentList = [self.studentsArray copy];
    }
    //[self.myTableView reloadData];
}




-(void)addNewStudent:(Student *)newStudent
{
        [self.studentsArray addObject:newStudent];
//       _studentList = [tempStudentsArray copy];
    _studentList = [self.studentsArray copy];

}


- (void)deleteStudentWithIndex:(NSUInteger)index
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.studentList];
        [tempArray removeObjectAtIndex:index];
       _studentList = [tempArray copy];
}

-(NSMutableArray *)returnArray
{
    return tempStudentsArray;
}

@end
