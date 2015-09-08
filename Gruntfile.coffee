module.exports = (grunt) ->
    grunt.initConfig
        coffee:
            index:
                src: 'src/ng-loader.coffee'
                dest: "dest/ng-loader.js"

        ngAnnotate:
            index:
                files:
                    "dest/ng-loader.js": "dest/ng-loader.js"

        uglify:
            index:
                files:
                    "dest/ng-loader.min.js": "dest/ng-loader.js"

        stylus:
            index:
                src: "src/ng-loader.styl"
                dest: "dest/ng-loader.css"

        postcss:
            options:
                processors: [require('autoprefixer')({browsers: [
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
    grunt.loadNpmTasks 'grunt-ng-annotate'

    grunt.registerTask 'js', ['coffee', 'ngAnnotate', 'uglify']
    grunt.registerTask 'css', ['stylus', 'postcss']
    grunt.registerTask 'default', ['js', 'css']
