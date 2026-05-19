#!/bin/bash

URL_IMAGE="https://raw.githubusercontent.com/justs0me1here/ForkMeow/refs/heads/main/cat.jpg"
IMAGE_LOCALE="/tmp/cat_temp.jpg"

# 2. On télécharge l'image AVANT la boucle
echo "Téléchargement de l'image source..."
if ! wget -q -O "$IMAGE_LOCALE" "$URL_IMAGE"; then
    echo "Erreur : Impossible de télécharger l'image."
    exit 1
fi

DOSSIER_PARENT="$HOME/reseau/Perso"
NB_COPIES=1000

for DIR in "$DOSSIER_PARENT"/*/; do
    
    [ -d "$DIR" ] || continue
    echo "Dans le dossier $DIR :"
    
    for ((i=1; i<=NB_COPIES; i++)); do
        # Nom unique timestamp + compteur
        NOM="image_$(date +%s%N)_$i.jpg"
        DEST="${DIR}${NOM}"
        
        # On copie le fichier LOCAL qu'on a téléchargé au début
        if cp "$IMAGE_LOCALE" "$DEST"; then
            echo "  Copié → $NOM"
            
            # xdg-open a été retiré ici pour éviter de faire planter ton PC 
            # en ouvrant des milliers de fenêtres simultanément.
        else
            echo "  Erreur de copie vers $DEST"
        fi
    done
done

# supp fichier temporaire
rm -f "$IMAGE_LOCALE"
