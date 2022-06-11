#!/bin/sh
#

# One can add -d to delete files not in local but in bucket
gsutil rsync -R public gs://www.balaye.net
