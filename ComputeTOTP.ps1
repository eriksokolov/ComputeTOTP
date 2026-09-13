$s="JBSWY3DPEHPK3PXP";
$a="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
$k=[byte[]]::new([math]::Floor(($s.Length*5)/8));
$b="";$s.ToCharArray()|%{$b+=[Convert]::ToString($a.IndexOf($_),2).PadLeft(5,'0')};
0..($k.Length-1)|%{$k[$_]=[Convert]::ToByte($b.Substring($_*8,8),2)};
$c=[BitConverter]::GetBytes([long]([math]::Floor([DateTimeOffset]::UtcNow.ToUnixTimeSeconds()/30)));
if([BitConverter]::IsLittleEndian){[array]::Reverse($c)};
$h=[Security.Cryptography.HMACSHA1]::new($k).ComputeHash($c);
$o=$h[-1]-band 15;
((($h[$o]-band 127)-shl 24)-bor(($h[$o+1]-band 255)-shl 16)-bor(($h[$o+2]-band 255)-shl 8)-bor($h[$o+3]-band 255))%1000000 -as [int] |
% ToString D6
