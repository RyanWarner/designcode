//
//  ViewController.m
//  Nature News
//
//  Created by Ryan Warner on 6/1/14.
//  Copyright (c) 2014 Ryan Warner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginBUttonDidPress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;



@end

@implementation ViewController
BOOL errorIsActive;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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

- (IBAction)loginBUttonDidPress:(id)sender
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
@end
