{exec} = require 'shelljs'

module.exports = (grunt) ->
  grunt.initConfig
    watch:
      jade:
        files: ['jade/*.jade']
        tasks: ['clientjade']
      javascript:
        files: ['ls/*.ls', 'build/clientjade.js']
        tasks: ['browserify', 'server']

  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'browserify', 'generate browser bundle', ->
    exec 'mkdir -p public'
    exec 'node_modules/.bin/browserify -d -t liveify ls/entry.ls -o public/app.js'

  grunt.registerTask 'clientjade', 'generate jade template bundle', ->
    exec 'bin/build-clientjade'

  grunt.registerTask 'server', 'run server', ->
    exec 'killall -9 omnifiddle > /dev/null'
    exec 'bin/server'

  grunt.registerTask 'all', ['clientjade', 'browserify', 'server']

  grunt.registerTask 'default', ['all', 'watch']
