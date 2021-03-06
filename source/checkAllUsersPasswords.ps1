#Written by KramWell.com - 13/APR/2019
#Script for checking a specific password for all users in AD. 

Import-Module ActiveDirectory

$pass = "Password1"

Function Test-ADAuthentication { 
    param($userlogin,$userpassword) 
    (new-object directoryservices.directoryentry "",$userlogin,$userpassword).psbase.name -ne $null 
}

#check all in AD
$ADUsers = Get-ADUser -filter {(SamAccountName -like "*")}
$loopCount = 0

Foreach ($User in $ADUsers)
{
	$loopCount++

	if (Test-ADAuthentication $User.SamAccountName $pass){	
	        $message = "Valid credentials for " + $User.SamAccountName + "" 
	        Write-Host $message -ForegroundColor Green  
	}
}

Write-Host Total Count : $loopCount

#################################
#check a single user
#################################
#if (Test-ADAuthentication $login $pass){ 
#	$message = "Valid credentials for " + $login + "" 
#	Write-Host $message -ForegroundColor Green  
#}else{ 
#	$message = "Invalid credentials for " + $login + "" 
#	Write-Host $message -ForegroundColor Red  
#} 
