#!/bin/sh

# install amplify cli
npm install -g @aws-amplify/cli@8.3.1 --unsafe-perm=true

# go to the project dir $BITRISE_SOURCE_DIR which is '/Users/vagrant/git/' by default already
#cd /Users/vagrant/git/

# setup amplify config
FLUTTERCONFIG="{\
\"ResDir\":\"./lib/\"\
}"

AWSCLOUDFORMATIONCONFIG="{\
\"configLevel\":\"project\",\
\"useProfile\":false,\
\"profileName\":\"default\",\
\"accessKeyId\":\"$AWS_ACCESS_KEY\",\
\"secretAccessKey\":\"$AWS_SECRET_KEY\",\
\"region\":\"$AWS_REGION\"\
}"

AMPLIFY="{\
\"projectName\":\"$AMPLIFY_PROJECT_NAME\",\
\"appId\":\"$AMPLIFY_PROJECT_APP_ID\",\
\"envName\":\"$AMPLIFY_PROJECT_ENV\",\
\"defaultEditor\":\"code\"\
}"

FRONTEND="{\
\"frontend\":\"flutter\",\
\"config\":$FLUTTERCONFIG\
}"

PROVIDERS="{\
\"awscloudformation\":$AWSCLOUDFORMATIONCONFIG\
}"

# init amplify in the Flutter project
amplify init \
--amplify $AMPLIFY \
--frontend $FRONTEND \
--providers $PROVIDERS \
--yes