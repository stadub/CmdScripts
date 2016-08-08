# CmdScripts
A few cmd scripts that make live easier

## SkypeSecondary.bat ##

Add to autorun entry which runs second skype instance

## SkypeAdds.cmd ##

Remove Adds from skype

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
Configuration scrpit. Used as part of the other scrpits to add script `config` files support
Check if scrpit `config` initlized(Init flag shoud be set to True)
in case initalized- create variables from file
otherwise pormpts user to initlize config varibales

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
Copies current folder content to destanation sep by arg
>Copy.bat c:\

## Build.cmd ##
Installer script

Create installer scrpit based on 7z SFX
Create archive from %SrcDir% content and create SFX installer by combining 7zS.sfx + 7zConfig + Installer.7z to installer.exe
Installation performs copying arhive content to the %DestDir% folder
###Requare unpacked http://www.7-zip.org/a/7z1602-extra.7z utils in the /bin directory###


*Usage:*
>Build.cmd

*Config file: [Build.config](https://raw.githubusercontent.com/stadub/CmdScripts/master/Build.config)*
`Init="True"` - Indiate that config file is configures(otherwise script will be started in the interactive mode)
`Title="My App Installer"` - Installer title`
`AppName="MyApp"` - The name of installer executable
`BeginPrompt="Do you want to install MyApp?"` - The prompt will be shown during instalation process
`SrcDir="C:\Work\MyApp\Release\bin"` - Directory with application being installed
`DestDir="C:\Program Files\MyApp"` - Directory Appliction being installed