Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Import-Module .\PSSlack
$Uri = "REMOVED"
$SmtpServerVar = "REMOVED"

#Function that takes two arguments and posts them into slack

function Send-SMessage($message)

      {

      Send-SlackMessage -Uri $Uri -Parse Full -Username 'Testy McTesterson' -IconEmoji ':friday:' -Text $message

      }

#Email Function

function Send-EMessage($emailSubject, $emailMessage)

      {

      Send-MailMessage -To "REMOVED" -From "Scripty REMOVED" -Subject $emailSubject -SmtpServer REMOVED -Body $emailMessage

      }
