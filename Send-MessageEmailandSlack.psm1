Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Import-Module .\PSSlack
$Uri = "https://hooks.slack.com/services/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"
$SmtpServerVar = "transport.ci.charlotte.nc.us"

#Function that takes two arguments and posts them into slack

function Send-SMessage($message)

      {

      Send-SlackMessage -Uri $Uri -Parse Full -Username 'Testy McTesterson' -IconEmoji ':friday:' -Text $message

      }

#Email Function

function Send-EMessage($emailSubject, $emailMessage)

      {

      Send-MailMessage -To "Matthew <matthew.wedlow@ci.charlotte.nc.us>" -From "Scripty <support@mosaic451.com>" -Subject $emailSubject -SmtpServer transport.ci.charlotte.nc.us -Body $emailMessage

      }
