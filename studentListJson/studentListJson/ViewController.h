//
//  ViewController.h
//  studentListJson
//
//  Created by eugenerdx on 04.04.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *json;
@property (strong, nonatomic) NSMutableArray *studentsArray;

-(void) retrieveData;
@end

