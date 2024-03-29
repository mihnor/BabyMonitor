//
//  CustomAppViewController.m
//  Created by lukasz karluk on 8/02/12.
//

#import "MonitorAppViewController.h"
#import "ofxiPhoneExtras.h"

@implementation MonitorAppViewController

- (id) initWithFrame:(CGRect)frame app:(ofBaseApp*)app {
    
    ofxiPhoneGetOFWindow()->setOrientation( OF_ORIENTATION_DEFAULT );   //-- default portait orientation.    
    
    return self = [super initWithFrame:frame app:app];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

@end
