#!/bin/bash

# This script does the following, scanning all subdirs:
#   scan for all svgs
#       if there is a png with the same name, remove it
#   scan all icon_name-symbolic.svg
#       if there is no icon_name-symbolic.png
#           create one linking to the non-symbolic
#           remove the symbolic svg
#   It doesn't remove svg that don't have a corresponding png (these svgs are thre while the theme is not yet complete, so I can see I need to create an icon. Yes, it's ugly to publish a theme like that, sorry)

#   You can use it in "dry mode", where it prompts what it would do, but without actually doing it

showHelp () {
    
    echo "Usage: $(basename "$0") option"
    echo "It admits just one parameter. Options:"
    echo -e "\t --help: display help"
    echo -e "\t --dry-run: do not actually do the changes, just prompt them"
}

showErrorUsage () {
# shows an error message (paramter 1) and then calls showHelp
    echo $1
    showHelp
}



if [ $# -gt 1 ]
then
    showErrorUsage "Error: you can only enter one parameter"
    showHelp
    exit 1
fi

dryRun=false

case $1 in
    --help)
        showHelp
        exit 0
    ;;
    --dry-run)
        dryRun=true
    ;;
    *)
        showErrorUsage "Error: unknown parameter"
        showHelp
        exit 1
    ;;
esac
        
if [ ! dryRun -eq false ]
then
    read -p "Do you really want to remove the files and apply the changes (y/n)? " question
    
    if [ "$question" = "y" ]
    then
        echo "changes will be applied!"
    else
        echo "NO changes will by applied, running in dry mode"
        dryRun=true
    fi
fi
read -p "Press Enter to continue..."


# ------------------- To review below here, it's an old version!!!

echo "Script unfinished. Exiting"
exit 2


for filenamesencer in *symbolic.svg
do
    echo "Processant $filenamesencer"
    filename_no_ext="${filenamesencer%.*}"
    echo "Nom d'arxiu sense extensió: $filename_no_ext"
    filename_no_ext_no_symbolic="${filename_no_ext%-symbolic*}"
    if [ -e "$filename_no_ext_no_symbolic.png" ]
    then
        echo "Nom d'arxiu sense symbolic ni extensió: $filename_no_ext_no_symbolic"
        echo
        echo "Operació: esborrar SVG:"
        echo "rm $filenamesencer"
        if [ "$pregunta" = "s" ]
        then
            rm "$filenamesencer"
            echo "rm fet"
        fi
        echo "Operació: crear enllaç"
        echo "ln -s $filename_no_ext_no_symbolic.png $filename_no_ext.png"
        if [ "$pregunta" = "s" ]
        then
            ln -s "$filename_no_ext_no_symbolic.png" "$filename_no_ext.png"
            echo "ln fet"
        fi

    else
        echo "********* No hi ha el corresponent png no simbòlic! ***********"
    fi
    echo
    echo
    echo
    
done
