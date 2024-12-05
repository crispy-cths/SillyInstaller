# SillyInstaller
Installs a bunch of silly stuff onto school PCs using scoop and winget. Might work. Dont trust it.


You can install from powershell using this command:
```
powershell.exe -ExecutionPolicy Bypass -Command "& {Invoke-WebRequest -Uri https://github.com/crispy-cths/SillyInstaller/raw/main/SillyInstaller.ps1 -OutFile SillyInstaller.ps1; ./SillyInstaller.ps1}"
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
