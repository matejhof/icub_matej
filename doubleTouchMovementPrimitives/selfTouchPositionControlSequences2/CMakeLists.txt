# Copyright: 2013 iCub Facility, Istituto Italiano di Tecnologia
# Author: Matej Hoffmann
# CopyPolicy: Released under the terms of the GNU GPL v2.0.
# 

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
SET(PROJECTNAME selfTouchPosControlSeq2)
PROJECT(${PROJECTNAME})

FIND_PACKAGE(YARP)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${YARP_MODULE_PATH})

include_directories(${YARP_INCLUDE_DIRS})
add_executable(selfTouchPosControlSeq2 selfTouchPosControlSeq.cpp)
target_link_libraries(selfTouchPosControlSeq2 ${YARP_LIBRARIES})


