;; -*- emacs-lisp -*-

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/auto-install")

(add-to-list 'load-path "~/.emacs.d/site-lisp/apel")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ensime/src/main/elisp")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/evernote-mode")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/hatena-diary")
(add-to-list 'load-path "~/.emacs.d/site-lisp/html-helper-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/js-doc")
(add-to-list 'load-path "~/.emacs.d/site-lisp/js2-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit")
(add-to-list 'load-path "~/.emacs.d/site-lisp/mmm-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode/lisp")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/riece/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ruby-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/rinari")
(add-to-list 'load-path "~/.emacs.d/site-lisp/rhtml")
(add-to-list 'load-path "~/.emacs.d/site-lisp/rcodetools-0.8.5.0")
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippets-rails")
(add-to-list 'load-path "~/.emacs.d/site-lisp/twittering-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/scala-dist/tool-support/src/emacs")

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

;; filenome prefix:
;;   - 00 : fundamental settings
;;   - 10 : pre load settings
;;   - 20 : custom functions
;;   - 30 : additional functions
;;   - 40 : minor mode settings
;;   - 50 : major mode settings
;;   - 90 : post load settings
