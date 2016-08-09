# CmdScripts
A few cmd scripts that make live easier

## InstallBin.cmd ##
Helper script that fetch all scripts(Mainly Build.cmd) dependences from the internet
>InstallBin.cmd


## SkypeSecondary.bat ##

Add to autorun entry which runs second Skype instance

## SkypeAdds.cmd ##

Remove Adds from Skype

## EvaluatedRun.cmd ##

Shell script to allow to run commands with evaluated privileges
- Automatically resolves path to executable (from %Path% variable)
- In case of Admin shell(or disable UAC) just starts command

*Example:*
```shell
EvaluatedRun.cmd notepad C:\text.txt
```

## MsBuild.cmd ##
Resolves location of the msbuild launcher to run msbuild project

*Usage:*
```shell
MsBuild.cmd myproject.project
```

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

## Copy.bat ##
Copies current folder content to destination sep by arg
>Copy.bat c:\

## Build.cmd ##
Installer script.

*Usage:*

Create Build installer script:
>Build.cmd [MyApp] 
Will generate `Build_MyApp.cmd` script for create installer 

Create installer script based on 7z SFX.

Create archive from %SrcDir% content and create SFX installer by combining 7zS.sfx + 7zConfig + Installer.7z to AppInstaller.exe

Installation performs copying archive content to the %DestDir% folder

*Require unpacked http://www.7-zip.org/a/7z920_extra.7z utils in the /bin directory*


*Sample `Build.cmd` Output:*
```shell
Enter Application name:>        MyApp

Starting installer configuration for MyApp
        1 file(s) copied.

Enter value for BeginPrompt:>   Do you want to install MyApp?

Enter value for SrcDir:>        C:\Sources\MyApp

Enter value for DestDir:>       C:\Program Files\MyApp
        1 file(s) moved.
        1 file(s) moved.

Application installer script generated successfully.
Use "c:\Sources\CmdScripts\Build_MyApp.cmd" to start installer script.
Press any key to continue . . .
```


*Config variables*

`BeginPrompt="Do you want to install MyApp?"` - The prompt will be shown during installation process

`SrcDir="C:\Work\MyApp\Release\bin"` - Directory with application being installed

`DestDir="C:\Program Files\MyApp"` - Directory application being installed



*Sample `Build_InstallerName.cmd` Output:*

```shell
c:\Sources\CmdScripts\Build.cmd MyApp

7-Zip (A) 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18
Scanning

Creating archive Installer.7z

Compressing  web\img\back.png
Compressing  web\img\forward.png
Compressing  Copy.bat
Compressing  web\index.html

Everything is Ok
c:\Sources\MyApp\Install
Writing Installer config
c:\Sources\CmdScripts\Bin\7zS.sfx
7zConfig
Installer.7z
        1 file(s) copied.
        1 file(s) moved.

'                     Installer successfully generated:              '
c:\Sources\MyApp\MyApp.exe
Press any key to continue . . .
```

## WebDownload.cmd ##
Download web resource
>WebDownload.cmd https://github.com/stadub/CmdScripts/archive/master.zip c:\Sources\CmdScripts.zip

## Unzip.cmd ##
Extract archive content 
>Unzip.cmd %CD%\CmdScripts.zip %CD%

## AddPath.cmd ##
Add directory to PATH environment variable
>AddPath.cmd c:\Sources\CmdScripts


