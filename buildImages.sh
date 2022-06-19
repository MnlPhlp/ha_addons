# /bin/bash

for dir in ./*/     # list directories in the form "/tmp/dirname/"
do
    tag=$(echo $dir | awk '{ print substr ($0, 3, length($0)-3 ) }')
    version=$(yq ".version" $dir/config.yaml)
    oldVersion=$(curl -s https://registry.hub.docker.com/v1/repositories/mnlphlp/ha-$tag/tags | tr -d '\n'   | awk -F: '{print substr( $NF, 3, length($NF)-5) }')
    echo ""
    echo "############################"
    echo "## dir:         $dir"
    echo "## tag:         $tag"
    echo "## version:     $version"
    echo "## old version: $oldVersion"
    echo "############################"
    # build if version changed
    if [ $version == $oldVersion ]; then
        echo "version of $tag did not change"
    else
        echo "version of $tag changed from $oldVersion to $version"
        echo "creating new docker image"
        docker buildx build --platform=linux/amd64,linux/arm64 -t mnlphlp/ha-$tag:$version $dir --push
    fi
done
