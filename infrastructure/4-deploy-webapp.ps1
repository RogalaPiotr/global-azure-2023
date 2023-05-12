$studentprefix = "XXX"
$githubAccount = "XXX"
$resourcegroupName = "fabmedical-rg-" + $studentprefix
$webappName = "fabmedical-web-" + $studentprefix

# cd ./infrastructure
# in terminal put PAT: $env:CR_PAT="YOUR_PAT"

# Deploy Azure Web App
az webapp config container set `
    --docker-registry-server-password $env:CR_PAT `
    --docker-registry-server-url https://ghcr.io `
    --docker-registry-server-user $githubAccount `
    --multicontainer-config-file ./../docker-compose.yml `
    --multicontainer-config-type COMPOSE `
    --name $webappName `
    --resource-group $resourcegroupName
