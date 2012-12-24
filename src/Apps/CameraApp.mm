#include "CameraApp.h"

//--------------------------------------------------------------
CameraApp :: CameraApp () {
    cout << "creating CameraApp" << endl;
}

//--------------------------------------------------------------
CameraApp :: ~CameraApp () {
    cout << "destroying CameraApp" << endl;
}

//--------------------------------------------------------------
void CameraApp::setup() {
	ofBackground(127);
    
    int fontSize = 8;
    if (ofxiPhoneGetOFWindow()->isRetinaSupported())
        fontSize *= 2;
    
    font.loadFont("fonts/mono0755.ttf", fontSize);
}

//--------------------------------------------------------------
void CameraApp::update(){

}

//--------------------------------------------------------------
void CameraApp::draw() {
    int x = ofGetWidth()  * 0.5;
    int y = ofGetHeight() * 0.5;
    int r = MIN(ofGetWidth(), ofGetHeight()) * 0.3;
    int p = 0;
    
	ofSetColor(ofColor::red);
    ofCircle(x, y, r);
    
    x = ofGetWidth()  * 0.2;
    y = ofGetHeight() * 0.11;
    p = ofGetHeight() * 0.035;
    
    ofSetColor(ofColor::white);
    font.drawString("frame num      = " + ofToString(ofGetFrameNum() ),    x, y+=p);
    font.drawString("frame rate     = " + ofToString(ofGetFrameRate() ),   x, y+=p);
    font.drawString("screen width   = " + ofToString(ofGetWidth() ),       x, y+=p);
    font.drawString("screen height  = " + ofToString(ofGetHeight() ),      x, y+=p);
}

//--------------------------------------------------------------
void CameraApp::exit() {
    //
}

//--------------------------------------------------------------
void CameraApp::touchDown(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void CameraApp::touchMoved(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void CameraApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void CameraApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void CameraApp::lostFocus(){

}

//--------------------------------------------------------------
void CameraApp::gotFocus(){

}

//--------------------------------------------------------------
void CameraApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void CameraApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void CameraApp::touchCancelled(ofTouchEventArgs& args){

}

