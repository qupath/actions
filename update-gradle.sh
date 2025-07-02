DIR=../

pushd $DIR
for REPO in qupath-extension-instanseg c-blosc-jars extension-manager javadoc-viewer log-viewer openslide-jars script-editor qupath qupath-fxtras qupath-gradle-scripting-project qupath-gradle-plugin qupath-bioimageio-spec qupath-extension-appose qupath-extension-align qupath-extension-djl qupath-extension-jpen qupath-extension-liverquant qupath-extension-omero qupath-extension-py4j qupath-extension-stitching qupath-extension-snapshots qupath-extension-stardist qupath-extension-template qupath-extension-training qupath-extension-wsinfer qupath-extension-scripting; do
    if [ -d "$REPO" ]; then
      echo "$REPO already exists"
      # git remote show "${1:-origin}" | sed -n '/HEAD branch/s/.*: //p' | xargs git checkout
    else
      echo "$REPO doesn't exist, cloning"
      git clone git@github.com:qupath/$REPO.git
    fi
    gh workflow run update-gradle.yml
done

popd
