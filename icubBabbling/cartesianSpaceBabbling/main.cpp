
#include <iostream>
#include <time.h>
#include <string>
#include <yarp/os/all.h>
#include <yarp/sig/all.h>
#include <yarp/dev/all.h>
#include <yarp/dev/Drivers.h>
#include <vector>
YARP_DECLARE_DEVICES(icubmod)

using namespace yarp;
using namespace yarp::os;
using namespace yarp::sig;
using namespace yarp::dev;
using namespace std;

#define USE_LEFT_ARM 1
#define USE_RIGHT_ARM 0
#define USE_GAZE 1
#define MANUAL_TARGET 0

int main(int argc, char *argv[])
{
    yarp::os::Network yarp;
	YARP_REGISTER_DEVICES(icubmod)

    if (!yarp.checkNetwork())
        return false;
		
	Port targetPortIn; targetPortIn.open("/motorBabbling/target:i");
	BufferedPort<Bottle> targetPort; targetPort.open("/motorBabbling/target:o");

	//Open motor interfaces
	Property optionsCartL;
    optionsCartL.put("robot", "icubSim");
    optionsCartL.put("device", "cartesiancontrollerclient");
    optionsCartL.put("remote", "/icubSim/cartesianController/left_arm");
    optionsCartL.put("local", "/motorBabbling/cartesianController/left_arm");
	
	Property optionsCartR;
    optionsCartR.put("robot", "icubSim");
    optionsCartR.put("device", "cartesiancontrollerclient");
    optionsCartR.put("remote", "/icubSim/cartesianController/right_arm");
    optionsCartR.put("local", "/motorBabbling/cartesianController/right_arm");

	PolyDriver driverCartL(optionsCartL);
	PolyDriver driverCartR(optionsCartR);

	if (!driverCartL.isValid() || !driverCartR.isValid()) {
		 cout<<"Cartesian ctrl not available."<<endl;
		 Network::fini();
		 return -1;
	}
	 
	Property optionGaze;
	optionGaze.put("device","gazecontrollerclient");
	optionGaze.put("remote","/iKinGazeCtrl");
	optionGaze.put("local","/motorBabbling/gaze");
	PolyDriver driverGaze(optionGaze);

	//Get views
	ICartesianControl *lCart;
	ICartesianControl *rCart;
	IGazeControl *gaze;

	driverCartL.view(lCart);
	driverCartR.view(rCart);
	driverGaze.view(gaze);

	if (lCart == NULL || rCart == NULL || gaze == NULL )
	{
		cout<<"Problem while acquiring the views"<<endl;
		Network::fini();
		return -1;
	}

	gaze->setSaccadesStatus(false);

	//Define boundaries
	float minX = -0.2;
	float maxX = -0.35;
				
	float minY = -0.1;
	float maxY = 0.1;
				
	float minZ = 0.3;
	float maxZ = 0.45;

	//Define hand orientation
	Vector orientation(4);
	orientation[0] = 0.57735;  //-0.397179;
	orientation[1] = 0.57735;//-0.057748;
	orientation[2] = -0.57735;//-0.915922;
	orientation[3] = 2.094395;//2.976308;

	srand(time(NULL));
	while (1)
	{		
		Vector pos(3);
		if (MANUAL_TARGET == 1)
		{
			cout<<"Waiting for command on port..."<<endl;
			Bottle tBot;
			targetPortIn.read(tBot);
			pos[0] = tBot.get(0).asDouble();
			pos[1] = tBot.get(1).asDouble();
			pos[2] = tBot.get(2).asDouble();
		}
		//Get a new random cartesian position
		else
		{
			pos[0] = minX + ( rand() % 101 ) * (maxX-minX) / 100.0;
			pos[1] = minY + ( rand() % 101 ) * (maxY-minY) / 100.0;
			pos[2] = minZ + ( rand() % 101 ) * (maxZ-minZ) / 100.0;
		}
		cout<<"Next position:"<<pos.toString(3,3)<<endl;

		//Send this position to the 3 interfaces
		if (USE_LEFT_ARM == 1)
			lCart->goToPoseSync(pos,orientation);
		if (USE_RIGHT_ARM == 1)
			rCart->goToPoseSync(pos,orientation);
		if (USE_GAZE == 1)
			gaze->lookAtFixationPoint(pos);

		bool doneCartL = false;
		bool doneCartR = false;
		bool doneGaze = false;
		while(!doneCartL || !doneCartR || !doneGaze)
		{
			lCart->checkMotionDone(&doneCartL);
			rCart->checkMotionDone(&doneCartR);
			gaze->checkMotionDone(&doneGaze);
			Time::delay(0.02);
		}

		Bottle& b = targetPort.prepare();
		b.clear();
		b.addDouble(pos[0]);
		b.addDouble(pos[1]);
		b.addDouble(pos[2]);
		targetPort.write();
	}

    return 0;
}


