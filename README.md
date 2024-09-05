# LEST NI Data Acquisition 

Codes for data acquisition in University of Minho's LEST laboratory using MATLAB and National Instruments DAQ equipment.

Date: 07/04/2022

---

## Introduction:

This MATLAB livescript allows to perform data acquisition using the National Instruments devices available in LEST.

Important information for non-Matlab users: 
 - For running the script sections, place the cursor on the section to run, and press "Ctrl+Enter"
 - For comment command-lines, place the cursor on the command and press "Ctrl+R", or add a '%' sign in front of the line.
 - For uncomment command-lines, place the cursor on the command and press "Ctrl+T",  or delete the '%' sign in front of the line.

Commenting/uncommenting lines of code allows to omit/include them from the running process. When a line is setup as comment, a % sign will appear in front of the line and the font color will change to green.

i.e.:
  % This a commented line and it will not be considered in the script code when runned.
  This is a uncommented line and it will be considered in the code. (If runned, this line will give a "Unrecognized function or variable" error).

## Drivers and needed files installation:
Mandatory installation "Data Acquisition Toolbox"
The Data Acquisition Toolbox Addon ids needed in order to run this live script. The toolbox can be installed directly from the Matlab add-ons explorer, or it can be downloaded by clicking here. (Last time visited: 07/04/2022)
Mandatory installation "Data Acquisition Toolbox Support Package for National Instruments NI-DAQmx Devices"
National Instruments drivers and needed files. Can be installed directly from the Matlab add-ons explorer, or it can be downloaded by clicking here. (Last time visited: 07/04/2022)

Currently already tested and working devices and configurations:
NI USB-9162 USB carrier + NI 9234 ADC (1 to 4 channels).
NI cDAQ-9178 chassis + NI 9234 ADC (1 to 16 channels).

---

NOTE: Check for updated links.
