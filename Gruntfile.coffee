module.exports = (grunt) ->

  sass = require 'node-sass'

  # Files to monitor.
  appFiles = [
    'server.coffee',
    'Gruntfile.coffee',
    'app/**/*.coffee',
    'config/**/*.coffee',
    'test/**/*.coffee'
  ]

  styleFiles = [
    'public/**/*.sass'
  ]

  # Grunt Config
  grunt.initConfig

    watch:
      server:
        files: appFiles,
        tasks: ['build', 'express:dev']
        options:
          spawn: false
      styles:
        files: styleFiles
        tasks: ['sass']
        options:
          livereload: 35629
  # grunt watch livereload for client scripts could also be added
  # here... we left it out for the sake of simplicity
  # .... this boilerplate omits frontend functionality

    sass:
      all: styleFiles
      options:
        sourceMap: true
        implementation: sass
        style: 'compressed'
      dist:
        files:
          './public/css/style.css': './public/sass/main.sass'

    express:
      options:
        script: 'index.js'
      dev:
        options:
          node_env: 'development'

    mochaTest:
      all:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
        src: ['test/**/*.coffee']

    coffeelint:
      all: appFiles
      options:
        arrow_spacing: {level: 'error'}
        ensure_comprehensions: {level: 'error'}
        no_unnecessary_double_quotes: {level: 'error'}
        no_trailing_whitespace: {level: 'error'}
        no_empty_param_list: {level: 'error'}
        spacing_after_comma: {level: 'error'}
        no_stand_alone_at: {level: 'error'}
        space_operators: {level: 'error'}
        indentation:
          value: 2
          level: 'error'
        cyclomatic_complexity:
          value: 36
          level: 'error'
        max_line_length:
          value: 120,
          level: 'error'
          limitComments: yes

  # Npm Tasks
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-sass'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-mocha-test'

  # Tasks
  grunt.registerTask('build', ['coffeelint'])
  grunt.registerTask('dev', ['build', 'sass', 'express:dev', 'watch'])
  grunt.registerTask('test', ['build', 'mochaTest'])
