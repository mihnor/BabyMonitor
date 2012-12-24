#include "MonitorApp.h"

//--------------------------------------------------------------
MonitorApp :: MonitorApp () {
    cout << "creating MonitorApp" << endl;
}

//--------------------------------------------------------------
MonitorApp :: ~MonitorApp () {
    cout << "destroying MonitorApp" << endl;
}

//--------------------------------------------------------------
void MonitorApp::setup() {	
	ofBackground(127);
    
    int fontSize = 8;
    if (ofxiPhoneGetOFWindow()->isRetinaSupported())
        fontSize *= 2;
    
    font.loadFont("fonts/mono0755.ttf", fontSize);
    
    image.loadImage("images/dive.jpg");
}

//--------------------------------------------------------------
void MonitorApp::update(){

}

//--------------------------------------------------------------
void MonitorApp::draw() {
    int x = (ofGetWidth()  - image.width)  * 0.5;
    int y = (ofGetHeight() - image.height) * 0.5;
    int p = 0;
    
	ofSetColor(ofColor::white);
    image.draw(x, y);
    
    x = ofGetWidth()  * 0.2;
    y = ofGetHeight() * 0.11;
    p = ofGetHeight() * 0.035;
    
    ofSetColor(ofColor::white);
    font.drawString("frame num      = " + ofToString( ofGetFrameNum() ),    x, y+=p);
    font.drawString("frame rate     = " + ofToString( ofGetFrameRate() ),   x, y+=p);
    font.drawString("screen width   = " + ofToString( ofGetWidth() ),       x, y+=p);
    font.drawString("screen height  = " + ofToString( ofGetHeight() ),      x, y+=p);
}

//--------------------------------------------------------------
void MonitorApp::exit() {
    //
}

//--------------------------------------------------------------
void MonitorApp::touchDown(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void MonitorApp::touchMoved(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void MonitorApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void MonitorApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void MonitorApp::lostFocus(){

}

//--------------------------------------------------------------
void MonitorApp::gotFocus(){

}

//--------------------------------------------------------------
void MonitorApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void MonitorApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void MonitorApp::touchCancelled(ofTouchEventArgs& args){

}

