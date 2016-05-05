# CmdScripts
A few cmd scripts that makes live easier


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

Usage
```shell
MsBuild.cmd myproject.project
```
