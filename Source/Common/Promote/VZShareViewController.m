//
//  VZShareViewController.m
//  Mahjong
//
//  Created by 穆暮 on 14-7-4.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "VZShareViewController.h"
#import "cocos2d.h"
@interface VZShareViewController ()

@end

@implementation VZShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(NSUInteger)supportedInterfaceOrientations
{
    
    CCAppDelegate* delegate = (CCAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString* screenOrientation = delegate.navController.screenOrientation;
    
    if ([screenOrientation isEqual:CCScreenOrientationAll])
    {
        return UIInterfaceOrientationMaskAll;
    }
    else if ([screenOrientation isEqual:CCScreenOrientationPortrait])
    {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    else
    {
        return UIInterfaceOrientationMaskLandscape;
    }
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CCAppDelegate* delegate = (CCAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString* screenOrientation = delegate.navController.screenOrientation;
    
    if ([screenOrientation isEqual:CCScreenOrientationAll])
    {
        return YES;
    }
    else if ([screenOrientation isEqual:CCScreenOrientationPortrait])
    {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    }
    else
    {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
