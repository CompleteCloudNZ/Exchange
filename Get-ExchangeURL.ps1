add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010

$hn = [System.Net.Dns]::GetHostName()

$autodiscover = Get-AutodiscoverVirtualDirectory -Server $hn
$cas = get-ClientAccessServer -Identity $hn
$ews = get-webservicesvirtualdirectory  -Server $hn
$oab = get-oabvirtualdirectory -Server $hn
$owa = get-owavirtualdirectory -Server $hn
$ecp = get-ecpvirtualdirectory -Server $hn
$activesync = get-ActiveSyncVirtualDirectory -Server $hn

$autodiscover |Select Name,InternalAuthenticationMethods,ExternalAuthenticationMethods,BasicAuthentication,DigestAuthentication,WindowsAuthentication,Path,Server,InternalURL,ExternalURL,Identity |Export-Csv autodiscover.csv
$cas | Select Name,OutlookAnywhereEnabled,AutoDiscoverServiceInternalUri,AutoDiscoverSiteScope |Export-Csv oa.csv
$ews | Select Name,InternalNLBBypassUrl,MRSProxyEnabled,MRSProxyMaxConnections,InternalAuthenticationMethods,ExternalAuthenticationMethods,BasicAuthentication,DigestAuthentication,WindowsAuthentication,Path,InternalURL,ExternalURL,Identity  |Export-Csv ews.csv
$oab | Select Name,PollInterval,RequireSSL,InternalAuthenticationMethods,ExternalAuthenticationMethods,BasicAuthentication,DigestAuthentication,WindowsAuthentication,Path,InternalURL,ExternalURL,Identity  |Export-Csv oab.csv
$owa | Select Name,InternalAuthenticationMethods,ExternalAuthenticationMethods,BasicAuthentication,DigestAuthentication,WindowsAuthentication,Path,InternalURL,ExternalURL,Identity |Export-Csv owa.csv
$ecp | Select Name,InternalAuthenticationMethods,ExternalAuthenticationMethods,BasicAuthentication,DigestAuthentication,WindowsAuthentication,Path,InternalURL,ExternalURL,Identity  |Export-Csv ecp.csv
$activesync | Select ActiveSyncServer,RemoteDocumentsActionForUnknownServers,BasicAuthEnabled,WindowsAuthEnabled,CompressionEnabled,ClientCertAuth,WebsiteName,WebSiteSSLEnabled,VirtualDirectoryName,InternalUrl,InternalAuthenticationMethods,ExternalUrl,ExternalAuthenticationMethods,Identity  |Export-Csv activesync.csv