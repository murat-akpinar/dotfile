winget install JanDeDobbeleer.OhMyPosh -s winget
oh-my-posh init pwsh --config '~\Documents\WindowsPowerShell\mytheme.omp.json' | Invoke-Expression
Import-Module -Name Terminal-Icons

function ssh { 
    & "C:\Windows\System32\OpenSSH\ssh.exe" -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" $args 
}
