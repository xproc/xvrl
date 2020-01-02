#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo "Cannot publish pull requests."
    exit
fi

set | grep TRAVIS

if [ "$TRAVIS_REPO_SLUG" == "$GIT_PUB_REPO" ]; then
    echo "Preparing to publish..."
    cd $HOME
    git config --global user.email ${GIT_EMAIL}
    git config --global user.name ${GIT_NAME}

    if [ "$GH_TOKEN" != "" ]; then
        echo "Publishing..."

        git clone --quiet --branch=gh-pages \
            https://${GH_TOKEN}@github.com/${GIT_PUB_REPO} gh-pages > /dev/null

        TIP=${TRAVIS_TAG:="head"}

        # N.B. gh-pages here is updated by two different repositories.
        # Consequently, we don't try to remove the old files.
        # Occasional manual cleanup may be required.

        cd gh-pages
        mkdir -p ./${TRAVIS_BRANCH}/${TIP}
        cp -Rf $TRAVIS_BUILD_DIR/build/dist/* ./${TRAVIS_BRANCH}/${TIP}

        if [ "$GITHUB_CNAME" != "" ]; then
            echo $GITHUB_CNAME > CNAME
        fi

        git add --verbose -f .
        git commit -m "Successful travis build $TRAVIS_BUILD_NUMBER"
        echo NO ACTUAL PUSH
        #git push -fq origin gh-pages > /dev/null

        echo -e "Published specification to gh-pages.\n"
    else
        echo -e "Publication cannot be performed on pull requests.\n"
    fi
fi
