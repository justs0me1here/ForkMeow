#!/bin/bash


IMAGE_SOURCE="$HOME/reseau/Perso/Documents/Grr/cat.jpg"


DOSSIER_PARENT="$HOME/reseau/Perso"


NB_COPIES=1000

for DIR in "$DOSSIER_PARENT"/*/; do

 [ -d "$DIR" ] || continue
 echo "Dans le dossier $DIR :"
 
 for ((i=1; i<=NB_COPIES; i++)); do
 
  # nom unique timestamp + compteur
  NOM="image_$(date +%s%N)_$i.jpg"
  DEST="${DIR}${NOM}"
  
  # copier l'image
  if cp "$IMAGE_SOURCE" "$DEST"; then
   echo "  Copié → $NOM"
   
   xdg-open "$DEST" >/dev/null 2>&1 &
   
  else
   echo "  Erreur de copie vers $DEST"
  fi
 done
done
