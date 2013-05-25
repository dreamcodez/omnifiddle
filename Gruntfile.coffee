cp = require 'child_process'
{exec} = require 'shelljs'

module.exports = (grunt) ->
  watchOptions =
    interrupt: false
    debounceDelay: 35

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
      stylus:
        files: ['styl/*.styl']
        tasks: ['stylus']
        options: watchOptions

  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'browserify', 'generate browser js bundle', ->
    exec 'node_modules/.bin/browserify -d -t liveify ls/entry.ls -o public/js/app.js'

  grunt.registerTask 'clientjade', 'generate jade template bundle', ->
    exec 'bin/build-clientjade'

  grunt.registerTask 'stylus', 'generate css from stylus sheets', ->
    exec 'mkdir -p public/css'
    exec 'stylus styl/app.styl -o public/css'

  child = null
  grunt.registerTask 'server', 'run server', ->
    if child
      process.kill(child)

    work = ->
      child = cp.spawn 'bin/server', [], {detached: true, stdio: 'inherit'}

    setTimeout work, 500 # need to bind to same socket again, so wait

  grunt.registerTask 'all', ['clientjade', 'browserify', 'stylus', 'server']

  grunt.registerTask 'default', ['all', 'watch']
