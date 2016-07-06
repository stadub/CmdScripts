# CmdScripts
A few cmd scripts that make live easier

## SkypeSecondary.bat ##

Adds to autorun entry which runs second skype instance


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
