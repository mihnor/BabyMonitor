#include "CameraApp.h"
#include "CameraSettingViewController.h"

#define BUFSIZE (9216 * 4)
#define DISP_RATIO ((ofGetWidth() / 768.0))

#define OSC_PORT (4053)
#define UDP_PORT (4053)

#define CAM_WIDTH (640 * 0.2)
#define CAM_HEIGHT (480 * 0.2)


//CameraSettingViewController * cameraSettingViewController;

//--------------------------------------------------------------
CameraApp :: CameraApp () {
    cout << "creating CameraApp" << endl;
}

//--------------------------------------------------------------
CameraApp :: ~CameraApp () {
    grabber.close();
    //sleep(1);
    cout << "destroying CameraApp" << endl;
}

//--------------------------------------------------------------
void CameraApp::setup() {
	ofBackground(127);
    
    int fontSize = 8;
    if (ofxiPhoneGetOFWindow()->isRetinaSupported())
        fontSize *= 2;
    
    font.loadFont("fonts/mono0755.ttf", fontSize);
    
    //set up camera
    
    grabber.setDeviceID(1);
    grabber.initGrabber(CAM_WIDTH, CAM_HEIGHT, OF_PIXELS_BGRA);

    string ip = ofkXMLProperties::getPropertyValue("SETTINGS:SendIP", "10.0.1.5");
    
    mUDPjpegStream.init(ip , 4054, BUFSIZE);
    //mUDPjpegStream.setEnableBroadCast(true);
  
    IPkeyboard = new ofxiPhoneKeyboard(0 ,400, ofGetWidth(),50);
	IPkeyboard->setBgColor(0, 255, 255, 100);
	IPkeyboard->setFontColor(255,255,255, 255);
	IPkeyboard->setFontSize(45);
    IPkeyboard->setVisible(true);
    IPkeyboard->setPosition(0, 500);
    
    initGUILayout();
    
    mLightbrightNess = 0;
}

//--------------------------------------------------------------
void CameraApp::update(){
    grabber.update();
    
    if(grabber.isFrameNew())
    {
        unsigned char * src = grabber.getPixels();
        videoImage.setFromPixels(src, grabber.getWidth(), grabber.getHeight(), OF_IMAGE_COLOR);
        mUDPjpegStream.sendImage(videoImage.getPixelsRef());
    }
    
    // ----- keyboard -------------- ///
    if("" != IPkeyboard->getText())
    {
        if(guiNetwork_IPAdress->getLabel() != IPkeyboard->getText())
        {
            mUDPjpegStream.init(IPkeyboard->getText(), 4054, BUFSIZE);
            guiNetwork_IPAdress->setLabel("SEND IP :" + IPkeyboard->getText());
            ofkXMLProperties::setPropertyValue("SETTINGS:SendIP", IPkeyboard->getText());
            
            
            // ----- saving value into XML file ----------- //
            //XML.setValue("SETTINGS:TargetIPAddress", IPkeyboard->getText());
            //XML.saveFile( ofxiPhoneGetDocumentsDirectory() + "mySettings.xml" );
        }
    }    
}

