#requires -Module AWSPowerShell

## Provide the root user access key and secret key to temporarily authenticate to create the IAM user
Set-AWSCredential -AccessKey '<root user access key>' -SecretKey '<root user secret key>'

## Create a no-frills IAM user
$iamUserName = 'TechSnips'
New-IAMUser -UserName $iamUserName

## Find the managed policy called AdministratorAccess' ARN that has access to all AWS services
$policyArn = (Get-IAMPolicies | where {$_.PolicyName -eq 'AdministratorAccess'}).Arn

## Attach the AdministratorAccess policy to the user we just created
Register-IAMUserPolicy -PolicyArn $policyArn -UserName AutomateBoringStuff

## Create a new IAM access and secret key for the user
$key = New-IAMAccessKey -UserName AutomateBoringStuff

## Authenticate to your AWS account using the newly created access key and secret access key. This time, storing it
## as the default keys so it will keep even across PowerShell sessions
Set-AWSCredential -AccessKey $key.AccessKeyId -SecretKey $key.SecretAccessKey -StoreAs 'Default'