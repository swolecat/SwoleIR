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
