for file in articles/*; do
		sed -i 's|<p>écrit par notolite (<a target="_blank" href="https://misskey.io/@notolyte">fediverse</a>)</p>|<p>écrit par notolite</p>|g' $file
        sed -i 's|<p>distribué par GitHub Pages</p>|<p>distribué par Nginx sur Raspberry Pi Zero</p>|g' $file
done
sed -i 's|<article>|<article>\n\t\t<p class="introduction">This is a self-hosted version of <a href="https://notolite.github.io/pensee">notolite.net/pensee</a>. This copy is experimental and is intended to satisfy the author'\''s curiosity, rather than to maintain stably for good. The author recommends rather to link to the original website hosted on GitHub pages.</p>|g' index.htm
sed -i 's|<link rel='\''stylesheet'\'' href='\''./css/index.css'\''>|<link rel="stylesheet" href='\''./css/index.css'\''>\n\t<style>\n\t.introduction \{width: calc(100vw - 30px); border-radius: 15px; background: #cfecec; color: #333; line-height: 1.7rem; padding: 15px; font-family: "Lexend", sans-serif;\}\n\t</style>|g' index.htm
