$intro = @'

Mail Tester
Written by Timothy Loftus

This script was created to test SMTP Relays from PowerShell. Once complete, this should be able to test
open SMTP relays at the moment. More implementations are foreseeable in the future. For a TODO list of things
that I plan on doing. Please read the README.md.

'@

$menu = @'
Please choose from the following options:

1. Open SMTP Relay Tester - This will test if you can send mail to an open SMTP relay. (No authentication or TLS)
2. MX Record Lookup - This section of the script will test to see whether or not MX records exist for the specified domain.
3. Exit this script.

'@

$testEmailSubject = "SMTP Relay Test Email"
$testEmailBody = @'
Greetings,

This is a test email, please do not respond.
Should you have any questions, please contact your Administrator.

Thank you,

Your IT Administrator
'@

$commonSMTPPorts = 25,587

# Sends an email to the parameters that are issued by the user.
Function Test-OpenSMTPRelay() {
  Write-Host -Object "[*] Testing the relay... Please check the recipiants mailbox..."
  Send-MailMessage `
    -To $toUserInput `
    -From $fromUserInput `
    -Subject $testEmailSubject `
    -Body $testEmailBody `
    -SmtpServer $smtpRelay `
    -Port $smtpPort
  Write-Host -Object "[*] Completed testing the relay..."
  Write-Host -Object ""
}

Function Check-MXRecords() {
  $recordType = "MX"
  Write-Host -Object "[*] Checking MX records..."
  Resolve-DnsName -Name $publicDomainName -Type $recordType
}

Function Check-Open

Function Main() {
  Write-Host -Object $intro

  Write-Host -Object $menu
  $userInput = Read-Host -prompt "[Mail Tools] Please choose from the available options"

  If ([string]$userInput -eq "1") {
    Write-Host -Object ""
    $toUserInput = Read-Host -prompt "[*] Please enter the recipiant mail address"
    $fromUserInput = Read-Host -Prompt "[*] Please enter the senders mail address"
    $smtpRelay = Read-host -Prompt "[*] Please enter the SMTP Server your would like to test"
    $smtpPort = Read-Host -Prompt "[*] Please enter the port being used"
    Test-OpenSMTPRelay
  }
  ElseIf ([string]$userInput -eq "2") {
    Write-Host -Object ""
    $publicDomainName = Read-Host -Prompt "[*] Please enter Public FQDN of the company who MX records you're checking"
    Check-MXRecords
  }
}

Main
