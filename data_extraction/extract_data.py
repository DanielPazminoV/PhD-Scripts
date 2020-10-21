# Extracts data from INAMHI text files

# Creates text files to write outputs of variables with 13 (most variables)  
# and 9 (wind speed) elements per list 

InFileName = "M002.txt"
InFile = open(InFileName, 'r')
OutFile_13 = open('Variables_13_elements.txt','w')
OutFile_9 = open('Variables_9_elements.txt','w')

# Loop through each line in the file to extract data that has 13 
# and 9 elements per list

for Line in InFile:    
    Line = Line.strip('\n')
    ElementList = Line.split()
    LenList = len(ElementList)    

# Extract the year and month for each block of data

    if 'ESTACION:' in ElementList:
        ElementList_Estacion = ElementList
        Month =  ElementList_Estacion[4]
        Year =  ElementList_Estacion[6]

# Selects data with 13 elements per list (Temperature, Vapor Tension, Relative Humidity, Dew Point,.. 
# ..., Precipitation, Evaporation, Cloudiness) 

    if LenList == 13 and 'DIA' not in ElementList:
        Elementlist_13 = ElementList
        OutString_1 = Elementlist_13
        if '#.Dias' not in OutString_1:
            OutString_2 = OutString_1
            if 'MEDIA' not in OutString_2:
                OutString_3 = OutString_2
                if 'MAXIMA' not in OutString_3:
                    OutString_4 = OutString_3
                    if 'MINIMA' not in OutString_4:
                        OutString_5 = OutString_4
                        if 'Dia' not in OutString_5:
                            OutString_6 = OutString_5
                            OutString_6.insert(0,Year)
                            OutString_6.insert(1,Month)
                            str = " "
		            OutString_7 = str.join(OutString_6)
		            OutFile_13.write("%s\n" % OutString_7)
                            print  OutString_7

# Select data with 9 element por list (Wind Speed)

# Since there are some lines that have 9 elements and
# do not correspond to wind spedd data, a deprutation
# process is performed

    if LenList == 9: 
        ElementList_9 = ElementList	

	try:
           ElementList_9 =  map(float, ElementList_9) 
        except ValueError:
            pass
        try:
            ElementList_9 = [sum(ElementList_9)]
        except TypeError:
            pass
        
        NewLenList = len(ElementList_9)

# Select data with 9 element por list (Wind Speed)
	
        if NewLenList == 9 and '*******' not in ElementList_9:
            OutString_1 = ElementList_9   
            if 'MAXIMA' not in OutString_1:
                OutString_2 = OutString_1
                if 'MINIMA' not in OutString_2:
                    OutString_3 = OutString_2
                    if 'Dia' not in OutString_3:
                        OutString_4 = OutString_3
                        if 'SUMA' not in OutString_4:
                            OutString_5 = OutString_4
                            if '----' not in OutString_5:
                                OutString_6 = OutString_5
                                if 'DIR' not in OutString_6:
                                    OutString_7 = OutString_6 
                                    OutString_7.insert(0,Year)
                                    OutString_7.insert(1,Month)                                                     
                                    if 'MEDIA' not in OutString_7[2]:
                                        OutString_8 = OutString_7
            				if '#.Dias' not in OutString_8[2]:
                			    OutString_9 = OutString_8
					    if 'N' not in OutString_9[2]: 
                                                OutString_10 = OutString_9
                                                if 'NE' not in OutString_10[2]:
                                                    OutString_11 = OutString_10
                                                    if 'E' not in OutString_11[2]:
                                                        OutString_12 = OutString_11
                                                        if 'SE' not in OutString_12[2]:
                                                            OutString_13 = OutString_12
							    if 'S' not in OutString_13[2]:
                                                                OutString_13 = OutString_13
								if 'SW' not in OutString_13[2]:
                                                                    OutString_14 = OutString_13
								    if 'W' not in OutString_14[2]:
                                                                        OutString_15 = OutString_14
									if 'NW' not in OutString_15[2]:
                                                                            OutString_16 = OutString_15
								            if 'C' not in OutString_16[2]:
                                                                                OutString_17 = OutString_16
											
										str = " "
                                    						OutString_18 = str.join(OutString_17)
				    						OutFile_9.write("%s\n" % OutString_18)			            
				    					        print  OutString_18

