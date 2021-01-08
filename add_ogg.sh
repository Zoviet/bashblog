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
	except="$(sed '1d' < $md)";
	name=$(echo "$md" | sed -e 's/\.md//g' -e 's/\.\///g');
	if [ -n ./ogg/$name'.png' ] || [ "$1" -eq "rebuild" ]  
	then
		left=$(( $og_width/15 ));
		top=$(( $og_height/15 ));
		fontsize=$(( 12+$og_width/67 ));
		titlefontsize=$(( $fontsize*2 ));
		linesize=$(( ($og_width -2*$left)*4/$fontsize ));
		titlesize=$(( $linesize/2 ));		
		except=$(echo "$except" | fold -s --width="$linesize"); 
		title=$(echo "$title" | fold -s --width="$titlesize");
		extop=$(( $top*2+$titlefontsize*(1+((${#title}*2)/$titlesize)) ));
		convert -size "$og_width"x"$og_height" canvas:"$bg" -gravity NorthWest -pointsize "$titlefontsize" -annotate +"$left"+"$top" "$title" -pointsize "$fontsize" -annotate +"$left"+"$extop" "$except" ./ogg/"$name".png;
		if [[ $? != 0 ]]; then 
			echo 'Error image convert: '$name'.png';
		fi
	else
		echo 'найдена картинка'
	fi	
done	