//--------------------------------------------------------------
void CameraApp::draw() {
    ofSetHexColor(0xFFFFFF);
    grabber.draw(0,0, ofGetWidth(), ofGetHeight());
    
    ofSetColor(255, 255, 255, 255.0 * (mLightbrightNess)/ 100.0f);
    ofRect(0, 0, ofGetWidth(), ofGetHeight());
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

void CameraApp::initGUILayout()
{
    int xInit = OFX_UI_GLOBAL_WIDGET_SPACING;
    int FONT_LARGE = (int) 35 * DISP_RATIO;
    int FONT_MID= (int) 20 * DISP_RATIO;
    int FONT_SMALL= (int) 18 * DISP_RATIO;
    int dim =  70;
    float length = ofGetWidth() - xInit;
    
    //-guiHeader-----------------------------------------------------------//
    
    float guiHeaderHEIGHT = 1.0;
    
    guiCanvas = new ofxUICanvas(0,0 ,ofGetWidth(),ofGetHeight() * guiHeaderHEIGHT);
    guiCanvas->setFont("Roboto-Light.ttf");
    guiCanvas->setFontSize(OFX_UI_FONT_LARGE , FONT_LARGE);
    guiCanvas->setFontSize(OFX_UI_FONT_MEDIUM , FONT_MID);
    
    guiCanvas->setFontSize(OFX_UI_FONT_SMALL , FONT_SMALL);
    
    {
        guiCanvas->addWidgetDown(new ofxUILabel("Baby Monitor Sender", OFX_UI_FONT_LARGE));
        guiCanvas->addWidgetDown(new ofxUIFPSSlider("FPS", ofGetWidth() - 2 * xInit, 50,15));
        guiCanvas->addWidgetDown(new ofxUISpacer(length-xInit, 1));
        guiNetwork_IPAdress = new ofxUILabel("SET UP IP destination", OFX_UI_FONT_MEDIUM);
        guiCanvas->addWidgetDown(guiNetwork_IPAdress);
        
        
        vector<string> names;
        names.push_back("BEST");
        names.push_back("HIGH");
        names.push_back("MEDIUM");
        names.push_back("LOW");
        names.push_back("WORST");
        
        guiCanvas->addWidgetDown(new ofxUIRadio( dim *2, dim, "ImageStream Quality", names, OFX_UI_ORIENTATION_VERTICAL));
        
        //label = new ofxUILabel("Data size", 70);
        //guiCanvas->addWidgetDown(label);
        
        guiCanvas->addToggle("Switch Camera", true, dim *2, dim);
        
        //mLightbrightNess
        guiCanvas->addSlider("Brightness", 0.0, 100.0, &mLightbrightNess, ofGetWidth() - 2 * xInit, 50);
        
        
    }
    
    ofAddListener(guiCanvas->newGUIEvent, this, &CameraApp::guiEvent);
    
}

void CameraApp::guiEvent(ofxUIEventArgs &e)
{
    bool SyncEvent = false;
    
    
    if(e.widget->getName() == "BEST")
    {
		ofxUIButton *button = (ofxUIButton *) e.widget;
        if(button->getValue())
        {
            mUDPjpegStream.setjpegQuality(OF_IMAGE_QUALITY_BEST);
        }
    }
    else if(e.widget->getName() == "HIGH")
    {
		ofxUIButton *button = (ofxUIButton *) e.widget;
        if(button->getValue())
        {
            mUDPjpegStream.setjpegQuality(OF_IMAGE_QUALITY_HIGH);
        }
    }
    else if(e.widget->getName() == "MEDIUM")
    {
		ofxUIButton *button = (ofxUIButton *) e.widget;
        if(button->getValue())
        {
            mUDPjpegStream.setjpegQuality(OF_IMAGE_QUALITY_MEDIUM);
        }
    }
    else if(e.widget->getName() == "LOW")
    {
		ofxUIButton *button = (ofxUIButton *) e.widget;
        if(button->getValue())
        {
            mUDPjpegStream.setjpegQuality(OF_IMAGE_QUALITY_LOW);
        }
    }
    else if(e.widget->getName() == "WORST")
    {
		ofxUIButton *button = (ofxUIButton *) e.widget;
        if(button->getValue())
        {
            mUDPjpegStream.setjpegQuality(OF_IMAGE_QUALITY_WORST);
        }
    }
    else if(e.widget->getName() == "Switch Camera")
    {
		ofxUIToggle *button = (ofxUIToggle *) e.widget;
        if(button->getValue())
        {
            grabber.setDeviceID(0);
            grabber.initGrabber(CAM_WIDTH, CAM_HEIGHT, OF_PIXELS_BGRA);
        }else
        {
            grabber.setDeviceID(1);
            grabber.initGrabber(CAM_WIDTH, CAM_HEIGHT, OF_PIXELS_BGRA);
        }
    }
    //Switch Camera
    //    grabber.setDeviceID(1);
    
}
