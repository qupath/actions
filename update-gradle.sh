#!/usr/bin/env bash


REPOS="qupath-extension-instanseg c-blosc-jars extension-manager javadoc-viewer log-viewer openslide-jars script-editor qupath qupath-fxtras qupath-gradle-scripting-project qupath-gradle-plugin qupath-bioimageio-spec qupath-extension-appose qupath-extension-align qupath-extension-djl qupath-extension-jpen qupath-extension-liverquant qupath-extension-omero qupath-extension-py4j qupath-extension-stitching qupath-extension-snapshots qupath-extension-stardist qupath-extension-template qupath-extension-training qupath-extension-wsinfer qupath-extension-scripting"
DIR=../

while getopts ':dr:h' opt; do
  case "$opt" in
    r)
      IFS=',' read -ra REPOS <<< "$OPTARG"
      ;;
    d)
      DIR="$OPTARG"
      ;;

    h)
      echo "Run gradle update for all listed repos"
      echo "Usage: $(basename $0) [-d DIR] [-r repo1,repo2,repo3]"
      exit 0
      ;;

    :)
      echo -e "option requires an argument.\nUsage: $(basename $0) [-d DIR] [-r repo1,repo2,repo3]"
      exit 1
      ;;

    ?)
      echo -e "Invalid command option.\nUsage: $(basename $0) [-d DIR] [-r repo1,repo2,repo3]"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"



pushd $DIR
for REPO in ${REPOS[@]}; do
    if [ -d "$REPO" ]; then
      echo "$REPO already exists"
    else
      echo "$REPO doesn't exist, cloning"
      git clone git@github.com:qupath/$REPO.git
    fi
    pushd "$REPO"
    gh workflow run update-gradle.yml
    popd
done

popd