# Creates headings for data with 13 elements per list
# Te = Temperature Extremes, Ts = Dry Termometer, Th = Humid Termometer

    if 'MAX.' in ElementList:
	 ElementList_Max = ElementList
	 ElementList_Max.insert(0, 'Year')
	 ElementList_Max.insert(1, 'Month')
	 ElementList_Max[2] = 'Day' 
	 ElementList_Max[3] = 'Te_Max' 
	 ElementList_Max[4] = 'Te_Min'
         ElementList_Max[5] = 'Te_Ocs'
	 ElementList_Max[6] = 'Te_Med'
	 ElementList_Max[7] = 'Ts_7'
	 ElementList_Max[8] = 'Ts_13'
	 ElementList_Max[9] = 'Ts_19'
	 ElementList_Max[10] = 'Ts_Med'
	 ElementList_Max[11] = 'Th_7'
	 ElementList_Max[12] = 'Th_13'
	 ElementList_Max[13] = 'Th_19'
	 ElementList_Max[14] = 'Th_Med'
         str = " "
         ElementList_Max_String = str.join(ElementList_Max)
         OutFile_13.write("%s\n" % ElementList_Max_String)
	 print ElementList_Max_String

# Tv = Vapor tension, Rh = Relative Humidity, Pr = Dew Point

    if 'TENSION' in ElementList:
        ElementList_Tension = ElementList        
	ElementList_Tension.insert(0, 'Year')
        ElementList_Tension.insert(1, 'Month')
	ElementList_Tension[2] = 'Day'
        ElementList_Tension[3] = 'Tv_7'
        ElementList_Tension[4] = 'Tv_13'
        ElementList_Tension[5] = 'Tv_19'
        ElementList_Tension[6] = 'Tv_Med'
        ElementList_Tension[7] = 'Rh_7'
        ElementList_Tension[8] = 'Rh_13'
        ElementList_Tension[9] = 'Rh_19'
        ElementList_Tension[10] = 'Rh_Med'
        ElementList_Tension[11] = 'Pr_7'
        ElementList_Tension[12] = 'Pr_13'
        ElementList_Tension.insert(13, 'Pr_19')
        ElementList_Tension.insert(14, 'Pr_Med')
        str = " "
        ElementList_Tension_String = str.join(ElementList_Tension)
        OutFile_13.write("%s\n" % ElementList_Tension_String)
        print ElementList_Tension	

# P = Precipitation, Ev = Evaporation, Nub = Cloudiness

    if 'SUM.' in ElementList:
        ElementList_Sum = ElementList
        ElementList_Sum.insert(0, 'Year')
        ElementList_Sum.insert(1, 'Month')
	ElementList_Sum[2] = 'Day'
        ElementList_Sum[3] = 'P_7'
        ElementList_Sum[4] = 'P_13'
        ElementList_Sum[5] = 'P_19'
        ElementList_Sum[6] = 'P_Sum'
        ElementList_Sum[7] = 'Ev_7'
        ElementList_Sum[8] = 'Ev_13'
        ElementList_Sum[9] = 'Ev_19'
        ElementList_Sum[10] = 'Ev_Sum'
        ElementList_Sum[11] = 'Nub_7'
        ElementList_Sum[12] = 'Nub_13'
        ElementList_Sum[13] = 'Nub_19'
        ElementList_Sum[14] = 'Nub_Med'
        str = " "
        ElementList_Sum_String = str.join(ElementList_Sum)
        OutFile_13.write("%s\n" % ElementList_Sum_String)
        print ElementList_Sum_String 

# Dd = Wind Direction, Vv = Wind speed  

    if 'DD.' in ElementList:
        ElementList_Dd = ElementList
        ElementList_Dd.insert(0, 'Year')
        ElementList_Dd.insert(1, 'Month')
        ElementList_Dd[2] = 'Day'
        ElementList_Dd[3]= 'Dd_7'
        ElementList_Dd[4] = 'Vv_7'
        ElementList_Dd[5] = 'Dd_13'
        ElementList_Dd[6] = 'Vv_13'
        ElementList_Dd[7]= 'Dd_19'
        ElementList_Dd[8]= 'Vv_19'
        ElementList_Dd[9]= 'Vv_T'
        ElementList_Dd.insert(10, 'Vv_Med')
        str = " "
        ElementList_Dd_String = str.join(ElementList_Dd)
        OutFile_9.write("%s\n" % ElementList_Dd_String)
        print ElementList_Dd_String

InFile.close()


