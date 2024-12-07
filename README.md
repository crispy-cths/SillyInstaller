# SillyInstaller

Installs a bunch of silly stuff onto school PCs using scoop and winget. Might work. Dont trust it.


You can install from powershell using this command:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://raw.githubusercontent.com/crispy-cths/SillyInstaller/refs/heads/main/SillyInstaller.ps1 | Invoke-Expression
```


Stuff that it installs:
* Git
* Btop
* Fastfetch
* Files
* Windhawk
* GlazeWM
* AltSnap
* Flow Launcher
* Translucent TB
* JetBrainsMono Nerd Fonts
* Windows Terminal
* Oh My Posh

It also configures them based of [this](https://github.com/ashish0kumar/windots) repository.
I'm too lazy to figure out how to make this stuff myself :3


To Do:
* Change GlazeWM config
* More testing >:(
