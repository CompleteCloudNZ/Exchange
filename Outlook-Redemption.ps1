$user = ""
$pass = ""

$redemptionsession = New-Object -Com redemption.rdosession

Write-Host "Attempting to connect to" $user
$redemptionsession.LogonHostedExchangeMailbox($user,"",$pass)

$mailbox =  $redemptionsession.Stores.DefaultStore
$pstStore = $redemptionsession.Stores.AddPSTStore("", 1, "");

Write-Host "Connected to" $mailbox.IPMRootFolder.FolderPath "and found folders:"
$mailbox.IPMRootFolder.Folders |select Name

foreach($folder in $mailbox.IPMRootFolder.Folders)
{
    Write-Host "Copying" $folder.Name
    $folder.CopyTo($pstStore.IPMRootFolder);
}

$redemptionsession.Logoff()
