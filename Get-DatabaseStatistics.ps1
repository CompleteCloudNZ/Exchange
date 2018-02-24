
    $Databases = Get-MailboxDatabase -Status
    foreach($Database in $Databases) {
        $DBSize = $Database.DatabaseSize
        $MBCount = @(Get-MailboxStatistics -Database $Database.Name).Count
        
        $MBAvg = Get-MailboxStatistics -Database $Database.Name | 
          %{$_.TotalItemSize.value.ToMb()} | 
            Measure-Object -Average            

        New-Object PSObject -Property @{
            Server = $Database.Server.Name
            DatabaseName = $Database.Name
            LastFullBackup = $Database.LastFullBackup
            MailboxCount = $MBCount
            "DatabaseSize (GB)" = $DBSize.ToGB()
            "AverageMailboxSize (MB)" = $MBAvg.Average
            "WhiteSpace (MB)" = $Database.AvailableNewMailboxSpace.ToMb()
        }
    }
