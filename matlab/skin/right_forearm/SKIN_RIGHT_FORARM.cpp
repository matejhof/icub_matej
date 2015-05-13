case SKIN_RIGHT_FOREARM:
            int a = 0;
             if((geo_center_link_FoR[0]>-0.0326) && (geo_center_link_FoR[0]<0.0326) && (geo_center_link_FoR[1]<0.0328) && (geo_center_link_FoR[1]>-0.0039) && (geo_center_link_FoR[2]<0.0338) && (geo_center_link_FoR[2]>0)){
                //trojuholnik 3
                for (i = 288; i < 288 + 6; i++){
                    list_of_taxels.push_back(i);
                }
                //skipping 7th and 11th taxel - thermal pads (here taxels 294 and 298)
                list_of_taxels.push_back(295);list_of_taxels.push_back(296);list_of_taxels.push_back(297);
                list_of_taxels.push_back(299);
              
                //trojuholnik 4 300-311
                a = 300;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 7 348-359 
                a = 348;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

             }

            if((geo_center_link_FoR[0]>-0.0345) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.0687) && (geo_center_link_FoR[1]>0.0328) && (geo_center_link_FoR[2]<0.0369) && (geo_center_link_FoR[2]>0)){
                a = 252;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 5 312:323
                a = 312;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }

            if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0345) && (geo_center_link_FoR[1]<0.0687) && (geo_center_link_FoR[1]>0.0345) && (geo_center_link_FoR[2]<0.0328) && (geo_center_link_FoR[2]>0)){
                a = 204;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 6 336:347
                a = 336;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                ///////////////////////////////////////////////////////////////////////

                //spodok

                 if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]<0.0298) && (geo_center_link_FoR[2]<-0.0281) && (geo_center_link_FoR[2]>-0.0484)){
                //trojuholnik 12 132
                a = 132;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 16 168
                 a = 168;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }

            if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.1081) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<-0.0343) && (geo_center_link_FoR[2]>-0.0526)){
            //3 a 8 cize od 157 a 145
                //trojuholnik 3 156
                a = 156;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 8 144
                a = 144;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }
            
            if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.1133) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<-0) && (geo_center_link_FoR[2]>-0.0343)){
            //%cs 4 a 6 cize od 25 a 13
                //trojuholnik 4 24
                a = 24;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 6 13
                a = 12;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }    

            if((geo_center_link_FoR[0]>-0.0375) && (geo_center_link_FoR[0]<0) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]>0.0318) && (geo_center_link_FoR[2]<0) && (geo_center_link_FoR[2]>-0.0281)){
            //%cs 10 a 14 cize od 1 a 181 
                //trojuholnik 10 0
                a = 0;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 14 180
                a = 180;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }    

            if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]>0.0298) && (geo_center_link_FoR[2]<-0.0281) && (geo_center_link_FoR[2]>-0.0484)){
            //cs 11 a 15 cize od 121 a 61
                //trojuholnik 11 120
                a = 120;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 15 60
                a = 60;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }

            if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.1081) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<-0.0343) && (geo_center_link_FoR[2]>-0.0526)){
            //cs 2 a 7 cize od 97 a 109
               //trojuholnik 2 96
                a = 96;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 7 108
                a = 108;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }
            
            if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.1133) && (geo_center_link_FoR[1]>0.0716) && (geo_center_link_FoR[2]<0) && (geo_center_link_FoR[2]>-0.0343)){
            // cs 1 a 5 cize od 85 a 73
                //trojuholnik 1 84
                a = 84;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 5 72
                a = 72;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }

            if((geo_center_link_FoR[0]>0) && (geo_center_link_FoR[0]<0.0375) && (geo_center_link_FoR[1]<0.0716) && (geo_center_link_FoR[1]>0.0318) && (geo_center_link_FoR[2]<0) && (geo_center_link_FoR[2]>-0.0281)){
            // cs 9 a 13 cize od 37 a 49
                //trojuholnik 9 36
                a = 36;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);

                //trojuholnik 13 48
                a = 48;
                for (i = a; i < a + 6; i++){
                    list_of_taxels.push_back(i);
                }
                for (i = a + 7; i < a + 10; i++){
                    list_of_taxels.push_back(i);
                }
                list_of_taxels.push_back(a+11);
            }

