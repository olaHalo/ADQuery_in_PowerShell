Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Import-Module .\Send-MessageEmailandSlack.psm1

#Define variables

$nocUsers = Get-ADGroupMember "Information Security NOC" | Get-ADUser -Properties LastLogonDate #| Select SamAccountName,LastLogonDate,Enabled

$socUsers = Get-ADGroupMember "Information Security SOC" | Get-ADUser -Properties LastLogonDate #| Select SamAccountName,LastLogonDate,Enabled

$message = '*InActive Test Script Running*'

　

#Send-SMessage $message

function Get-InactiveADAccounts

{

param($ADGroup)

# Cycle through each user in the whatever group is passed AD Groups

foreach ($user in $ADGroup)

{

#Define Date -30 Variable

$currentDateMinus30 = (Get-Date).AddDays(-31)

# Check if the last logon date is less than 30 days minus the current date AND if the user account is enabled

if ($user.LastLogonDate -le $currentDateMinus30 -AND $user.enabled -eq $TRUE)

{

#Output usernames and their last logon dates and convert to string. Trim spaces for formatting. Pass this info to Slack and Email

$message += $user | Select SamAccountName,LastLogonDate | Format-List | Out-String | ForEach-Object { $_.Trim() }

$emailMessage += $user | Select SamAccountName,LastLogonDate | Format-List | Out-String | ForEach-Object { $_.Trim() }

}

}

#Send messages via Slack and Email

Send-SMessage $message

$emailSubject ='Mosaic NOC/SOC Inactive for Over 30 Days Script Results'

Send-EMessage $emailSubject $emailMessage

}

#Run the primary Get-InactiveADAccounts function. Loop through the following groups

Get-InactiveADAccounts -ADGroup $nocUsers

Get-InactiveADAccounts -ADGroup $socUsers
