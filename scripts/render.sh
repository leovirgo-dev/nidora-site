#!/bin/sh
# Rend les deux documents légaux depuis nidora-app/docs/legal/ en HTML publiables.
# Le bloc titre de pandoc est retiré : il dupliquait le H1 du document à l'écran.
set -e
cd "$(dirname "$0")/.."
SRC="${NIDORA_APP:-/Users/allanstepczynski/projects/nidora/nidora-app}"
for doc in confidentialite conditions; do
  case $doc in
    confidentialite) T="Politique de confidentialité — Nidora" ;;
    conditions)      T="Conditions générales d'utilisation — Nidora" ;;
  esac
  pandoc -f gfm -t html5 -s -c style.css --metadata lang=fr --metadata title="$T" \
    -o "$doc.html" "$SRC/docs/legal/$doc.md"
done
# Le template pandoc rend le titre en corps de page : il double le H1.
sed -i '' '/<header id="title-block-header">/,/<\/header>/d' confidentialite.html conditions.html
echo "rendu OK — vérifier avant push : curl -sI https://nidora.lv-dev.eu/confidentialite"
