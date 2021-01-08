#!/bin/bash
#Generate Open Graph image (og:image) from text content. 
# (C) Alexandr Pavlov  <alexandr@asustem.ru>, 2021
# https://github.com/Zoviet/bashblog/
# Full version: generate from html with xslt and from url - https://github.com/Zoviet/ogg/


#Default dimension of the og:image.  

og_width=968; #default width of the og:image in px. Facebook recommended 1200px min.
og_height=504; #default height of the og:image in px. Facebook recommended 630px min.
bg=white; #default background color of the og:image

mds=($(find . -maxdepth 1 -name '*.md'))
for md in ${mds[@]};do 
	title="$(head -1 < $md)";
	#text=$(cat $md);
	echo $title;
	title=$(echo "$text" | head -1);
	except=$(echo "$text" | sed '1d');
	name=$(echo "$md" | sed -e 's/\.md//g' -e 's/\.\///g');
	if [ -n ./ogg/$name'.png' ] ||  [ "$1" -eq "rebuild" ]  
	then
	echo $name;
		left=$(( $og_width/10 ));
		top=$(( $og_height/15 ));
		fontsize=$(( 12+$og_width/72 ));
		linesize=$(( ($og_width -2*$left)*3/$fontsize ));		
		texter=$(echo "$text" | fold -s --width="$linesize"); 
		convert -size "$og_width"x"$og_height" canvas:"$bg" ./ogg/"$name".png;
		convert ./ogg/"$name".png -gravity NorthWest -pointsize "$fontsize" -annotate +"$left"+"$top" "$texter" ./ogg/"$name".png;
		if [[ $? != 0 ]]; then 
			echo 'Error image convert: '$name'.png';
		fi
	else
		echo 'найдена картинка'
	fi	
done	
