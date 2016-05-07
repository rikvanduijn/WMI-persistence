# WMI-persistence
POC code to accompany the blog. Client side code exists of the following parts: 

1. powershell script
2. MOF to install the script. 

Server side code is pretty self-explanitory. 

Preparing your own Base64 code for a command line argument could be performed like the following:

$var = Get-Content file
$encodedcommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($var))

powershell -ExecutionPolicy ByPass  -EncodedCommand $encodedcommand
