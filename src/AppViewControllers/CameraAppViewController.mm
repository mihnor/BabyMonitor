//
//  CustomAppViewController.m
//  Created by lukasz karluk on 8/02/12.
//

#import "CameraAppViewController.h"
#import "ofxiPhoneExtras.h"
#include "CameraSettingViewController.h"

CameraSettingViewController * cameraSettingViewController;

@implementation CameraAppViewController

- (id) initWithFrame:(CGRect)frame app:(ofBaseApp*)app {

    ofxiPhoneGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.
    
//    self.navigationController.navigationController;
    
    //Our Gui setup
	cameraSettingViewController	= [[CameraSettingViewController alloc] initWithNibName:@"CameraSettingViewController" bundle:nil];
	[self.view addSubview:cameraSettingViewController.view];
    
    
    return self = [super initWithFrame:frame app:app];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

@end
