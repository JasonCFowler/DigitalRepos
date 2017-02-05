#! /bin/bash
# Usage: package the files for Islandora
# Steps to use:

#Go to correct directory
cd ~/DigitalRepos

# Unzip zip files
unzip "*.zip"
mv *.zip zips

# Convert ProQuest XML files to MODS
for file in *.xml; do 
	newfile=$(echo "$file" | sed "s/_DATA//g")
#	xsltproc proquest-to-mods.xsl  $file > "$newfile"
	java -cp saxon9he.jar net.sf.saxon.Transform -s:$file -xsl:proquest-to-mods.xsl -o:$newfile

done

#Remove ProQuest XML files
rm -f *_DATA.xml

# Package Zip files
filename=$(date +%Y%m%d%H%M%S)
mkdir "$filename"
mv *.xml "$filename"
mv *.pdf "$filename"
zip "$filename.zip" $filename/*

echo "The script was successful"
exit 0
	
