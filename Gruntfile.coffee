cp = require 'child_process'
{daemon, exec} = require 'shelljs'

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

  grunt.registerTask 'server', 'run server', ->
    exec 'killall -9 omnifiddle'
    work = ->
      cp.spawn 'bin/server', [], {detached: true, stdio: 'inherit'}
    setTimeout work, 1000 # need to bind to same socket again, so wait

  grunt.registerTask 'all', ['clientjade', 'browserify', 'server']

  grunt.registerTask 'default', ['all', 'watch']
