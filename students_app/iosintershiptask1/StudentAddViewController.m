//
//  AddNewStudentViewController.m
//  iosintershiptask1
//
//  Created by eugenerdx on 31.03.16.
//  Copyright © 2016 eugenerdx. All rights reserved.
//

#import "StudentAddViewController.h"


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
     
//        NSString* firstName   = [self.firstNameTextField text];
//        NSString* lastName    = [self.lastNameTextField text];
//        NSString* email       = [self.emailTextField text];
//        NSString* phone = [self.phoneTextField text];
//       
        
    
        [[StudentsService sharedService] studentAdd:[Student studentWithId:nil firstName:[self.firstNameTextField text] lastName:[self.lastNameTextField text] email:[self.emailTextField text] phone:[self.phoneTextField text] createdDate:nil updatedDate:nil image:nil]];

       // NSLog(@"%@ %@ %@ %@", firstName, lastName, email, phone);
       
    }
    
}



- (void)addNewStudentPersonalInfo
{
    
}

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

- (IBAction)newImage:(id)sender {
}
@end
