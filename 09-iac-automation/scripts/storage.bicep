// storage.bicep — declares a storage account as code
param location string = resourceGroup().location
param storagePrefix string = 'stiac'

// Generate a unique name from the prefix + a hash of the resource group ID
var storageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

resource sa 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountName string = sa.name