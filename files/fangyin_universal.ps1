$in = read-host "句子？"
$hanzi = $in -split ""
$lang = read-host "1:官話 2:晋語 3:呉語 4:贛語 5:湘語 6:閩語 7:粤語 8:平話 9:客語"
switch ($lang) {
    1 {$lgc = "gh"}
    2 {$lgc = "jy"}
    3 {$lgc = "wy"}
    4 {$lgc = "gy"}
    5 {$lgc = "xy"}
    6 {$lgc = "my"}
    7 {$lgc = "yy"}
    8 {$lgc = "ph"}
    9 {$lgc = "ky"}
    default {
        write-host "输入从1到9的半角数字"
        exit
    } 
}
$city = read-host "城市？"
$fayin = @();
for($j = 1; $j -lt $hanzi.length - 1; $j++) {
    try {
        $tar = $hanzi[$j]
        $url = "https://www.zdic.net/zd/yy/$lgc/$tar"
        $page = invoke-webrequest $url
        $tds = $page.parsedHTML.getElementsByTagName("td")
        $num = 0
        for($i = 0; $i -lt $tds.length; $i++){
            if($tds[$i].innerText -eq $city){$num=$i;$i=$tds.length}
        }
        if($num -eq 0) {
            $pron = '404'
        } else {
            $pron = $tds[$num+1].innerText + $tds[$num+2].innerText + $tds[$num+3].innerText + ' '
        }
    } catch {
        $pron = '404'
    }
$fayin += $pron
}
write-host $fayin