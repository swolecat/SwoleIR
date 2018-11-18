# SwoleIR
A collection of various (and simple) powershell scripts utilized for Windows IR. All scripts have been tested and utilized in a Powershell 5.0 environment. 

# Active Scripts
### LocalIR
Utilize for collection of local accounts, processess, services, active connections, USB history, programs and items in DNS cache. It will dump each into a text file for processing and collection in the directory that the script was ran from. Use this script locally on the device. 
```
Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'"| format-list -property * | out-file accounts.txt
get-process | format-list -property *| out-file process.txt
get-service | format-list -property * | out-file services.txt
netstat -ano | format-list -property * | out-file connections.txt
Get-ItemProperty -ea 0 hklm:\system\currentcontrolset\enum\usbstor\*\* | select FriendlyName,PSChildName | out-file usb.txt
gp -ea 0 HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Select DisplayName,DisplayVersion,Publisher,InstallDate,InstallLocation | Sort InstallDate -Desc | out-file programs.txt
ipconfig /displaydns | select-string 'Record Name' | out-file dnscache.txt
```
### ADUniqueScriptID
Utilize for identification of unique logon scripts present in Active Directory. Logon Scripts are frequently utilized to maintain persistence or compromise additional users via GPO. Requires ActiveDirectory module running in shell `Import-Module ActiveDirectory` . 
```
get-aduser  -filter * -properties ScriptPath | Where-Object {$_.Enabled -like "True"} | select ScriptPath | Get-Unique
```
### Cylance Health Checker
This script checks the health of deployed Cylance clients by displaying the policy applied to the device, last communication with the cloud and version of the agent.
```
#Swolecat
clear
write-output "Cylance Health Check"
$ServiceCheck = get-service CylanceSVC,Cyoptics | Select Status, Name | format-table -auto
write-output $ServiceCheck
#JSONParserCodeFromSheldonCarmichael2017
Add-Type -Assembly System.Web.Extensions
$Cylance="$env:ProgramData\Cylance\Status\Status.json"
#Uses the Get-Content Module to load the JSON data as a string 
$String=Get-Content $Cylance
#Converts the specified JSON string to an object 
$Output=(New-Object System.Web.Script.Serialization.JavaScriptSerializer).DeserializeObject($String)
#Displays converted JSON via defined fields
Write-output "Cylance Last Checkin Time:"
$Output.ProductInfo.last_communicated_timestamp
Write-output "Cylance Policy:"
$Output.Policy.name
write-output "Cylance Version:"
$Output.ProductInfo.version
```

# Feedback
Feel free to use, modify and send feedback. 
