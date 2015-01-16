// -*- mode:C++; tab-width:4; c-basic-offset:4; indent-tabs-mode:nil -*-

#include <stdio.h>
#include <yarp/os/Network.h>
#include <yarp/dev/ControlBoardInterfaces.h>
#include <yarp/dev/PolyDriver.h>
#include <yarp/os/Time.h>
#include <yarp/sig/Vector.h>

#include <string>

using namespace yarp::dev;
using namespace yarp::sig;
using namespace yarp::os;

int main(int argc, char *argv[]) 
{
    Network yarp;

    Property params;
    params.fromCommand(argc, argv);

    if (!params.check("robot"))
    {
        fprintf(stderr, "Please specify the name of the robot\n");
        fprintf(stderr, "--robot name (e.g. icub)\n");
        return -1;
    }
    std::string robotName=params.find("robot").asString().c_str();
    
    //For every part, I will need a driver - see e.g. /home/matej/programming/iCub/main/src/tools/robotMotorGui/src/main.cpp
    
    std::string remotePorts_left="/";
    remotePorts_left+=robotName;
    remotePorts_left+="/left_arm";

    std::string remotePorts_right="/";
    remotePorts_right+=robotName;
    remotePorts_right+="/right_arm";

    std::string localPorts_left="/test/client_left";
    std::string localPorts_right="/test/client_right";

    Property options_left, options_right;
    options_left.put("device", "remote_controlboard");
    options_right.put("device", "remote_controlboard");
    options_left.put("local", localPorts_left.c_str());   //local port names
    options_right.put("local", localPorts_right.c_str());   //local port names
    options_left.put("remote", remotePorts_left.c_str());         //where we connect to
    options_right.put("remote", remotePorts_right.c_str());         //where we connect to

    // create a device
    PolyDriver robotDevice_left(options_left);
    if (!robotDevice_left.isValid()) {
        printf("Device 'left' not available.  Here are the known devices:\n");
        printf("%s", Drivers::factory().toString().c_str());
        return 0;
    }
    PolyDriver robotDevice_right(options_right);
    if (!robotDevice_right.isValid()) {
        printf("Device 'right' not available.  Here are the known devices:\n");
        printf("%s", Drivers::factory().toString().c_str());
        return 0;
    }
    
   

    IPositionControl *pos_left;
    IPositionControl *pos_right;
    IEncoders *encs_left;
    IEncoders *encs_right;

    bool ok_left, ok_right;
    ok_left = robotDevice_left.view(pos_left);
    ok_left = ok_left && robotDevice_left.view(encs_left);

    ok_right = robotDevice_right.view(pos_right);
    ok_right = ok_right && robotDevice_right.view(encs_right);
    
    if (!ok_left) {
        printf("Problems acquiring 'left' interfaces\n");
        return 0;
    }
    if (!ok_right) {
        printf("Problems acquiring 'right' interfaces\n");
        return 0;
    }

    int nj_left=0;
    int nj_right=0;
    int nj = 0; //nr. of joints 
    pos_left->getAxes(&nj_left);
    pos_right->getAxes(&nj_right);
    if (nj_left != nj_right){
     printf("ERROR: nr. joints left and right are not the same - the application was meant for left and right arm... \n"); 
    }
    else{
      nj = nj_left;  
    }
    Vector encoders_left,encoders_right;
    Vector command, command_left, command_right;
    Vector tmp;
    encoders_left.resize(nj_left);
    encoders_right.resize(nj_right);
    tmp.resize(nj);
    command.resize(nj);
    command_left.resize(nj_left);
    command_right.resize(nj_right);
    
    
    int i;
    for (i = 0; i < nj; i++) {
         tmp[i] = 50.0;
    }
    pos_left->setRefAccelerations(tmp.data());
    pos_right->setRefAccelerations(tmp.data());

    for (i = 0; i < nj; i++) {
        tmp[i] = 10.0;
        pos_left->setRefSpeed(i, tmp[i]);
	pos_right->setRefSpeed(i, tmp[i]);
    }

    //pos->setRefSpeeds(tmp.data()))
    
    //fisrst zero all joints
    //  command=0;
    
    //Or go "home" like in the icubSim when you press 'H'
    // taken off from the GUI - you may also check robotMotorGui.ini
    command[0]= -24;
    command[1]= 20;
    command[2]= 0;
    command[3]= 50;
    command[4]= 0;
    command[5]= 0;
    command[6]= 0;
    command[7]= 59;
    command[8]= 20;
    command[9]= 20;
    command[10]= 20;
    command[11]= 10;
    command[12]= 10;
    command[13]= 10;
    command[14]= 10;
    command[15]= 10;
    pos_left->positionMove(command.data());
    pos_right->positionMove(command.data());
    
    bool done_left=false;
    bool done_right=false;

    while(! (done_left && done_right))
    {
        pos_left->checkMotionDone(&done_left);
	pos_right->checkMotionDone(&done_right);
        Time::delay(0.1);
    }
    
    
    //Self-collision primitive 1 
    command[0]=-50;
    command[2]=43; //shoulder yaw - move arm in front of you
    command[9]=69; // close the thumb
    pos_left->positionMove(command.data());
    pos_right->positionMove(command.data());
    
    done_left=false;
    done_right=false;

    while(! (done_left && done_right) )
    {
        pos_left->checkMotionDone(&done_left);
	pos_right->checkMotionDone(&done_right);
        Time::delay(0.1);
    }

    int times=0;
    while(true)
    {
        times++;
        if (times%2)
        {
             command[6]=-20; //move wrist up and down 
            
        }
        else
        {
             command[6]=20;
        }

        pos_left->positionMove(command.data());

        int count=50;
        while(count--)
            {
                Time::delay(0.1);
                bool ret_left=encs_left->getEncoders(encoders_left.data());
                
                if (!ret_left)
                {
                    fprintf(stderr, "Error receiving encoders 'left', check connectivity with the robot\n");
                }
                else
                { 
                   // printf("%.1lf %.1lf %.1lf %.1lf\n", encoders_left[0], encoders_left[1], encoders_left[2], encoders_left[3]);
                }
            }
    }

    robotDevice_left.close();
    robotDevice_right.close();
    return 0;
}
