//
//  AddNewStudentViewController.m
//  iosintershiptask1
//
//  Created by eugenerdx on 31.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "AddNewStudentViewController.h"
typedef enum {
    fieldsName,
    fieldsLastName,
    fieldsEmail,
    fieldsPhone
} Fields;

@interface AddNewStudentViewController ()

@end

@implementation AddNewStudentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"200"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"saveSegue"])
    {
     
        
        NSString* firstName   = [self.firstNameTextField text];
        NSString* lastName    = [self.lastNameTextField text];
        NSString* email       = [self.emailTextField text];
        NSString* phoneNumber = [self.phoneTextField text];
        NSData* studentImage = [self.imageView image];
        
     
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

        NSURL *url = [NSURL URLWithString:@"https://linneage.ru/studentlist/create_student.php"];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *params = [NSString stringWithFormat:@"first_name=%@&last_name=%@&phone_number=%@&email=%@&photo=%@", firstName, lastName, phoneNumber, email, studentImage];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        

        
        
        NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        }];
        
        [dataTask resume];
        
        self.addStudent = [Student initWithName:firstName lastName:lastName email:email phone:phoneNumber image:nil studentID:@""];
        NSLog(@"%@ %@ %@ %@", firstName, lastName, email, phoneNumber);
        

    }
    
}

//-(void)uploadWithUserLocationString:(NSString*)userLocation{
//    NSString *urlString = @"http://some.url.com/post";
//    
//    // set up the form keys and values (revise using 1 NSDictionary at some point - neater than 2 arrays)
//    NSArray *keys = [[NSArray alloc] initWithObjects:@"auth",@"text",@"location",nil];
//    NSArray *vals = [[NSArray alloc] initWithObjects:self.authToken,self.textBox.text,userLocation,nil];
//    
//    // create request
//    //Add content-type to Header. Need to use a string boundary for data uploading.
//    NSString *boundary = @"0xKhTmLbOuNdArY";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    [request setHTTPShouldHandleCookies:NO];
//    [request setTimeoutInterval:30];
//    [request setHTTPMethod:@"POST"];
//    
//    // set Content-Type in HTTP header
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    // post body
//    NSMutableData *body = [NSMutableData data];
//    
//    // add params (all params are strings)
//    for (NSString *param in _params) {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    // add image data
//    NSData *imageData = UIImageJPEGRepresentation(imageToPost, 1.0);
//    if (imageData) {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithString:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:imageData];
//        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // setting the body of the post to the reqeust
//    [request setHTTPBody:body];
//    
//    // set URL
//    [request setURL:requestURL];}

- (IBAction) pickImage:(id)sender{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.firstNameTextField isFirstResponder])
    {
        [self.lastNameTextField becomeFirstResponder];
    }
    else if ([self.lastNameTextField isFirstResponder])
    {
        [self.emailTextField becomeFirstResponder];
    }
    else if ([self.emailTextField isFirstResponder])
    {
        [self.phoneTextField becomeFirstResponder];
    }
    else if ([self.phoneTextField isFirstResponder])
    {
        [self.phoneTextField resignFirstResponder];
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    switch (textField.tag) {
        case fieldsName:
            break;
        case fieldsLastName:
            break;
        case fieldsPhone:
            [self scriptPhoneField:textField shouldChangeCharactersInRange:range replacementString:string];
            return NO;
            break;
        case fieldsEmail:
            [self scriptEmailField:textField shouldChangeCharactersInRange:range replacementString:string];
            return NO;
            break;
    }
    
    return YES;
    
    
}

#pragma mark - MethodsWithScriptsForFields

- (BOOL)scriptEmailField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *validation = [NSCharacterSet characterSetWithCharactersInString:@"!~!#$%^,/|&*()<>=+{}][:;'\" \\"];
    NSArray * components = [string componentsSeparatedByCharactersInSet:validation];
    
    if ([components count] > 1) {
        return NO;
    }
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (([resultString rangeOfString:@"@"].length) < 1) {
        self.atPresent = NO;
    }
    if ([resultString length] < 2 && [string isEqualToString:@"@"]) {
        
        return NO;
    }
    
    if (self.atPresent && [string isEqualToString:@"@"]) {
        return NO;
    }
    
    if ([string isEqualToString:@"@"]) {
        self.atPresent = YES;
    }
    
    
    textField.text = resultString;
    return NO;
    
}

- (BOOL) scriptPhoneField: (UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
    if ([components count] > 1) {
        return NO;
    }
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"new string = %@", newString);
    NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    NSLog(@"new string fixed = %@", newString);
    
    NSMutableString* resultString = [NSMutableString string];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if ([newString length]> localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        NSString* number= [newString substringFromIndex:(int)[newString length]-localNumberLength];
        
        [resultString appendString:number];
        
        if ([resultString length]>3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    if ([newString length] > localNumberMaxLength ) {
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        
        NSRange areaRange = NSMakeRange((int)[newString length]-localNumberMaxLength - areaCodeLength, areaCodeLength);
        NSString* area= [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@)", area];
        
        [resultString insertString:area atIndex:0];
    }
    if ([newString length] > localNumberMaxLength +areaCodeMaxLength ) {
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        NSString* countryCode = [newString substringWithRange:countryCodeRange];
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    textField.text = resultString;
    
    return  NO;
    
}
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

- (IBAction)newImage:(id)sender {
}
@end
