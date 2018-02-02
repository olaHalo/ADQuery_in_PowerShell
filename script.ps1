#Allow Module to be imported
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

#Import for Slack Module
#Import-Module C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSSlack
Import-Module PSSlack
#Default installation location should be in C:\Program Files\WindowsPowerShell\Modules\PSSlack

#Define variables
$nocUsers = Get-ADGroupMember "Information Security NOC" | Get-ADUser -Properties LastLogonDate #| Select SamAccountName,LastLogonDate,Enabled
$socUsers = Get-ADGroupMember "Information Security SOC" | Get-ADUser -Properties LastLogonDate #| Select SamAccountName,LastLogonDate,Enabled
$Uri = "URI Removed"



#Send Slack message to webhook
#Send-SlackMessage -Uri $Uri -Parse Full -Username 'COC_AD_Checker' -IconEmoji ':friday:' -Text 'The following accounts have not been logged into in over *30 days*'
function Get-InactiveADAccounts
{
	param($ADGroup)
	
	# Cycle through each user in the whatever group is passed  AD Groups
	foreach ($user in $ADGroup)
		{	
			#Define Date -30 Variable
			$currentDateMinus30 = (Get-Date).AddDays(-31)
			
			# Check if the last logon date is less than 30 days minus the current date AND if the user account is enabled
		if ($user.LastLogonDate -le $currentDateMinus30 -AND $user.enabled -eq $TRUE)
			{							
				#Output usernames and their last logon dates and convert to string. Pass this info to Slack
				$outputString = $user | Select SamAccountName,LastLogonDate | Format-List | Out-String	
				$outputString
				#Send-SlackMessage -Uri $Uri -Parse Full -Username 'COC_AD_Checker' -IconEmoji ':friday:' -Text $outputString
				
			}

		}

}

#Run the primary userLoop function. Loop through the following groups
Get-InactiveADAccounts -ADGroup $nocUsers
Get-InactiveADAccounts -ADGroup $socUsers
