function moisfr(){
    $today = Get-Date
    $year = $today.Year
    $month = $today.Month
    if ($month -ge 1 -and $month -le 3)     { $range = "janvier - mars" }
    elseif ($month -ge 4 -and $month -le 6) { $range = "avril - juin" }
    elseif ($month -ge 7 -and $month -le 9) { $range = "juillet - septembre" }
    else                                    { $range = "octobre - décembre" }
    return "$range $year"
}

cd articles
$cnt = 0
$cnt = (dir).Count - 1
$cnt = $cnt.ToString("000")
AP
$lines = cat "$cnt.htm"
$linestr = $lines -join "`n"
$title = $linestr | parse 'h2'
$sub = $linestr | parse '.subtitle'
$lines | % {
    $_ -replace '\$ddd', "$cnt" -replace '\$title', "$title"
} | Set-Content "tmp.htm"
ren "$cnt.htm" "backup.htm"
ren "tmp.htm" "$cnt.htm"
cd ..
$file2 = cat "index.htm"
$file2str = $file2 -join "`n"
$uls = $file2str | parse 'ul', ([AngleParse.Attr]::OuterHtml)
$uls2 = $file2str | parse 'ul', ([AngleParse.Attr]::InnerHtml)
$h3s = $file2str | parse 'h3', ([AngleParse.Attr]::OuterHtml)
$moisfr = moisfr
$text = "<!DOCTYPE html>`n<html>`n`n<head>`n`t<meta lang='ja'>`n`t<meta charset='utf-8' />`n`t<!-- twitter card -->`n`t<meta name='twitter:card' content='summary' />`n`t<meta name='twitter:site' content='@notolytos' />`n`t<meta property='og:url' content='https://notolite.github.io/pensee/index.htm' />`n`t<meta property='og:title' content='les impressions et les expressions' />`n`t<meta property='og:description' content='notoliteが長い文章を書く場所' />`n`t<meta property='og:image' content='https://notolite.github.io/pensee/files/card.png' />`n`n`t<title>les impressions et les expressions</title>`n`t<link rel='icon' type='image/png' href='./files/favicon.png'>`n`t<meta name='viewport' content='width=device-width,initial-scale=1'>`n`t<link href='https://fonts.googleapis.com/css2?family=Lexend:wght@400;500;700&family=Noto+Sans+JP:wght@300;500;700&family=Noto+Sans+SC:wght@300&family=Zilla+Slab:wght@300&display=swap' rel='stylesheet'>`n`t<link rel='stylesheet' href='./css/entire.css'>`n`t<link rel='stylesheet' href='./css/index.css'>`n</head>`n`n<body>`n`t<header>`n`t`t<h1>les&#160;impressions et les&#160;expressions</h1>`n`t</header>`n`n`t<article>"
if($sub -ne ""){
    $pipe = " — "
}
if ($h3s[0] -eq "<h3>$moisfr</h3>") {
    $uls[0] = @("<ul>`n`t`t`t<li><a href='./articles/$cnt.htm'>$sub$pipe$title</a></li>") + $uls2[0] + "</ul>"
} else {
    $h3s = @("<h3>$moisfr</h3>") + $h3s
    $uls = @("<ul>`n`t<li><a href='./articles/$cnt.htm'>$sub$pipe$title</a></li>`n</ul>") + $uls
}
for ($i = 0; $i -lt $h3s.Count; $i++) {
    $text = $text + "`n`t`t" + $h3s[$i] + "`n`t`t" + $uls[$i]
}
$text = $text + "`t</article>`n`t<div id='clock'>`n`t`t<div class='base'></div>`n`t`t<div class='num one'>1</div>`n`t`t<div class='num two'>2</div>`n`t`t<div class='num three'>3</div>`n`t`t<div class='num four'>4</div>`n`t`t<div class='num five'>5</div>`n`t`t<div class='num six'>6</div>`n`t`t<div class='num seven'>7</div>`n`t`t<div class='num eight'>8</div>`n`t`t<div class='num nine'>9</div>`n`t`t<div class='num ten'>10</div>`n`t`t<div class='num eleven'>11</div>`n`t`t<div class='num twelve'>12</div>`n`t`t<div class='hand' id='sec'></div>`n`t`t<div class='hand' id='min'></div>`n`t`t<div class='hand' id='hour'></div>`n`t`t<div class='point'></div>`n`t`t<div class='name'>LE TEMPS ACTUEL</div>`n`t</div>`n`t<footer>`n`t`t<p>écrit par notolyte (<a target='_blank' href='https://twitter.com/notolitos'>Twitter</a>)</p>`n`t`t<p>distribué par GitHub Pages</p>`n`t</footer>`n`t<a href='./../notolite.github.io/index.htm'>`n`t`t<div id='returnkey'>`n`t`t`t<div></div>`n`t`t`t<p>RETOURNER</p>`n`t`t</div>`n`t</a>`n`t<script>`n`t`t// clock`n`t`tlet hour, min, sec;`n`t`twindow.onload = () => {`n`t`t`twindow.setInterval(redraw, 1000);`n`t`t}`n`t`tlet redraw = function () {`n`t`t`thour = new Date().getHours();`n`t`t`tmin = new Date().getMinutes();`n`t`t`tsec = new Date().getSeconds();`n`t`t`tdocument.getElementById('hour').style.transform = 'rotate(-' + ((60 * hour) + min) * 0.5 + 'deg)';`n`t`t`tdocument.getElementById('min').style.transform = 'rotate(-' + 6 * min + 'deg)';`n`t`t`tdocument.getElementById('sec').style.transform = 'rotate(-' + 6 * sec + 'deg)';`n`t`t}`n`t</script>`n</body>`n`n</html>"
"$text" > "./trial.htm"
echo "Check the content below and type yes if it's OK"
cat ".\trial.htm"
cat ".\articles\$cnt.htm"
$bol = Read-Host "Is it OK? [y/n]"
if ($bol.ToLower() -eq 'y') {
    del ".\articles\backup.htm"
    del index.htm
    ren trial.htm index.htm
    git add *
    git commit -m "new post"
    git push origin main
} else {
    pause
}
