#!/bin/sh

#  DownloadCA.sh
#  
#
#  Created by bgctester on 05/03/2019.
#

curl -O ${UNITY_LICENSE}
mkdir ~/Library/Unity/Certificates
mv CACerts.pem ~/Library/Unity/Certificates
