# Copyright: (C) 2011 EFAA Consortium
# Authors: Stéphane Lallée
# 2015: modifications Matej Hoffmann 
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 2.8)

if(COMMAND cmake_policy)
    cmake_policy(SET CMP0003 NEW)
endif(COMMAND cmake_policy)


set(PROJECTNAME motorBabblingCartesian)
project(${PROJECTNAME})

find_package(YARP)
find_package(ICUB)
list(APPEND CMAKE_MODULE_PATH ${YARP_MODULE_PATH})
list(APPEND CMAKE_MODULE_PATH ${ICUB_MODULE_PATH})
include(YarpInstallationHelpers)

find_package(ICUBcontrib)
list(APPEND CMAKE_MODULE_PATH ${ICUBCONTRIB_MODULE_PATH})
include(ICUBcontribHelpers)
include(ICUBcontribOptions)
icubcontrib_set_default_prefix()

add_definitions(${YARP_DEFINES})   # add yarp definitions - this contains also -D_REENTRANT
include(YarpInstallationHelpers)   # pick up yarp's cmake scripts

include_directories(${ICUB_INCLUDE_DIRS} ${YARP_INCLUDE_DIRS})

file(GLOB source main.cpp)
source_group("Source Files" FILES ${source})

add_executable(${PROJECTNAME} ${source} ${header})

target_link_libraries(${PROJECTNAME} ${YARP_LIBRARIES} icubmod)

install(TARGETS ${PROJECTNAME} DESTINATION bin)

#icubcontrib_finalize_export(${PROJECTNAME})
icubcontrib_add_uninstall_target()
