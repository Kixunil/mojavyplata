module.exports = function(grunt) {

	// 1. All configuration goes here
	grunt.initConfig({

		pkg: grunt.file.readJSON('package.json'),

		sass: {
			dist: {
				files: {
					'other/static/css/payroll.css': 'other/static/sass/payroll.sass',
					'other/static/css/helpers.css': 'other/static/sass/helpers.sass'
				},
				options: {
					style: 'compressed',
					sourcemap: 'auto'
				}
			}
		},

		autoprefixer: {
			single_file: {
				options: {
					browsers: ['last 10 versions', 'ie 9'],
					map: true // keep source maps
				},
				src: 'assets/css/main.css',
				dest: 'assets/css/main.css'
			}
		},

		watch: {
			css: {
				files: ['other/static/sass/**/*.sass'],
				tasks: ['sass']
			}
		},

		browserSync: {
			dev: {
				bsFiles: {
					src : 'other/static/css/**/*.css'
				},
				options: {
					watchTask: true, // < VERY important
					proxy: "http://127.0.0.1:8000/"
				}
			}
		}
	});

	// 3. Where we tell Grunt we plan to use this plug-in.
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-autoprefixer');
	grunt.loadNpmTasks('grunt-browser-sync');

	// css tasks
	grunt.registerTask('css', ['sass', 'watch']);

	grunt.registerTask('default', ['sass', 'browserSync', 'watch']);

};