#!/bin/sh

# init amplify in flutter project
bash ./amplify_cicd_common.sh

# checkout amplify dev env
#amplify env checkout dev --restore
amplify env checkout devenv --restore
amplify status