# /bin/bash

for dir in ./*/     # list directories in the form "/tmp/dirname/"
do
    tag="mnlphlp/ha-$(echo $dir | awk '{ print substr ($0, 3, length($0)-3 ) }')"
    version=$(yq --raw-output ".version" $dir/config.yaml)
    oldVersion=$(curl -s https://registry.hub.docker.com/v2/repositories/$tag/tags | jq --raw-output '.results[0].name')
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
        docker buildx build --platform=linux/amd64,linux/arm64 -t $tag:$version $dir --push
    fi
done
