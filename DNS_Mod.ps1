#Alicia Yingling 2017.05.17 hbd
$targetDNS = '1.2.3.4' #DNS Server to modify in the DNS ENtries
$remove = $FALSE # $TRUE  #Default to add, Set to true in order to remove instead
$remove = $TRUE  

#Currently this modified only Adapters with DNS entries already. If there are none, they are skipped.
$adapters = Get-NetAdapter
$DNSes =  $adapters | Get-DnsClientServerAddress | Where-Object { $_.ServerAddresses -ne '',$new }

Write-Host " After DNS Change All Values "
Write-Host $DNSes
Write-Host 
if ( -Not $remove ) {
Write-Host " Adding $($targetDNS) " }
else {
Write-Host " Removing $($targetDNS) "}

ForEach ( $dns in $DNSes ) {
 $DNSlist = $dns.ServerAddresses 
 
 if ( -Not $remove ) {
    $DNSlist += $targetDNS }
 else {
    $DNSlist = $DNSList | Where-Object { $_ -ne $targetDNS } 
    }
 
 Set-DnsClientServerAddress -InterfaceIndex $dns.InterfaceIndex -ServerAddresses $DNSlist
}

Write-Host ""
Write-Host " After DNS Change All Values "
Write-Host ""
#Confirm Changes with Display of current state
Get-DnsClientServerAddress 

#Changes Shown
#Ending
