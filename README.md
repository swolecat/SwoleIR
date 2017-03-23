# SwoleIR
A collection of various (and simple) powershell scripts utilized for Windows IR. All scripts have been tested and utilized in a Powershell 5.0 environment. 

# Active Scripts
### LocalIR
Utilize for collection of local accounts, processess, services, active connections, USB history, programs and items in DNS cache locally on a target host. It will dump each into a text file for processing and collection in the directory that the script was ran from. 
```
Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'"| format-list -property * | out-file accounts.txt
get-process | format-list -property *| out-file process.txt
get-service | format-list -property * | out-file services.txt
netstat -ano | format-list -property * | out-file connections.txt
Get-ItemProperty -ea 0 hklm:\system\currentcontrolset\enum\usbstor\*\* | select FriendlyName,PSChildName | out-file usb.txt
gp -ea 0 HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Select DisplayName,DisplayVersion,Publisher,InstallDate,InstallLocation | Sort InstallDate -Desc | out-file programs.txt
ipconfig /displaydns | select-string 'Record Name' | out-file dnscache.txt
```


# Feedback
Feel free to use, modify and send feedback. 
