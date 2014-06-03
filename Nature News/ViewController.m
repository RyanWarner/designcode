//
//  ViewController.m
//  Nature News
//
//  Created by Ryan Warner on 6/1/14.
//  Copyright (c) 2014 Ryan Warner. All rights reserved.
//

#import "ViewController.h"
#import "DNAPI.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginBUttonDidPress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property ( strong, nonatomic ) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIView *loadingView;



@end

@implementation ViewController
BOOL errorIsActive;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Set delegates
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    //Add listener for textfield did change
    [ self.emailTextField addTarget:self
                             action:@selector(textFieldDidChange:)
                   forControlEvents:UIControlEventEditingChanged ];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- ( void )textFieldDidChange:( UITextField * )textField
{
    if ( textField.text.length > 20 )
    {
        self.emailImageView.hidden = YES;
    }
    else
    {
        self.emailImageView.hidden = NO;
    }
}

- ( void ) textFieldDidBeginEditing:( UITextField *)textField
{
    // Text field was focused.
    
    if ( [textField isEqual:self.emailTextField] )
    {
        // Email
        NSLog( @"Email field was focused" );
        [ self.emailTextField setBackground:[ UIImage imageNamed:@"input-outline-active" ] ];
        self.emailImageView.image = [ UIImage imageNamed:@"icon-email-fill" ];
    }
    else
    {
        [ self.emailTextField setBackground:[ UIImage imageNamed:@"input-outline" ] ];
        self.emailImageView.image = [ UIImage imageNamed:@"icon-email" ];
    }
    
    // Password field
    if ( [textField isEqual:self.passwordTextField] )
    {
        NSLog( @"Password field was focused" );
        
        [ self.passwordTextField setBackground:[ UIImage imageNamed:@"input-outline-active" ] ];
        self.passwordImageView.image = [ UIImage imageNamed:@"icon-lock-fill" ];
    }
    else
    {
        [ self.passwordTextField setBackground:[ UIImage imageNamed:@"input-outline" ] ];
        self.passwordImageView.image = [ UIImage imageNamed:@"icon-lock" ];

    }
}

- (void)doErrorMessage
{
    NSLog( @"Login button pressed" );
    
    // Shake the login button.
    [UIView animateWithDuration:0.1 animations:^
    {
        self.loginButton.transform = CGAffineTransformMakeTranslation( 10, 0 );
    }
    completion:^(BOOL finished)
    {
        // Step 2
        [ UIView animateWithDuration:0.1 animations:^
        {
            self.loginButton.transform = CGAffineTransformMakeTranslation( -10, 0 );
        }
        completion:^(BOOL finished)
        {
            // Step 3
            [ UIView animateWithDuration:0.1 animations:^
            {
                self.loginButton.transform = CGAffineTransformMakeTranslation( 0, 0 );
            } ];
        } ];
    } ];
    
    // animateWithDuration with Damping
    [UIView animateWithDuration:0.7
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:0
    animations:^
    {
        if( errorIsActive == false )
        {
            [ self.modalView setFrame:CGRectMake(self.modalView.frame.origin.x, self.modalView.frame.origin.y - 30, self.modalView.frame.size.width, 310)];
            
            errorIsActive = true;
        }
    }
    completion:^( BOOL finished )
    {
    
    } ];
}

- ( IBAction )loginBUttonDidPress:(id)sender
{
    // Show loading
    self.loadingView.hidden = NO;
    
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSDictionary *param = @{@"grant_type":@"password",
                            @"username":email,
                            @"password":password,
                            @"client_id":@"750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d",
                            @"client_secret":@"53e3822c49287190768e009a8f8e55d09041c5bf26d0ef982693f215c72d87da"
                            };
    NSURLRequest *request = [NSURLRequest postRequest:DNAPILogin
                                           parameters:param];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            NSError *serializeError;
                                            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializeError];
                                            double delayInSeconds = 1.0f;   // Just for debug
                                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                
                                                // Hide loading
                                                self.loadingView.hidden = YES;
                                                
                                                // Get response
                                                self.data = json;
                                                NSString *token = [self.data valueForKeyPath:@"access_token"];
                                                NSLog(@"%@", self.data);
                                                
                                                // If logged
                                                if(token)
                                                {
                                                    // Do something after logged
                                                    NSLog(@"I am logged!");
                                                    
                                                    // Perform segue
                                                    [self performSegueWithIdentifier:@"loginToHomeScene" sender:self];
                                                }
                                                else {
                                                    [self doErrorMessage];
                                                }
                                                
                                            });
                                        }];
    [task resume];

}
@end
