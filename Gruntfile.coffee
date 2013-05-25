{exec} = require 'shelljs'

module.exports = (grunt) ->
  grunt.initConfig
    watch:
      files: ['jade/*.jade']
      tasks: ['clientjade']

  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'clientjade', 'generate jade template bundle', ->
    exec 'bin/build-clientjade'

  grunt.registerTask 'all', ['clientjade']

  grunt.registerTask 'default', 'all', 'watch'
