# Trivial - Gulpfile

Tasks available:

1. [`scripts`](#scripts)
1. [`styles`](#styles)
1. [`html`](#html)
1. [`build`](#build)
1. [`clean`](#clean)
1. [`watch`](#watch)

## Setup

    gulp = require 'gulp'
    $ = require('gulp-load-plugins')()

## <a name="scripts"></a> `scripts` - Compile client-side scripts (using browserify)

Invokes browserify to compile all library files and source coffeescript files
into a javascript bundle.

    gulp.task "scripts", ->
      gulp.src("src/app.litcoffee", read: true)
      .pipe($.changed("build/"))
      .pipe($.browserify(
          transform: ['cjsxify']
          extenstions: ['.litcoffee']
        ))
      .pipe($.rename("bundle.js"))
      .pipe(gulp.dest("build/"))

## <a name="styles"></a> `styles` - Compile stylesheets

Converts SASS styles to good ol' CSS

    gulp.task "styles", ->
      gulp.src("src/styles/**/*.scss")
      .pipe($.changed("build/"))
      .pipe($.sass())
      .pipe($.concat("styles.css"))
      .pipe(gulp.dest("build/"))

## <a name="html"></a> `html` - Moves HTML files

Moves HTML files to the build directory

    gulp.task "html", ->
      gulp.src("src/*.html")
      .pipe($.changed("build/"))
      .pipe(gulp.dest("build/"))

## <a name="build"></a> `build` - Build the entire project

Runs the scripts, styles, html tasks

    gulp.task "build", ["scripts", "styles", 'html']

## <a name="clean"></a> `clean` - Clean build directory

Cleans the build directory of all files

    gulp.task "clean", ->
      gulp.src("build/", read: false)
      .pipe($.clean(force: true))

## <a name="watch"></a> `watch` - Watch for file changes and rebuild changed files

Watches for file changes and runs tasks to re-build the project

    gulp.task "watch", ->
      gulp.watch("src", ["build"])

      gulp.src('build')
      .pipe($.webserver(livereload: true))
