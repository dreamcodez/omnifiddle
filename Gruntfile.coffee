cp = require 'child_process'
{exec} = require 'shelljs'

module.exports = (grunt) ->
  watchOptions =
    interrupt: true
    debounceDelay: 100

  grunt.initConfig
    watch:
      jade:
        files: ['jade/*.jade']
        tasks: ['clientjade']
        options: watchOptions
      javascript:
        files: ['ls/*.ls', 'build/clientjade.js']
        tasks: ['browserify', 'server']
        options: watchOptions

  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'browserify', 'generate browser bundle', ->
    exec 'node_modules/.bin/browserify -d -t liveify ls/entry.ls -o public/js/app.js'

  grunt.registerTask 'clientjade', 'generate jade template bundle', ->
    exec 'bin/build-clientjade'

  pid = null
  grunt.registerTask 'server', 'run server', ->
    if pid
      killCmd = 'kill -9 ' + pid
      console.log killCmd
      exec(killCmd)

    work = ->
      {pid} = cp.spawn 'bin/server', [], {detached: true, stdio: 'inherit'}

    setTimeout work, 1000 # need to bind to same socket again, so wait

  grunt.registerTask 'all', ['clientjade', 'browserify', 'server']

  grunt.registerTask 'default', ['all', 'watch']
