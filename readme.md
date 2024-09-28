##User case: Our working Lambda function start erroing out.

##Reason:
The setting in AWS serverless lambda about the run time was set to Automatic. So, my Lambda run time for nodejs changed to v28. You can see the run time in your log in Cloudwatch at the top of the log group.

###Temp. Fix:
Manually update the run time back to v26 by coping the runtime id from a working log and made the runtime update to manual.

###Actual Fix:
Fixing run time version could create an issue in future Instead of that It would ber better to create a Lambda layer of chromuim binary and Use it to trigger playwright.

#overview:

-> Create AWS lambda layer of chromium.
-> Use this chromium in your playwright lambda test.

This Repo Will Help You TO Create AWS lambda layer of chromium.

I was not able to upload File Directly To The Lambda Layer so, I Use S3 Bucket as a middleware.

###Architecture:

```plaintext {"id":"01J8X0EESVSJM7SDZGQ8QPYF1J"}
Install "@sparticuz/chromium" and "playwright-core" dependencies.\
Zip the node_modules into chromium.zip\
Create aws_s3_bucket_object resource using terraform.\
Upload zip file in s3 bucket.\
Create aws_lambda_layer and point it to aws_s3_bucket_object.\
```

Follow instruction of package.sh file

# For Windows

-> Zip file in CMD

```text {"id":"01J8WWZ654G6ZT5T80FKZNY70Z"}
Compress-Archive ./nodejs ../dist/chromium.zip
```