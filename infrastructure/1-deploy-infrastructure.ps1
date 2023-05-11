$studentprefix = "pr"
$resourcegroupName = "fabmedical-rg-" + $studentprefix
$cosmosDBName = "fabmedical-cdb-" + $studentprefix
$webappName = "fabmedical-web-" + $studentprefix
$planName = "fabmedical-plan-" + $studentprefix
$location1 = "westeurope"

# Create resource group
az group create `
    --location $location1 `
    --name $resourcegroupName

# Create Azure Cosmos DB database
az cosmosdb create `
    --name $cosmosDBName `
    --resource-group $resourcegroupName `
    --locations regionName=$location1 failoverPriority=0 isZoneRedundant=False `
    --kind MongoDB

# Create Azure App Service Plan
az appservice plan create `
    --name $planName `
    --resource-group $resourcegroupName `
    --sku P1V2 `
    --is-linux

# Create Azure Web App with NGINX container
az webapp create `
    --resource-group $resourcegroupName `
    --plan $planName `
    --name $webappName `
    --deployment-container-image-name nginx

# Fetch Azure Cosmos DB Mongo connection string
$mongodbConnectionString = `
    $(az cosmosdb keys list `
        --name $cosmosDBName `
        --resource-group $resourcegroupName `
        --type connection-strings `
        --query 'connectionStrings[0].connectionString')