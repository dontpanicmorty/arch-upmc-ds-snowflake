Quick one-off script to check the contents of HealthSparq's Google Cloud bucket, since NiFi's `ListGCSBucket` processor doesn't really work.

Copy `/mnt1/nifi/nifi-current/conf/healthsparq_gcp_creds.json` off one of the NiFi machines and put it as the same file in this directory, `index.js` should pick it up.

This is mostly getting committed so that whoever works on the Azure Functions re-implementation of the NiFi stuff knows how the auth process works in JavaScript.
