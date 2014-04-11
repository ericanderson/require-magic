define ["module"], (module) ->
  hasLocation = typeof location isnt "undefined" and location.href
  masterConfig = (module.config and module.config()) or {}
  theFiles = []

  magic =
    load: (name, req, onLoad, config) ->
      #console.log config
      #
      #			   Assume we are NodeJS for now. 
      #			
      fs = require.nodeRequire("fs")
      path = require.nodeRequire("path")

      doIt = (dir) ->
        files = fs.readdirSync(dir)
        
        for f in files
          fullPath = path.resolve(dir, f)
          stats = fs.statSync(fullPath)
          if (stats.isDirectory())
            doIt(fullPath)

          else if (f == "magic.json")
            magicFile = JSON.parse(fs.readFileSync(fullPath, 'UTF-8'))
            if magicFile[name]?
              for mf in magicFile[name]
                moduleId = path.relative(config.dirBaseUrl, path.resolve(dir, mf))
                req([moduleId])
                theFiles.push("'" + moduleId + "'")

      doIt(req.toUrl(config.dirBaseUrl))
      console.log(theFiles)
      
      onLoad()
      return

    write: (pluginName, moduleName, write) ->
      str = "define('" + pluginName + "!" + moduleName + "', ["
      str += theFiles.join(',')

      str += "], function() { return arguments; });"
      write str
      return

  magic

