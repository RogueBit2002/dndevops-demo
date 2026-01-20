targetScope = 'subscription'

param rgName string = 'dndevops-demo-rg'
param location string = 'westeurope'

@secure()
param adminPassword string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
}

module postgres './modules/postgres.bicep' = {
  name: 'postgresDeployment'
  scope: rg
  params: {
    postgresServerName: 'dndevops-demo-db'
    adminUsername: 'dndevops_service'
    adminPassword: adminPassword
  }
}
