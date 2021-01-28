# Azure API management services pipeline
Azure APIM Deployment using azure pipeline 
1.1	Pre-requisite item needed to build the pipeline
1.1.1	Azure pipeline task
Azure pipeline task is use to build the logic to deploy the azure API management service automatically though azure pipeline.
We are using Azure PowerShell Script task

 

This tasks need the below mandatory details, 
a.	Display name : User define name of the task.
b.	Azure Subscription: Azure Resource Manager subscription to configure before running PowerShell
c.	PowerShell script: 
 

1.1.2	APIM swagger JSON file
This JSON file is just a metadata for the APIM API’s. 
1.1.3	APIM API global policy xml file
This XML file contain the policy details like Ip filter, Cors etc.

1.1.4	PowerShell Script
The PowerShell script created with the following commands, 

a.	New-AzApiManagementContext
b.	Import-AzApiManagementApi  
c.	Set-AzApiManagementPolicy  
This pipeline satisfy flowing general scenarios, 
1.2	Pipeline Variable details 
If the APIM API is not exist and you want to create new APIM API  you need to provide valid variable value,

a.	ApimAPIName: An user defined unique name.
b.	IsPolicyUpdateEveryRelease: The value of this variable would be either yes/no. If the value will “no” then policy will not applied to the APIM API.
c.	ApimAPIPath: Unique API path ex : DevEnv, TestEnv, etc
d.	ApimApiServiceUrl : Internal service url for Azure app services
e.	ApinJsonFileName: name of the swagger JSON file.
f.	ApimPolicyFileName: Name of the policy XML file.
 


1.3	How to use the pipeline?

1.3.1	Create new APIM API
1.3.1.1	Create swagger JSON file
1.3.1.2	Create XML policy file
1.3.1.3	Commit the changes in the branch
1.3.1.4	Run the  build pipeline gc_dynamics_api
1.3.1.5	Run the release pipeline to release the changes – This is automatically triggers.

1.3.2	Update Existing APIM (Add new operation)
1.3.2.1	Update swagger JSON file (Add new operation in the file)
1.3.2.2	Update XML policy file (Add new policy in the file)
1.3.2.3	Commit the changes in the branch
1.3.2.4	Run the  build pipeline gc_dynamics_api
1.3.2.5	Run the release pipeline to release the changes – This is automatically triggers.

1.3.3	Update Existing APIM (Remove existing operation)
1.3.3.1	Update swagger JSON file (Remove new operation in the file)
1.3.3.2	Update XML policy file (Remove new policy in the file)
1.3.3.3	Commit the changes in the branch
1.3.3.4	Run the  build pipeline gc_dynamics_api
1.3.3.5	Run the release pipeline to release the changes – This is automatically triggers.




