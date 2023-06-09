#!/bin/sh

# init amplify in flutter project
bash ./amplify_cicd_common.sh

# checkout amplify prod env
amplify env checkout prod --restore
amplify status