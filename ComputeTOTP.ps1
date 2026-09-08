Add-Type -Path .\Otp.Net.dll
$c=Read-Host;
$s=Read-Host;
$t = [OtpNet.Totp]::new([OtpNet.Base32Encoding]::ToBytes($s)).ComputeTotp();
Write-Host "Client: $c, Secret $s, TOTP $t" > $c
