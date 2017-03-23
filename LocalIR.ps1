Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'"| format-list -property * | out-file accounts.txt
get-process | format-list -property *| out-file process.txt
get-service | format-list -property * | out-file services.txt
netstat -ano | format-list -property * | out-file connections.txt
Get-ItemProperty -ea 0 hklm:\system\currentcontrolset\enum\usbstor\*\* | select FriendlyName,PSChildName | out-file usb.txt
gp -ea 0 HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Select DisplayName,DisplayVersion,Publisher,InstallDate,InstallLocation | Sort InstallDate -Desc | out-file programs.txt
ipconfig /displaydns | select-string 'Record Name' | out-file dnscache.txt