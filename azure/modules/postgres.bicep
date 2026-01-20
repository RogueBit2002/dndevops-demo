param postgresServerName string
param adminUsername string

@secure()
param adminPassword string

resource postgres 'Microsoft.DBforPostgreSQL/flexibleServers@2025-08-01' = {
  location: 'francecentral'
  name: postgresServerName
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }
  properties: {
    createMode: 'Default'
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    version: '17'
    storage: {
      storageSizeGB: 32
    }

  }
}

resource firewallRules 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2025-08-01' = {
  parent: postgres
  name: 'AllowAll'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '255.255.255.255'
  }
}

resource disableSecureTransport 'Microsoft.DBforPostgreSQL/flexibleServers/configurations@2025-08-01' = {
  name: 'require_secure_transport'
  parent: postgres
  properties: {
    source: 'user-override'
    value: 'OFF'
  }
}
