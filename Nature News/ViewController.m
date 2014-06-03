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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
     [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)loginBUttonDidPress:(id)sender
{
    // Shake the login button.
    [UIView animateWithDuration:0.1 animations:^
    {
        self.loginButton.transform = CGAffineTransformMakeTranslation( 10, 0 );
    }
    completion:^(BOOL finished)
    {
        // Step 2
        [UIView animateWithDuration:0.1 animations:^
        {
            self.loginButton.transform = CGAffineTransformMakeTranslation( -10, 0 );
        }
        completion:^(BOOL finished)
        {
            // Step 3
            [UIView animateWithDuration:0.1 animations:^
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
        [ self.modalView setFrame:CGRectMake(self.modalView.frame.origin.x, self.modalView.frame.origin.y, self.modalView.frame.size.width, 320)];
    }
    completion:^( BOOL finished )
    {
    
    } ];
}
@end
