#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofkUDPjpegSender.h"
#include "ofxUI.h"
#include "ofkXMLProperties.h"

class CameraApp : public ofxiPhoneApp {
	
public:
    
     CameraApp ();
    ~CameraApp ();
    
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
    void guiEvent(ofxUIEventArgs &e);
    
    ofTrueTypeFont font;
    
    ofVideoGrabber grabber;
    ofkUDPjpegSender mUDPjpegStream;
    ofImage videoImage;

    ofxUICanvas *guiCanvas;
    ofxUILabel *label;
    ofxUILabel *guiNetwork_IPAdress;
    void initGUILayout();
    
    ofxiPhoneKeyboard * IPkeyboard;
    
    
    //
    float mLightbrightNess;
    
    
};


