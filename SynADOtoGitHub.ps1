param(
    [Parameter()]
    [string]$GitHubDestinationPAT

    [Parameter()]
    [string]$ADOSourcePAT
)
#write powershell script
Write-Host 'Sync Azure Devops Repo changes in GitHub'
$AzureRepoName = "Repo_Sync_GitHub"
$ADOCloneURL = "dev.azure.com/DeepikaThummala01/Repo_Sync_GitHub/_git/Repo_Sync_GitHub"
$GitHubCloneURL = "https://github.com/deepikathummala/GitHub_Repo.git"
$stageDir = pwd | Split-Path
Write-Host "Stage Dir : $statgeDir"
$githubDir = $stageDir +"\"+"gitHub"
Write-Host "gitHub Dir : $gitHubDir"
$destination = $gitHubDir+"/"+ $AzureRepoName+".git"
Write-Host "destination: $destination"
$sourceURL = "https://" + $($GitHubDestinationPAT) + "@"+"$($GitHubCloneURL)"
Write-Host "dest URL : $destURL"
#check if the parent directory exists and delete
if((Test-Path -path $gitHubDir))
{
    Remove-Item -Path $gitHubDir -Recurse -force
}
if(!(Test-Path -path $gitHubDir))
{
    New-Item -ItemType directory -Path $gitHubDir
    Set-Location $githubDir
    git clone --mirror $sourceURL
}
else
{
    write-Host "The given folder path $gitHubDir already exists";
}
Set-Location $destination
Write-Output 'Git removing remote secondary'
git remote rm secondary
write-Output 'Git Remote add'
git remote add --mirror=fetch secondary $destURL
Write-Output 'Git fetch origin'
git fetch $sourceURL
Write-Output "git push secondary"
#git remote set url origin $destURL
set-Location $stageDir
if((Test-Path -path $gitHubDir))
{
    Remove-Item -Path $gitHubDir -Recurse -force
}
Write-Host "Job Completed"