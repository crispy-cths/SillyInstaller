if (Test-Path  "$HOME\scoop") {
    Write-Output "Scoop is already installed."
} else {
    Write-Output "Installing scoop."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser 
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    Write-Output "Scoop is now installed."
}

$response = Read-Host "Do you want to install all of the bullshit on this pc? (y/n)"
if ($response -eq "y") {
    scoop install git
    if (Test-Path "$HOME\windots") {
        Write-Output "Ashish Windots already downloaded"
    } else {    
        git clone https://github.com/ashish0kumar/windots.git "$HOME\windots"
    }
    scoop install btop
    scoop install fastfetch
    fastfetch --gen-config
    scoop bucket add extras
    scoop bucket add nonportable
    scoop install files-np
    scoop install Terminal-Icons
    scoop install windhawk
    scoop install glazewm
    scoop install altsnap
    scoop install flow-launcher
    scoop install translucenttb
    scoop bucket add nerd-fonts
    scoop install JetBrainsMono-NF
    winget install Microsoft.WindowsTerminal
    winget install JanDeDobbeleer.OhMyPosh -s winget

    mkdir "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
    mkdir "$HOME\windots\.config\.glaze-wm\config.yaml" "$HOME\.glzr\glazewm\"
    cp "$HOME\windots\.config\.glaze-wm\config.yaml" "$HOME\.glzr\glazewm\config.yaml" -Force
    mkdir "$HOME\windots\.config\fastfetch\config.jsonc" "$HOME\.config\fastfetch\"
    cp "$HOME\windots\.config\fastfetch\config.jsonc" "$HOME\.config\fastfetch\config.jsonc" -Force
    mkdir "$HOME\windots\.config\fastfetch\cat.txt" "$HOME\.config\fastfetch\cat.txt"
    cp "$HOME\windots\.config\fastfetch\cat.txt" "$HOME\.config\fastfetch\cat.txt" -Force
    mkdir "$HOME\windots\.config\ohmyposh\zen.toml" "$HOME\.config\ohmyposh\zen.toml"
    cp "$HOME\windots\.config\ohmyposh\zen.toml" "$HOME\.config\ohmyposh\zen.toml" -Force
    mkdir "$HOME\scoop\apps\flow-launcher\current\app-1.19.4\UserData\Settings"
    mkdir "$HOME\AppData\Roaming\FlowLauncher\Themes"
    cp "$HOME\windots\.config\flowlauncher\Settings.json" "$HOME\scoop\apps\flow-launcher\current\app-1.19.4\UserData\Settings" -Force
    cp "$HOME\windots\.config\WindowsPowershell\Microsoft.Powershell_profile.ps1" $PROFILE -Force
    
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/crispy-cths/ShitInstaller/main/Microsoft.PowerShell_profile.ps1" -OutFile "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
    Invoke-WebRequest -Uri "https://github.com/crispy-cths/ShitInstaller/blob/main/settings.json" -OutFile "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    Invoke-WebRequest -Uri "https://github.com/catppuccin/flow-launcher/blob/main/themes/Catppuccin%20Mocha.xaml" -OutFile "$HOME\AppData\Roaming\FlowLauncher\Themes"
    cp "$HOME\windots\"


    #I love chatgpt code :3
    # Define the path to the JSON file
    $jsonFile = "$HOME\.config\fastfetch\config.jsonc"

    # Ensure the JSON file exists
    if (Test-Path $jsonFile) {
        # Read the file content
        $content = Get-Content $jsonFile -Raw

        # Get the current user's folder dynamically
        $currentUserFolder = "$env:USERPROFILE"

        # Replace the hardcoded user path
        $updatedContent = $content -replace "C:/Users/ashis", $currentUserFolder -replace "\\", "/"

        # Write the updated content back to the file
        Set-Content $jsonFile $updatedContent

        Write-Output "Replaced user folder with the current user's folder in $jsonFile."
    } else {
        Write-Output "The JSON file does not exist: $jsonFile"
    }

}
