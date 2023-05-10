$studentprefix ="pr"
$resourcegroupName = "fabmedical-rg-" + $studentprefix

[string]$id = $(az group show `
    --name $resourcegroupName `
    --query id)

az ad sp create-for-rbac `
    --name "fabmedical-$studentprefix" `
    --sdk-auth `
    --role contributor `
    --scopes $id

# copy/paste id to scope
