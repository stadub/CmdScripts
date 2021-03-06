# CmdScripts
A Cmd scripts which makes life easier.

## Scripts list:

### One-time usage:
* [SkypeSecondary](#skypesecondarycmd) - Add to autostart variables second instance of Skype  
* [SkypeRemoveAdds](#skypeaddscmd)     - Block and remove adds from Skype
* [AddContextMenuPowershell](#addcontextmenupowershellcmd) - Add to Explore context menu "Open folder in Powershell" and "Run Bypass/Admin ps1 script" 

### Utilities:
* [EvaluatedRun](#evaluatedruncmd) - Execute script/executable as Admin
* [Which.cmd] (#whichcmd) - Determine file full path(linux `Which` analogue)
* [PKill.cmd] (#pkillcmd) - Kill windows app by name(`taskkill` simple wrapper to be more like linux `pkill` command)
* [Ps.cmd] (#pscmd) - List process (`tasklist` simple wrapper to be more like linux `ps` command)
* [RunPowershell](#runpowershellcmd) - Run powershell script with "Bypass"
* [MsBuild](#msbuildcmd) - Run msbuild.exe
* [WebDownload](#webdownloadcmd) - download file from web
* [Unzip](#unzipcmd) - extract archive content
* [AddPath](#addpathcmd) - add directory to Env:Path 
* [BuildInstaller](#buildcmd) - Create installer from folder content 

### Runtime configuration:
* [InstallBin](#installbincmd) - download scripts dependencies
* [CmdAutoRun](#cmdautoruncmd) - add folder to Cmd.exe autostart
* [CmdEnv](#cmdenvcmd)     - set Cmd.exe aliaeses and Path variable

### Script templates:
* [SvnCheckout](#svncheckoutcmd) - Checkout svn(with injections) and build
* [Config](#configcmd) - Init/Load config file
* [Copy](#copycmd) - Copy folder content
* [AddRoutesTemplate](#addroutestemplatecmd) - template for RouteConfig scripts

##The easiest way to get all scripts: Press Win+R keyboard hotkeys and insert into the window entire script provided below:

```powershell.exe -executionpolicy bypass "$dst=Read-Host 'Enter install folder:';$repo='https://github.com/stadub/CmdScripts/archive/master.zip';$f=[System.IO.Path]::GetTempFileName()+'.zip';New-Object System.Net.WebClient|%{$_.DownloadFile($repo,$f);};$sh=New-Object -ComObject Shell.Application;$ar=$sh.NameSpace($f).Items();$af=$ar.Item(0).GetFolder.Items();mkdir $dst;$d=$sh.NameSpace($dst);$d.CopyHere($af, 272);& $dst\InstallBin.cmd;Write-Warning 'Add scripts to autorun?'  -warningaction Inquire;&  $dst\CmdAutoRun.cmd;pause"```

#*Runtime configuration scripts:*

## InstallBin.cmd
Helper script that fetch all scripts(Mainly [Build.cmd](#buildcmd)) dependencies from the internet
>InstallBin.cmd

## CmdAutoRun.cmd
Add `CmdEnv.cmd` to Command line autorun.

## CmdEnv.cmd
Helper script install aliases for scripts and insert scripts directory to the Path variable.
Also loads aliases from files pointed in the `DoskeyScripts` env variale
>InstallBin.cmd


#*One-time usage useful utilities:* #

## SkypeSecondary.bat ##

Add to autorun entry which runs second `Skype` instance

## SkypeAdds.cmd ##

Remove Adds from `Skype`

## AddContextMenuPowershell.cmd ##

Add `Open PowerShell Here` entry to the `Explorer` directory context menu

# *Utilities:* #

## EvaluatedRun.cmd ##

Shell script to allow to run commands with evaluated privileges
- Automatically resolves path to executable (from `%Path%` variable)
- In case of Admin shell(or disable UAC) just starts command

*Example:*
```shell
EvaluatedRun.cmd notepad C:\text.txt
```

## Which.cmd ##

Shell script to resolve path to executable (bat/cmd/exe files supported)

*Example:*
```shell
Which.cmd notepad
```

## PKill.cmd ##

Kill windows app by name.
Just handy `taskkill` wrapper.

*Example:*
```shell
pkill.cmd note*
```

## Ps.cmd ##

List process.
Just handy `tasklist` wrapper.

*Example:*
```shell
ps.cmd note*
```


## RunPowershell.cmd ##

Script is intended to run Powershell scripts from command line.
Allows to avoid `execution of scripts is disabled on this system` message.

*Example:*
```PowerShell
RunPowershell.cmd ls
```

## MsBuild.cmd ##
Resolves location of the msbuild launcher to run msbuild project

*Usage:*
```shell
MsBuild.cmd myproject.project
```

## Copy.bat ##
Copies current folder content to the folder set by arg
>Copy.bat c:\


## WebDownload.cmd ##
Download web resource
>WebDownload.cmd https://github.com/stadub/CmdScripts/archive/master.zip c:\Sources\CmdScripts.zip

## Unzip.cmd ##
Extract archive content 
>Unzip.cmd %CD%\CmdScripts.zip %CD%

## AddPath.cmd ##
Add directory to PATH environment variable
>AddPath.cmd c:\Sources\CmdScripts

## Build ##
Installer script.

*Require unpacked http://www.7-zip.org/a/7z920_extra.7z utils in the /bin directory.*

*##To install dependencies run [InstallBin.com](#installbincmd) before installer script execution##*


*Usage:*

To create installer generator script run:
>Build.cmd [MyApp] 

*Sample `Build.cmd` Output:*
```shell
Enter Application name:>        MyApp
Starting installer configuration for MyApp
Enter value for BeginPrompt:>   Do you want to install MyApp?
Enter value for SrcDir:>        C:\Sources\MyApp
Enter value for DestDir:>       C:\Program Files\MyApp

Application installer script generated successfully.
Use "c:\Sources\CmdScripts\Build_MyApp.cmd" to start installer script.
Press any key to continue . . .
```

*Config variables*

`BeginPrompt="Do you want to install MyApp?"` - The prompt will be shown during installation process

`SrcDir="C:\Work\MyApp\Release\bin"` - Directory with application being installed

`DestDir="C:\Program Files\MyApp"` - Directory application being installed

Description:
Create installer script based on 7z SFX.

Create archive from %SrcDir% content and create SFX installer by combining `7zS.sfx` + `7zConfig` + `Installer.7z` to `AppInstaller.exe`

Installation performs copying archive content to the `%DestDir%` folder


# *Script templates and script libraries:* #

## AddRoutesTemplate.bat ##
Batch file template to create a routing file

*Usage:*
```shell
AddRoutes.bat
```

## SvnCheckout.bat ##
Allows to checkout `svn repos` via single script.

Script can be added to scheduler. 

The "comon" repository that should be injected to the other repositories(external repo).

```SvnCheckout.cfg``` contain properties to configure script.

## Config.bat ##
Configuration scripts. Used as part of the other scripts to add script `config` files support.

Has 2 mode:

1) Interactive variables initialization when `config` file variable `Init` set to `False`

2) Creates variables from file when `config` file variable `Init` set to `True`


*Usage:*

*Config file: [Build.config](https://raw.githubusercontent.com/stadub/CmdScripts/master/Build.config)*
```Output
Init=False
Title=""
```

>Config.bat build

*Output:*
```Output
Write variable Init="True"
Enter value for Title:My App
Write variable Title="My App"
        1 file(s) moved.
        1 file(s) moved.
Setting var Init "True"
Setting var Title "My App"
```
