for file in articles/*; do
		sed -i 's|<p>écrit par notolite (<a target="_blank" href="https://misskey.io/@notolyte">fediverse</a>)</p>|<p>écrit par notolite</p>|g' $file
        sed -i 's|<p>distribué par GitHub Pages</p>|<p>distribué par Nginx sur Raspberry Pi Zero</p>|g' $file
done
sed -i 's|<p>écrit par notolite (<a target="_blank" href="https://misskey.io/@notolyte">fediverse</a>)</p>|<p>écrit par notolite</p>|g' index.htm
sed -i 's|<p>distribué par GitHub Pages</p>|<p>distribué par Nginx sur Raspberry Pi Zero</p>|g' index.htm
sed -i 's|<article>|<article>\n\t\t<p class="introduction">This is a self-hosted mirror of the author'\''s Github Pages website. This copy is experimental and is intended to satisfy the author'\''s curiosity, rather than to maintain stably for good. The author recommends rather to link to the original website hosted on GitHub pages.</p>|g' index.htm
sed -i 's|<link rel='\''stylesheet'\'' href='\''./css/index.css'\''>|<link rel="stylesheet" href='\''./css/index.css'\''>\n\t<style>\n\t.introduction \{width: calc(100% - 30px); border-radius: 15px; background: #cfecec; color: #333; line-height: 1.7rem; padding: 15px; text-align: left; font-family: "Lexend", sans-serif;\}\n\t</style>|g' index.htm
sed -i 's|\t<a href='\''./../notolite.github.io/index.htm'\''>\n\t\t<div id='\''returnkey'\''>\n\t\t\t<div></div>\n\t\t\t<p>RETOURNER</p>\n\t\t</div>\n\t</a>||g' index.htm

cp index.htm index.html
