//
//  FISViewController.m
//  validatedSignUp
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController () <UITextFieldDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) NSString *alertMessage;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.userName.delegate = self;
    self.password.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    
    if (textField == self.firstName) {
        
        if ([textField.text isEqualToString:@""] || [textField.text rangeOfCharacterFromSet:numbers].location != NSNotFound) {
            
            self.alertMessage = @"Empty first name field or added numeric values";
            
            [self invalidEntry];
            
            
        } else {
            
            [self.lastName becomeFirstResponder];
        }
        
    }
    
    if (textField == self.lastName) {
        
        if ([textField.text isEqualToString:@""]|| [textField.text rangeOfCharacterFromSet:numbers].location != NSNotFound) {
            
            self.alertMessage = @"Empty last name field";
            
            [self invalidEntry];
            
        } else {
            
             [self.email becomeFirstResponder];
            
        }
    }
    
   if (textField == self.email) {
       
       if (![self isValidEmail:textField.text]) {
           
           self.alertMessage = @"Invalid email or empty field";
           
           [self invalidEntry];
           
           } else {
               
                [self.userName becomeFirstResponder];
       }
       
    }
    
   if (textField == self.userName) {
       
       if ([textField.text isEqualToString:@""]) {
           
           self.alertMessage = @"Empty username field";
           
           [self invalidEntry];
           
       } else {
           
           [self.password becomeFirstResponder];

       }
    }
    
    if (textField == self.password) {
        if ([textField.text isEqualToString:@""]|| textField.text.length > 6) {
            
            self.alertMessage = @"Empty password or too many characters";
            
            [self invalidEntry];
            
        } else {
            
            [self.password resignFirstResponder];
        }
    }
    
    
    


        return YES;
}

-(void)invalidEntry
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:self.alertMessage delegate:self cancelButtonTitle:@"Re-type" otherButtonTitles:nil, nil];
    
    [alert show];
}

-(BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
