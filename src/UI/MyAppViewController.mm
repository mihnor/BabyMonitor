//
//  MenuViewController.m
//  Created by lukasz karluk on 12/12/11.
//

#import "MyAppViewController.h"

#import "SquareAppViewController.h"
#import "SquareApp.h"

#import "CircleAppViewController.h"
#import "CircleApp.h"

#import "TriangleAppViewController.h"
#import "TriangleApp.h"

#import "ImageAppViewController.h"
#import "ImageApp.h"

@implementation MyAppViewController

- (UIButton*) makeButtonWithFrame:(CGRect)frame 
                          andText:(NSString*)text {
    UIFont *font;
    font = [UIFont fontWithName:@"Georgia" size:30];
    
    UILabel *label;
    label = [[[ UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
    label.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    label.textColor = [UIColor colorWithWhite:0 alpha:1];
    label.text = [text uppercaseString];
    label.textAlignment = UITextAlignmentCenter;
    label.font = font;
    label.userInteractionEnabled = NO;
    label.exclusiveTouch = NO;
    
    UIButton* button = [[[UIButton alloc] initWithFrame:frame] autorelease];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addSubview:label];
    
    return button;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //UIImageView* backgroundView;
    //backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]] autorelease];
    //[self.view addSubview: backgroundView];
    
    /*
    CGRect btnFrame = CGRectMake(0.f,0.f,100.0f,100.0f);
    UIButton* button = [[UIButton alloc] initWithFrame:btnFrame];
    
    [self.view addSubview:button];
*/
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    
    {
        UIImage *img = [UIImage imageNamed:@"IconCamera.png"];
        CGRect btnRect = CGRectMake(screenRect.size.width / 2 - screenRect.size.height / 3.0 / 2.0,
                                    50,
                                    screenRect.size.height / 3.0,
                                    screenRect.size.height / 3.0);
        
        UIButton *btn = [[[UIButton alloc]
                          initWithFrame:btnRect] autorelease];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        //UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //btn.frame = CGRectMake(0, 100, screenRect.size.height / 3.0, screenRect.size.height / 3.0);
        //[btn setTitle:@"Camera" forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:48]];
        [btn addTarget:self action:@selector(launchCameraApp:)forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    //Making own BUttom
    {
        UIImage *img = [UIImage imageNamed:@"IconMonitor.png"];
        CGRect btnRect = CGRectMake(screenRect.size.width / 2 - screenRect.size.height / 3.0 / 2.0,
                                screenRect.size.height / 2.0 + 50,
                                screenRect.size.height / 3.0,
                                screenRect.size.height / 3.0);
    
        UIButton *btn = [[[UIButton alloc]
                          initWithFrame:btnRect] autorelease];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:48]];
        [btn addTarget:self action:@selector(launchMonitorApp:)forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    CGRect scrollViewFrame = CGRectMake(0.f,
                                        0.f,
                                        screenRect.size.width,
                                        screenRect.size.height);
    
    UIScrollView* containerView = [[[UIScrollView alloc] initWithFrame:scrollViewFrame] autorelease];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    containerView.showsHorizontalScrollIndicator = NO;
    containerView.showsVerticalScrollIndicator = YES;
    containerView.alwaysBounceVertical = YES;
    //[self.view addSubview:containerView];

    NSArray *buttonTitles;
    buttonTitles = [NSArray arrayWithObjects: @"square", @"circle", @"triangle", @"image", nil];
    
    NSInteger buttonY = 44;     // make room for navigation bar.
    NSInteger buttonGap = 2;
    NSInteger buttonHeight = (screenRect.size.height - 44) / [buttonTitles count] - buttonGap * ([buttonTitles count] - 1);
    CGRect buttonRect = CGRectMake(0, 0, screenRect.size.width, buttonHeight);
    
    for (int i = 0; i < [buttonTitles count]; i++) {
        UIButton *button;
        button = [self makeButtonWithFrame:CGRectMake(0, buttonY, buttonRect.size.width, buttonRect.size.height)
                                   andText:[buttonTitles objectAtIndex:i]];
        [containerView addSubview:button ];
        
        if (i== 0)
            [button addTarget:self action:@selector(button1Pressed:) forControlEvents:UIControlEventTouchUpInside];
        else if (i==1)
            [button addTarget:self action:@selector(button2Pressed:) forControlEvents:UIControlEventTouchUpInside];
        else if (i==2)
            [button addTarget:self action:@selector(button3Pressed:) forControlEvents:UIControlEventTouchUpInside];
        else if (i==3)
            [button addTarget:self action:@selector(button4Pressed:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonY += buttonRect.size.height;
        buttonY += buttonGap;
    }
    
    containerView.contentSize = CGSizeMake(buttonRect.size.width, buttonRect.size.height * 3);
}

- (void)button1Pressed:(id)sender {
    SquareAppViewController *viewController;
    viewController = [[[SquareAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                 app:new SquareApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"SquareApp";
}

- (void)button2Pressed:(id)sender {
    CircleAppViewController *viewController;
    viewController = [[[CircleAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                 app:new CircleApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"CircleApp";
}

- (void)button3Pressed:(id)sender {
    TriangleAppViewController *viewController;
    viewController = [[[TriangleAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                   app:new TriangleApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"TriangleApp";
}

- (void)button4Pressed:(id)sender {
    ImageAppViewController *viewController;
    viewController = [[[ImageAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                app:new ImageApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"ImageApp";
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    BOOL bRotate = NO;
    bRotate = bRotate || (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    bRotate = bRotate || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    return bRotate;
}

-(void)launchMonitorApp:(UIButton*)button{
    
    ImageAppViewController *viewController;
    viewController = [[[ImageAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                app:new ImageApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"Monitor";    
}


-(void)launchCameraApp:(UIButton*)button{
    
    TriangleAppViewController *viewController;
    viewController = [[[TriangleAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                   app:new TriangleApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"Camera";

}



@end
