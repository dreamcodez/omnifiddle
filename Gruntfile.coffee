cp = require 'child_process'
{exec} = require 'shelljs'

module.exports = (grunt) ->
  watchOptions =
    interrupt: false
    debounceDelay: 250

  grunt.initConfig
    watch:
      jade:
        files: ['jade/*.jade']
        tasks: ['clientjade', 'server']
        options: watchOptions
      javascript:
        files: ['ls/*.ls']
        tasks: ['browserify', 'server']
        options: watchOptions
      stylus:
        files: ['styl/*.styl']
        tasks: ['stylus', 'server']
        options: watchOptions

  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'browserify', 'generate browser js bundle', ->
    exec 'node_modules/.bin/browserify -i cheerio -d -t liveify ls/entry.ls -o public/js/app.js'

  grunt.registerTask 'clientjade', 'generate jade template bundle', ->
    exec 'bin/build-clientjade'

  grunt.registerTask 'stylus', 'generate css from stylus sheets', ->
    exec 'mkdir -p public/css'
    exec 'stylus styl/app.styl -o public/css'

  grunt.registerTask 'server', 'run server', ->
    serious = '(ಠ_ಠ) (ಠ_ಠ)'
    boom    = ' ¯\\_(ツ)_/¯'

    console.log "\n  [ #{boom} ] Killing server BRO!"
    exec 'echo'
    exec 'killall -9 omnifiddle'
    exec 'sleep 1'

    child = cp.spawn 'bin/server', [], {detached: true, stdio: 'inherit'}
    console.log "\n  [ #{serious} ] Server started SIR! #{JSON.stringify(pid: child.pid)}"

  grunt.registerTask 'all', ['clientjade', 'browserify', 'stylus', 'server']

  grunt.registerTask 'default', ['all', 'watch']
