add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010

$exch2010 = Get-MailboxServer |Where {$_.AdminDisplayVersion -like "Version 14.3 *"} |Get-Mailbox
$exch2013 = Get-MailboxServer |Where {$_.AdminDisplayVersion -like "Version 15.0 *"} |Get-Mailbox

$recipients = @("","","")
$sender = ""
$subject = "Move Updates"
$attachments = @("moves.txt","moves.csv","exchange2010.csv","exchange2013.csv")

$moves = Get-MoveRequest
$movesfailed = $moves |where {$_.Status -eq "Failed"}
$movescompleted = $moves |where {$_.Status -eq "Completed"}
$movesinprogress = $moves |where {$_.Status -eq "InProgress"}
$movespending = $moves |where {$_.Status -eq "Pending"}

"Total Moves : "+$moves.Count |Out-File moves.txt
"Failed Moves : "+$movesfailed.Count |Out-File moves.txt -Append
"Completed Moves : "+$movescompleted.Count |Out-File moves.txt -Append
"In Progress Moves : "+$movesinprogress.Count |Out-File moves.txt -Append
"Pending : "+$movespending.Count |Out-File moves.txt -Append
"Users on 2010 : "+$exch2010.Count |Out-File moves.txt -Append
"Users on 2013 : "+$exch2013.Count |Out-File moves.txt -Append

$mailbody = Get-Content moves.txt
$movesinprogress |Get-MoveRequestStatistics | select-object DisplayName,StatusDetail,TotalMailboxSize,PercentComplete |Export-CSV moves.csv
$exch2013 |Get-MailboxStatistics |Select DisplayName,Database,ItemCount,TotalItemSize |Export-Csv exchange2013.csv
$exch2010 |Get-MailboxStatistics |Select DisplayName,Database,ItemCount,TotalItemSize |Export-Csv exchange2010.csv

Send-MailMessage -To $recipients -From $sender -Subject $subject -SmtpServer <server> -Body "See attachment" -Attachments $attachments 
