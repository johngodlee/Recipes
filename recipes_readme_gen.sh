#!/bin/bash

rm index.md

dir_list=$(find . -type d -depth 1 | sed -e '/\.git/d' -e '/infographics_guides_books/d' | sed 's|^\./||')

for i in $dir_list; do
	dir_title=$(echo $i | sed 's/_/ /g' | sed 's/[[:space:]]*$//')	

	echo "- [$dir_title]($i/README.md)" >> index.md

	md_list=$(find $i/* -type f | sed '/README.md/d')

	for j in $md_list; do
		md_contents_title=$(head -n 1 $j | sed 's/# //g')

		echo "	* [$md_contents_title]($j)" >> index.md
	done
done

for i in $dir_list; do

	rm README.md

	for j in *.md; do
		md_contents_title=$(head -n 1 $j | sed 's/# //g')

		echo "[$md_contents_title]($j)" >> README.md

		echo "" >> README.md 
	done
done
