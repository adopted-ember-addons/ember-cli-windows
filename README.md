## Automatically Configure Windows for Ember Cli Performance
Ember and Ember Cli are some of the best tools for the development of sophisticated web applications. A lot of its magic is in the automatic build tool, which also allows for incremental builds during development. Those builds can be a bit slow on Windows - correct configuration of Windows Defender and the Windows Search Index improve the speed dramatically. Made with :heart: by Microsoft.

To optimize speed for a project, simply run the following from the root of your Ember Cli project:

```
npm install ember-cli-windows -g
ember-cli-windows
```

If you want to configure Windows Defender or Windows Search only, add `defender` or `search` as a parameter.

## License
MIT License, Copyright 2015 Felix Rieseberg & Microsoft. See LICENSE for more information.