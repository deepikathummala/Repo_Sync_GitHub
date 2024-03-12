name: Run ADO to GitHub Sync with PowerShell

on:
#Which is a manual invocation
  workflow_dispatch:
jobs:
  build:
    runs-on: windows-latest
    steps:
     - name: Check out Repo
       uses: actions/checkout@v2
     - run:
         ./SynADOtoGitHub.ps1 -GitHubDestinationPAT ${{ secrets.GITHUBDESTINATIONPAT }} -ADOSourcePAT ${{secrets.ADOSOURCEPAT}}
