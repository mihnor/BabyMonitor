#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "ofkUDPjpegReceiver.h"
#include "ofkOSCcommunicator.h"

class MonitorApp : public ofxiPhoneApp {
	
public:
    
     MonitorApp ();
    ~MonitorApp ();
    
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);

    ofkUDPjpegReceiver mUDPjpegReceiver;
    //
    void onReceiveImgae(ofkPixelsWithIP & pix);
    
    ofImage mRecievedImage;
    string mRecievedIP;
    unsigned long mLastRecievedTime;
    
    ofkOSCcommunicator mOSCcommunicator;
    
    static void myOscCallBack(ofxOscMessage recieveMessage, void *pUserdata);
 
    
};


