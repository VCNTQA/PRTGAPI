# Connect to PrgtServer with your credential
PS C:> Connect-PrtgServer monitor.server.com


# Find out the sensor type of pythonscript
PS C:> get-sensortype | where-object name -like '*script*'
Id                                                  Name                              Description
--                                                  ----                              -----------
exe                                                 EXE/Script                        Runs an executable file, dynamic-link library file, or a script (batch file, VBScript, PowerShell) that returns a numerical value
exexml                                              EXE/Script Advanced               Runs an executable file, dynamic-link library file, or a script (batch file, VBScript, PowerShell) that returns XML or JSON
paessler.microsoftazure.subscription_cost_sensor.21 Microsoft Azure Subscription Cost Monitors the cost in a Microsoft Azure subscription<br/><br/><b>Enter the following credentials:</b><br/> Credentials for Microsoft Azure: Tenant ID<br/>Credentials for Microsoft Az...
pythonscript                                        Python Script Advanced            Runs a Python script that returns XML or JSON
sshscript                                           SSH Script                        Connects to a Linux/Unix system using SSH and runs a custom script that returns a numerical value
sshscriptxml                                        SSH Script Advanced               Connects to a Linux/Unix system using SSH and runs a custom script that returns XML or JSON


# Verify the device exist
PS C:> get-device -Name 'DD04'

Name                    Id     Status      Host            Sensors    Group                     Probe
----                    --     ------      ----            -------    -----                     -----
DD04                    17481  Up          dd04            0          DataDomain                VPRTG1


# Create a sesnor parameter of pythonscript type
PS C:> $params_pythonscript = get-device -Name 'DD04' |new-sensorparameters -rawtype pythonscript

# Verify the parameters of pythonscript:
PS C:> $params_pythonscript
pythonscriptlabel        :
usewindowsauthentication : 0
transmit_credentials     : 0
params                   :
mutexname                :
pythonscript             : DataDomain_Mtree_Pre-Comp.py
Targets                  : {[pythonscript, PrtgAPI.Targets.GenericSensorTarget[]]}
Source                   : DD04
SensorType               : pythonscript
Priority                 : Three
InheritTriggers          : True
InheritInterval          : True
Interval                 : 00:01:00
IntervalErrorMode        : OneWarningThenDown
DynamicType              : False
Name                     : Python Script Advanced Sensor 2
Tags                     : {pythonxml, python, xml, json...}
Cookie                   : False


# Modify the pythonscript if needed
# Example:
# - change scan interval to every 12h
# - change sensor name to 'MTree TEST_PRD_SRC'
# - change pythonscript parameter to  '/data/col1/TEST_PRD_SRC'
PS C:> $params_pythonscript.Interval = '12:00:00'
PS C:> $params_pythonscript.Name = 'MTree TEST_PRD_SRC'
PS C:> $params_pythonscript.params = '/data/col1/TEST_PRD_SRC'


# Add advanced script sensor to device 
PS C:> get-device -Name 'DD04' | Add-sensor $params_pythonscript
