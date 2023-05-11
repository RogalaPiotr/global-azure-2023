$studentprefix ="XXX"
$resourcegroupName = "fabmedical-rg-" + $studentprefix

[string]$id = $(az group show `
    --name $resourcegroupName `
    --query id)

az ad sp create-for-rbac `
    --name "fabmedical-$studentprefix" `
    --sdk-auth `
    --role contributor `
    --scopes '<ADD VALUE from $id>' # copy/paste value from $id and to scope
                                    # here is issue in powershell / cli variable becauseaz group show returning in 'id'