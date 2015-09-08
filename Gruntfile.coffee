module.exports = (grunt) ->
    grunt.initConfig
        coffee:
            index:
                src: 'src/ng-loader.coffee'
                dest: "dest/ng-loader.js"

        uglify:
            index:
                src: "dest/ng-loader.js"
                dest: "dest/ng-loader.min.js"

        stylus:
            index:
                src: "src/ng-loader.styl"
                dest: "dest/ng-loader.css"

        postcss:
            options:
                processors: [require('autoprefixer-core')({browsers: [
                    'firefox >= 35'
                    'chrome >= 40'
                    'opera >= 27'
                    'safari >= 8'
                    'ie >= 9'
                ]})]
            index:
                files:
                    "dest/ng-loader.css": "dest/ng-loader.css"

    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-postcss'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-uglify'

    grunt.registerTask 'js', ['coffee', 'uglify']
    grunt.registerTask 'css', ['stylus', 'postcss']
    grunt.registerTask 'default', ['js', 'css']
