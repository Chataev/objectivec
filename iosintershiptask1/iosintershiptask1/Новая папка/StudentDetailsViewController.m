//
//  StudentDetailsViewController.m
//  iosintershiptask1
//
//  Created by eugenerdx on 28.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "StudentDetailsViewController.h"

@interface StudentDetailsViewController ()

@end

@implementation StudentDetailsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"200"]];
    [self.firstNameTextField setText:[self.student firstName]];
    [self.lastNameTextField setText:[self.student lastName]];
    [self.phoneNumberTextField setText:[self.student phoneNumber]];
    [self.emailTextField setText:[self.student email]];
//    UIImage *student = [self.student image];
//    self.imageStudent.image = student;
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
    BOOL isEditing = self.tableView.editing;
    [self.tableView setEditing:!isEditing animated:NO];
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if(self.tableView.editing){
        item = UIBarButtonSystemItemDone;
        [self.firstNameTextField setEnabled:YES];
        [self.lastNameTextField setEnabled:YES];
        [self.phoneNumberTextField setEnabled:YES];
        [self.emailTextField setEnabled:YES];
    }else{
        item = UIBarButtonSystemItemEdit;
        [self.firstNameTextField setEnabled:NO];
        [self.lastNameTextField setEnabled:NO];
        [self.phoneNumberTextField setEnabled:NO];
        [self.emailTextField setEnabled:NO];
        
        
        NSString* firstName   = [self.firstNameTextField text];
        NSString* lastName    = [self.lastNameTextField text];
        NSString* email       = [self.emailTextField text];
        NSString* phoneNumber = [self.phoneNumberTextField text];
        
        
        UIImage *image = [UIImage imageNamed:@"daria.png"];
        NSData *imageData = UIImagePNGRepresentation(image);
        
        

        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        NSURL *url = [NSURL URLWithString:@"https://linneage.ru/studentlist/update_student.php"];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *params = [NSString stringWithFormat:@"id=%@&first_name=%@&last_name=%@&phone_number=%@&email=%@&photo=%@", self.student.studentID, firstName, lastName, phoneNumber, email, imageData];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
        
        
        
        NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        }];
        
        [dataTask resume];
        
        self.editStudent = [Student initWithName:firstName lastName:lastName email:email phone:phoneNumber image:nil studentID:@""];
        NSLog(@"%@ %@ %@ %@", firstName, lastName, email, phoneNumber);
        


    }
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(editButton:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:NO];
}





- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#define loadImageUrl @"https://linneage.ru/studentlist/all_students.php"


//-(void) retriveImageData
//{
//    //NSURL *url = [NSURL URLWithString:@"http://192.168.1.2x0/pic/LC.jpg"];
//    
//    NSURL   *imageURL   = [NSURL URLWithString:loadImageUrl];
//    
//    NSData  *imageData  = [NSData dataWithContentsOfURL:imageURL];
////    
////    self.json = [NSJSONSerialization JSONObjectWithData:imageData options:kNilOptions error:nil];
////    
////
////    NSURL *url = [NSURL URLWithString:[objectForKey:@"photo"]];
////    
//    
//    UIImage   *image=[UIImage imageWithData:imageData];
//
//    UIImageView *Load_image=[[UIImageView alloc]initWithImage:image];
//    Load_image.center=self.view.center;
//    [self.view addSubview:Load_image];
//    
//    
//    NSData *imagedata=[[NSData alloc]initWithContentsOfURL:url] ;
//    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImageView *subview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,320.0f,  460.0f)];
//    [subview setImage:[UIImage imageWithData:data]];
//    [self.view addSubview:subview];
//}
////
//-(void)uploadWithUserLocationString:(NSString*)userLocation{
//    NSString *urlString = @"http://some.url.com/post";
//    
//    // set up the form keys and values (revise using 1 NSDictionary at some point - neater than 2 arrays)
//    NSArray *keys = [[NSArray alloc] initWithObjects:@"auth",@"text",@"location",nil];
//    NSArray *vals = [[NSArray alloc] initWithObjects:self.authToken,self.textBox.text,userLocation,nil];
//    
//    //create request
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    
//    //Set Params
//    [request setHTTPShouldHandleCookies:NO];
//    [request setTimeoutInterval:60];
//    [request setHTTPMethod:@"POST"];
//    
//    //Create boundary, it can be anything
//    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
//    
//    // set Content-Type in HTTP header
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    // post body
//    NSMutableData *body = [NSMutableData data];
//    
//    //Populate a dictionary with all the regular values you would like to send.
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    
//    [parameters setValue:param1 forKey:@"param1-name"];
//    
//    [parameters setValue:param2 forKey:@"param2-name"];
//    
//    [parameters setValue:param3 forKey:@"param3-name"];
//    
//    
//    // add params (all params are strings)
//    for (NSString *param in parameters) {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    NSString *FileParamConstant = @"imageParamName";
//    
//    NSData *imageData = UIImageJPEGRepresentation(imageObject, 1);
//    
//    //Assuming data is not nil we add this to the multipart form
//    if (imageData)
//    {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:imageData];
//        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    //Close off the request with the boundary
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // setting the body of the post to the request
//    [request setHTTPBody:body];
//    
//    // set URL
//    [request setURL:[NSURL URLWithString:baseUrl]];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               
//                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//                               
//                               if ([httpResponse statusCode] == 200) {
//                                   
//                                   NSLog(@"success");
//                               }
//                               
//                           }];}
//
//
//
//












#pragma mark - Table view data source

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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
