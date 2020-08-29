#!/bin/bash

echo "Executant-se a $(pwd)"
read -p "Executar realment els canvis (s/n)? " pregunta

if [ "$pregunta" = "s" ]
then
    echo "s'executaran els canvis!"
else
    echo "NO s'executaran els canvis, només es llistarà el que es faria"
fi
read -p "Prem Enter per continuar..."

for filenamesencer in *.svg
do
    echo "Processant $filenamesencer"
    filename_no_ext="${filenamesencer%.*}"
    echo "Nom d'arxiu sense extensió: $filename_no_ext"
    filename_png="$filename_no_ext.png"
    if [ -e "$filename_png" ]
    then
        echo "S'ha trobat que coincideixen $filenamesencer i $filename_png"
        echo
        echo "Operació: esborrar SVG:"
        echo "rm $filenamesencer"
        if [ "$pregunta" = "s" ]
        then
            rm "$filenamesencer"
            echo "rm fet"
        fi
    else
        echo "***** No hi ha el corresponent png, per tant el deixem!"
    fi
    echo
    echo
    echo
    
done
