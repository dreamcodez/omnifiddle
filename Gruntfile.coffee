{exec} = require 'shelljs'

module.exports = (grunt) ->
  grunt.initConfig
    watch:
      clientjade:
        files: ['jade/*.jade']
        tasks: ['clientjade']
      browserify:
        files: ['ls/*.ls', 'build/clientjade.js']
        tasks: ['browserify']

  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'browserify', 'generate browser bundle', ->
    exec 'mkdir -p public'
    exec 'node_modules/.bin/browserify -d -t liveify ls/entry.ls -o public/app.js'

  grunt.registerTask 'clientjade', 'generate jade template bundle', ->
    exec 'bin/build-clientjade'

  grunt.registerTask 'all', ['clientjade', 'browserify']

  grunt.registerTask 'default', ['all', 'watch']
