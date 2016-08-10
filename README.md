# CmdScripts
A few cmd scripts that make live easier

## Scripts list:
 Runtime configuration:
* [InstallBin](#installbin.cmd) - download scripts dependencies
* [CmdAutoRun](#cmdautorun.cmd) - add folder to Cmd.exe autostart
* [CmdEnv](#cmdenv.cmd)     - set Cmd.exe aliaeses and Path variable

 One-time usage:
* [SkypeSecondary](#skypesecondary.cmd) - Add to autostart variables second instance of Skype  
* [SkypeRemoveAdds](#skypeadds.cmd)     - Block and remove adds from Skype
* [AddContextMenuPowershell](#addcontextmenupowershell.cmd) - Add to Explore context menu "Open folder in Powershell" and "Run Bypass/Admin ps1 script" 

 Utilities:
* [EvaluatedRun](#evaluatedrun.cmd) - Execute script/executable as Admin
* [RunPowershell](#runpowershell.cmd) - Run powershell script with "Bypass"
* [MsBuild](#msbuild.cmd) - Run msbuild.exe
* [WebDownload](#webdownload.cmd) - download file from web
* [Unzip](#unzip.cmd) - extract archive content
* [AddPath](#addpath.cmd) - add directory to Env:Path 
* [BuildInstaller](#build.cmd) - Create installer from folder content 

 Script templates:
* [SvnCheckout](#svncheckout.cmd) - Checkout svn(with injections) and build
* [Config](#config.cmd) - Init/Load config file
* [Copy](#copy.cmd) - Copy folder content
* [AddRoutesTemplate](#addroutestemplate.cmd) - template for RouteConfig scripts


## *Runtime configuration scripts:* ##

## InstallBin.cmd
Helper script that fetch all scripts(Mainly [Build.cmd](#Build.cmd)) dependencies from the internet
>InstallBin.cmd

## CmdAutoRun.cmd
Add `CmdEnv.cmd` to Command line autorun.

## CmdEnv.cmd
Helper script install aliases for scripts and insert scripts directory to the Path variable.
Also loads aliases from files pointed in the `DoskeyScripts` env variale
>InstallBin.cmd


## *One-time usage useful utilities:* ##

## SkypeSecondary.bat ##

Add to autorun entry which runs second Skype instance

## SkypeAdds.cmd ##

Remove Adds from Skype

## AddContextMenuPowershell.cmd ##

Add "Open PowerShell Here" entry to the Explorer directory context menu

## *Utilities:* ##

## EvaluatedRun.cmd ##

Shell script to allow to run commands with evaluated privileges
- Automatically resolves path to executable (from %Path% variable)
- In case of Admin shell(or disable UAC) just starts command

*Example:*
```shell
EvaluatedRun.cmd notepad C:\text.txt
```
## RunPowershell.cmd ##

Script is intended to run Powershell scripts from command line.
Allows to avoid 'execution of scripts is disabled on this system' message.

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
Copies current folder content to destination sep by arg
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

*##To install dependencies run `InstallBin.cmd` before installer script execution##*


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

Create archive from %SrcDir% content and create SFX installer by combining 7zS.sfx + 7zConfig + Installer.7z to AppInstaller.exe

Installation performs copying archive content to the %DestDir% folder







## *Script templates and script libraries:* ##

## AddRoutesTemplate.bat ##
Batch file template to create a routing file

*Usage:*
```shell
AddRoutes.bat
```

## SvnCheckout.bat ##
Allows to checkout svn repos via single script.

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