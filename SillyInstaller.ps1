
#Tests if scoop is installed, if not, it will install it.
if (Test-Path  "$HOME\scoop") {
    Write-Output "Scoop is already installed."
} else {
    Write-Output "Installing scoop."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser 
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    Write-Output "Scoop is now installed."
}

#Base stuff
scoop install git
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add nonportable
scoop install Terminal-Icons
scoop install JetBrainsMono-NF


function Show-InteractiveMenu {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$MenuItems
    )

    # Initialize selection state
    $selections = @{}
    $menuKeys = @($MenuItems.Keys)
    for ($i = 0; $i -lt $menuKeys.Length; $i++) {
        $selections[$i] = $false
    }

    $currentSelection = 0
    $key = $null

    while ($true) {
        Clear-Host
        Write-Host "====SillyInstaller===="
        Write-Host ""

        # Render menu items
        for ($i = 0; $i -lt $menuKeys.Length; $i++) {
            $itemName = $menuKeys[$i]
            $selected = $selections[$i]
            $marker = if ($selected) { "[X]" } else { "[ ]" }
            
            if ($i -eq $currentSelection) {
                Write-Host "> $marker $itemName" -ForegroundColor Cyan
            } else {
                Write-Host "  $marker $itemName"
            }
        }

        Write-Host ""
        Write-Host "Use Arrow Keys to Navigate, Space to Toggle, Enter to Confirm"

        # Capture keypress
        $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode

        switch ($key) {
            # Up Arrow
            38 { 
                $currentSelection = if ($menuKeys.Length -gt 0) { 
                    ($currentSelection - 1 + $menuKeys.Length) % $menuKeys.Length 
                } else { 0 }
            }
            # Down Arrow
            40 { 
                $currentSelection = if ($menuKeys.Length -gt 0) { 
                    ($currentSelection + 1) % $menuKeys.Length 
                } else { 0 }
            }
            # Space Bar
            32 { 
                $selections[$currentSelection] = -not $selections[$currentSelection] 
            }
            # Enter
            13 { 
                break 
            }
        }

        if ($key -eq 13) { break }
    }

    # Execute actions for selected items
    Write-Host "`nExecuting Selected Actions:"
    for ($i = 0; $i -lt $menuKeys.Length; $i++) {
        if ($selections[$i]) {
            $itemName = $menuKeys[$i]
            $action = $MenuItems[$itemName]
            Write-Host "Installing $itemName..."
            
            try {
                # Execute the specific action for the selected item
                & $action
                Write-Host "$itemName installation complete." -ForegroundColor Green
            }
            catch {
                Write-Host "Error installing $itemName $($_.Exception.Message)" -ForegroundColor Red
            }
        }
    }
}

# Define menu items with their corresponding installation commands
$menuConfig = @{
    "GlazeWM" = {
        scoop install glazewm
        try {
            mkdir "$HOME\.glaze-wm"
        } catch {
            Write-Host "Directory Exists"
        }
        
        wget "https://raw.githubusercontent.com/crispy-cths/SillyInstaller/refs/heads/main/GlazeWM/config.yaml" -OutFile "$HOME\.glaze-wm\config.yaml"
    }
    
    "Shenanigans" = {
        scoop install btop
        scoop install fastfetch
        scoop install altsnap
        fastfetch --gen-config
        try {
        mkdir "$HOME\.config\fastfetch"
        } catch {
            Write-Host "Directory Exists"
        }
        wget "https://raw.githubusercontent.com/crispy-cths/SillyInstaller/refs/heads/main/Fastfetch/config.jsonc" -OutFile "$HOME\.config\fastfetch\config.jsonc"
        wget "https://raw.githubusercontent.com/crispy-cths/SillyInstaller/refs/heads/main/Fastfetch/cat.txt" -OutFile "$HOME\.config\fastfetch\cat.txt"


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
    
    "Flow Launcher" = {
        scoop install flow-launcher
        try {
            mkdir "$HOME\AppData\Roaming\FlowLauncher\Themes"
        } catch {
            Write-Host "Directory Exists"
        }
        winget "https://raw.githubusercontent.com/crispy-cths/SillyInstaller/refs/heads/main/Flow-Launcher/Catppuccin%20Mocha.xaml" -OutFile "$HOME\AppData\Roaming\FlowLauncher\Themes\Catppuccin Mocha.xaml"
    }

    "Windows Terminal" = {
        winget install Microsoft.WindowsTerminal
        try {
            mkdir "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
        } catch {
            Write-Host "Directory Exists"
        }
        wget "https://raw.githubusercontent.com/crispy-cths/SillyInstaller/refs/heads/main/Terminal/settings.json" -OutFile "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    }

    "Powershell Tweaks" = {
        scoop install oh-my-posh
        try {
            mkdir "$HOME\Documents\WindowsPowerShell\"
        } catch {
            Write-Host "Directory Exists"
        }
        Remove-Item -Path "$PROFILE" -Force
        wget "https://raw.githubusercontent.com/crispy-cths/SillyInstaller/refs/heads/main/Powershell/Microsoft.PowerShell_profile.ps1" -OutFile "$PROFILE"
    }

    "WindHawk" = {
        scoop install windhawk
    }

    "VS Code" = {
        scoop install vscode
    }
}

# Run the interactive menu
Show-InteractiveMenu -MenuItems $menuConfig
