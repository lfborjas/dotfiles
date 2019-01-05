# Clojure-friendly emacs config

*Mostly a fork of *: https://github.com/flyingmachine/emacs-for-clojure/

If you're new to emacs, check out
[this introductory tutorial](http://www.braveclojure.com/basic-emacs/)!

## Organization

The original author tried to separate everything logically and document the purpose
of every line. [`init.el`](./init.el) acts as a kind of table of
contents.  It's a good idea to eventually go through `init.el` and the
files under the `customizations` directory so that you know exactly
what's going on.

## CIDER integration:

The "brave clojure" purposefully used a very outdated CIDER. New versions of
cider have better support for nREPL and Clojurescript, among other things, so I
had to follow: https://github.com/flyingmachine/emacs-for-clojure/#upgrading
after upgrading Emacs from 24 to 25. Ran into a few other issues such as

* https://github.com/flyingmachine/emacs-for-clojure/issues/39
* https://emacs.stackexchange.com/questions/31364/cider-jack-in-symbols-function-definition-is-void-clojure-project-dir-with-cl
* https://groups.google.com/forum/#!topic/clojure/suo83_S3Luo

That directly stem from the outdated configs. Some manual intervention was
necessary.

## Supporting CSS, HTML, JS, etc.

Emacs has decent support for CSS, HTML, JS, and many other file types out of the box, but if you want better support, then have a look at [my personal emacs config's init.el](https://github.com/flyingmachine/emacs.d/blob/master/init.el). It's meant to read as a table of contents. The emacs.d as a whole adds the following:

* [Customizes js-mode and html editing](https://github.com/flyingmachine/emacs.d/blob/master/customizations/setup-js.el)
    * Sets indentation level to 2 spaces for JS
    * enables subword-mode so that M-f and M-b break on capitalization changes
    * Uses `tagedit` to give you paredit-like functionality when editing html
    * adds support for coffee mode
* [Uses enh-ruby-mode for ruby editing](https://github.com/flyingmachine/emacs.d/blob/master/customizations/setup-ruby.el). enh-ruby-mode is a little nicer than the built-in ruby-mode, in my opinion.
    * Associates many filenames and extensions with enh-ruby-mode (.rb, .rake, Rakefile, etc)
    * Adds keybindings for running specs
* Adds support for YAML and SCSS using the yaml-mode and scss-mode packages

In general, if you want to add support for a language then you should be able to find good instructions for it through Google. Most of the time, you'll just need to install the "x-lang-mode" package for it.
