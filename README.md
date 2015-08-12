## Automatically Configure Windows for Ember Cli Performance
Dramatically improve build speed during `ember build` and `ember serve`!

Ember and Ember Cli are some of the best tools for the development of sophisticated web applications. A lot of its magic is in the automatic build tool, which also allows for incremental builds during development. Those builds can be a bit slow on Windows - correct configuration of Windows Defender and the Windows Search Index improve the speed dramatically. Made with :heart: by Microsoft.

To optimize speed for a project, use Powershell to run the following from the root of your Ember Cli project:

```
npm install ember-cli-windows -g
ember-cli-windows
```

If you want to configure Windows Defender or Windows Search only, add `defender` or `search` as a parameter.

Should you get a PSSecurityException, allow your PowerShell to execute the script:

```
Set-ExecutionPolicy Unrestricted -scope Process
ember-cli-windows
```

## Run Ember Cli as Administrator
Additional performance can be gained by using an elevated prompt, which can be achieved by starting PowerShell or CMD ‘as Administrator’. If you do not have administrative rights on your machine, see the [Ember Cli section on symlinks](http://www.ember-cli.com/user-guide/#symlinks-on-windows) for information on how to enable additional performance gains.

## Ember Addon
This tool is also available as an Ember Addon, allowing you to ship the 'optimizing for Windows' capabilities with your project. For more information, [check out the addon here](https://github.com/felixrieseberg/ember-cli-windows-addon).

## Requirements
Windows 8, Windows 8.1 or Windows 10 heavily recommended. This script still works on Windows 7, thanks to a small hack by Benjamin Schuedzig.

## License
MIT License, Copyright 2015 Felix Rieseberg & Microsoft. See LICENSE for more information.
