param(
    [string]$ScriptPath,
    [string]$ApimJsonFileName,
    [string]$ApimPolicyFileName,
    [string]$AzureResourceGroupName,
    [string]$AzureServiceName,
    [string]$ApimApiPath,
    [string]$ApimApiName,
    [string]$ApimApiServiceUrl,
    [string[]]$Policy_OperationNamesList,
    [string]$Environment,
    [string]$ProductId

)

Get-AzSubscription

Write-Host "APIM service deployment started.."

$context = New-AzApiManagementContext -ResourceGroupName $AzureResourceGroupName -ServiceName $AzureServiceName

Write-Host "Importing APIM JSON file"

$ApimJsonFilePath="$ScriptPath\APIs\$ApimJsonFileName"
$ApimPolicyFilePath="$ScriptPath\Policy\API_Policy\$ApimPolicyFileName"

Write-Host "Apim Json File Path $ApimJsonFilePath"
Write-Host "Apim Policy File path $ApimPolicyFilePath"


Import-AzApiManagementApi -Context $context -SpecificationPath "$ApimJsonFilePath" -SpecificationFormat "OpenApi" -Path $ApimApiPath -ApiId $ApimApiName -ServiceUrl $ApimApiServiceUrl

Write-Host "Imported APIM JSON file successfully"


if (-not ([string]::IsNullOrEmpty($ApimPolicyFileName)))
{
    Write-Host "Applying policy : $ApimApiName"
    Set-AzApiManagementPolicy -Context $context -PolicyFilePath  "$ApimPolicyFilePath" -ApiId $ApimApiName
    Write-Host "Policy applied successfully."
}
else
{
    Write-Host "Skipping policy, value of ApplyPocicy found  : $ApplyPocicy"
}

if ($Policy_OperationNamesList -ne 0)
{
    Write-Host "operationFilePath $operationFilePath"
    Write-Host "Setting up operation level policy .."
    foreach ($operationName in $Policy_OperationNamesList)
    {
        $operationFilePath="$ScriptPath\Policy\Operation_Policy\$operationName`_$Environment.xml"
        Set-AzApiManagementPolicy -Context $context -PolicyFilePath "$operationFilePath" -ApiId $ApimApiName -OperationId $operationName
    }
}
else
{
    Write-Host "Skipping operation level policy, count of Policy_OperationNamesList found 0"
}

Write-Host "Adding Product to APIM product id  $ProductId"
Add-AzApiManagementApiToProduct -Context $context -ProductId $ProductId -ApiId $ApimApiName



#$PropertiesObject = @{
#    displayName = "Grand Central"
#}
#New-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $AzureResourceGroupName -ResourceType Microsoft.ApiManagement/service/tags -ResourceName "<API-Management-service-name>/$ResourceName" -ApiVersion 2018-01-01 -Force

#Set-AzResource -PropertyObject $PropertiesObject  -ResourceType Microsoft.ApiManagement/service/tags -ResourceGroupName $AzureResourceGroupName -ResourceName $AzureServiceName/$ApimApiName -Force
