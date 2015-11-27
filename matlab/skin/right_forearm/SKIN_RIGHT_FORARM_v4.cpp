case SKIN_RIGHT_FOREARM:
            //upper small patch (7 triangles)
             if((geo_center_link_FoR[0]>-0.0326) && (geo_center_link_FoR[0]<0.0326) && (geo_center_link_FoR[1]<0.0528) && (geo_center_link_FoR[1]>-0.0039) && (geo_center_link_FoR[2]<0.0538) && (geo_center_link_FoR[2]>0)){
                //triangle taxel IDs 288-299
                pushTriangleToTaxelList(288,list_of_taxels);
                //triangle 300-311
                pushTriangleToTaxelList(300,list_of_taxels);
                //triangle 348-359 
                pushTriangleToTaxelList(348,list_of_taxels);

             }

            else if((geo_center_link_FoR[0]>-0.0345) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.1087) && (geo_center_link_FoR[1]>0.0528) && (geo_center_link_FoR[2]<0.0569) && (geo_center_link_FoR[2]>0)){
                 //triangle 204:215
                pushTriangleToTaxelList(204,list_of_taxels);
                //triangle 336:347
                pushTriangleToTaxelList(336,list_of_taxels);
            }

            else if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0345) && (geo_center_link_FoR[1]<0.1087) && (geo_center_link_FoR[1]>0.0545) && (geo_center_link_FoR[2]<0.0569) && (geo_center_link_FoR[2]>0)){
                //triangle 252:263
                pushTriangleToTaxelList(252,list_of_taxels);
                //triangle 312:323
                pushTriangleToTaxelList(312,list_of_taxels);

                ///////////////////////////////////////////////////////////////////////

                ///lower patch - big (16 triangles)

            else if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]<0) && (geo_center_link_FoR[2]<-0.0281) && (geo_center_link_FoR[2]>-0.0484)){
                 //triangle 12 132:143
                pushTriangleToTaxelList(132,list_of_taxels);
                //triangle 16 168:179
                pushTriangleToTaxelList(168,list_of_taxels);
            }

            else if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.1081) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<-0.0343) && (geo_center_link_FoR[2]>-0.0526)){
                //triangle 3, 156:167
                pushTriangleToTaxelList(156,list_of_taxels);
                //triangle 8, 144:155
                pushTriangleToTaxelList(144,list_of_taxels);
            }
            
            else if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.1133) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<-0) && (geo_center_link_FoR[2]>-0.0343)){
                //triangle 4, 24:35
                pushTriangleToTaxelList(24,list_of_taxels);
                //triangle 6, 12:23
                pushTriangleToTaxelList(12,list_of_taxels); 
            }    

            else if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]>0) && (geo_center_link_FoR[2]<0) && (geo_center_link_FoR[2]>-0.0281)){
                //triangle 10, 0:11
                pushTriangleToTaxelList(0,list_of_taxels);
                //triangle 14, 180:191
                pushTriangleToTaxelList(180,list_of_taxels);
            }    

            else if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]>0) && (geo_center_link_FoR[2]<-0.0281) && (geo_center_link_FoR[2]>-0.0484)){
                //triangle 11, 120:131
                pushTriangleToTaxelList(120,list_of_taxels);
                //triangle 15, 60:71
                pushTriangleToTaxelList(60,list_of_taxels);
            }

            else if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.1081) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<-0.0343) && (geo_center_link_FoR[2]>-0.0526)){
                //triangle 2, 96:107
                pushTriangleToTaxelList(96,list_of_taxels);
                //triangle 7, 108:119
                pushTriangleToTaxelList(108,list_of_taxels);
            }
            
            else if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.1133) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<0) && (geo_center_link_FoR[2]>-0.0343)){
                //triangle 1, 84:95
                pushTriangleToTaxelList(84,list_of_taxels);
                //triangle 5, 72:83
                pushTriangleToTaxelList(72,list_of_taxels);
            }

            else if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]>0) && (geo_center_link_FoR[2]<0) && (geo_center_link_FoR[2]>-0.0281)){
                //triangle 9, 36:47
                pushTriangleToTaxelList(36,list_of_taxels);
                //triangle 13, 48:59
                pushTriangleToTaxelList(48,list_of_taxels);
            }
            break;
            
         default:  
            yWarning("OdeSdlSimulation::mapPositionIntoTaxelList: WARNING: contact at part: %d, but no taxel resolution implemented for this skin part. \n",skin_part); 
    }
    
//      if (odeinit.verbosity > 2) {
//          yDebug("OdeSdlSimulation::mapPositionIntoTaxelList: contact at part: %d, coordinates: %f %f %f. \n",skin_part,geo_center_link_FoR[0],geo_center_link_FoR[1],geo_center_link_FoR[2]); 
//          yDebug("    Taxel list: ");
//          for (std::vector<unsigned int>::const_iterator it = list_of_taxels.begin() ; it != list_of_taxels.end(); ++it){
//                 yDebug("%d,",*it);
//          }
//          yDebug("\n");
//      }
     return;
}

//pushes taxel IDs of whole triangle into list_of_taxels, starting from startingTaxelID and skipping 7th and 11th taxels (thermal pads)
void OdeSdlSimulation::pushTriangleToTaxelList(const int startingTaxelID,std::vector<unsigned int>& list_of_taxels)
{
    int i = startingTaxelID;
    for (i=startingTaxelID;i<startingTaxelID+6;i++){
        list_of_taxels.push_back(i);
    }
    //skipping 7th and 11th taxel - thermal pads 
    for (i = startingTaxelID + 7; i < startingTaxelID + 10; i++){
        list_of_taxels.push_back(i);
    }
    list_of_taxels.push_back(startingTaxelID+11);
}