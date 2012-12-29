#include "MonitorApp.h"

#define BUFSIZE (9216 * 4)

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
    cout << "MonitorApp::setup" << endl;

    mUDPjpegReceiver.init(4054, BUFSIZE);
    mUDPjpegReceiver.enable();
    ofAddListener(mUDPjpegReceiver.newReceivedPixelEvent,this,&MonitorApp::onReceiveImgae);
    mRecievedIP = "unRecieved";
    
    
    mOSCcommunicator.init(myOscCallBack, this);

}

//--------------------------------------------------------------
void MonitorApp::update(){

}

//--------------------------------------------------------------
void MonitorApp::draw() {
    
    ofBackground(0);
    
    mRecievedImage.draw(0, 0 , ofGetWidth(), ofGetWidth() * mRecievedImage.getHeight() / mRecievedImage.getWidth());
    
    ofSetColor(255, 255, 255);
    
    ofDrawBitmapString("My IP :" + mOSCcommunicator.getOnwIPAddress(), 0, 150);
    ofDrawBitmapString("Recieved from" + mRecievedIP, 0, 200);
    ofDrawBitmapString("Recieved at" + ofToString(mLastRecievedTime), 0, 250);
    
}

//--------------------------------------------------------------
void MonitorApp::exit() {
    //
    
    cout << "MonitorApp::exit" << endl;
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

void MonitorApp::onReceiveImgae(ofkPixelsWithIP & pix)
{
    mRecievedImage.setFromPixels(pix);
    mLastRecievedTime = ofGetElapsedTimeMillis();
    mRecievedIP = pix.IP;
}

void MonitorApp::myOscCallBack(ofxOscMessage recieveMessage, void *pUserdata)
{
    MonitorApp *pThis = (MonitorApp *)pUserdata;
    
    if( recieveMessage.getAddress() == "/touch/position" )
    {
    }
}

