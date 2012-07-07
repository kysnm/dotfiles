;; INSTALL
;; (auto-install-batch "auto-complete development version")
;; (auto-install-from-emacswiki "auto-complete-etags.el")
;; (auto-install-from-emacswiki "etags-table.el")
(require 'auto-complete-config)
(require 'auto-complete-etags)

;; company
;; INSTALL
;; (install-elisp "http://nschum.de/src/emacs/company-mode/company-0.5.tar.bz2")

;; ac-company
;; INSTALL
;; (install-elisp "https://raw.github.com/buzztaiki/auto-complete/master/ac-company.el")
(require 'ac-company)

;; etacs-table
;; INSTALL
;; (install-elisp "http://bitbucket.org/sakito/dot.emacs.d/raw/tip/local-lisp/etags-table.el")
(require 'etags-table)

;; auto-complete-clang
;; INSTALL
;; (install-elisp "https://raw.github.com/brianjcj/auto-complete-clang/master/auto-complete-clang.el")
(require 'auto-complete-clang)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/assets/ac-dict")
(global-set-key (kbd "M-_") 'auto-complete)
(setq ac-auto-start 1)
(setq ac-auto-show-menu 0.2)

(setq ac-modes
      '(c++-mode
        c-mode
        cc-mode
        cperl-mode
        css-mode
        ecmascript-mode
        emacs-lisp-mode
        html-helper-mode
        java-mode
        javascript-mode
        js-mode
        js2-mode
        lisp-interaction-mode
        lisp-mode
        makefile-mode
        objc-mode
        org-mode
        perl-mode
        php-mode
        python-mode
        ruby-mode
        scala-mode
        sh-mode
        tmt-mode
        xml-mode
        yaml-mode))

(setq-default ac-sources '(ac-source-yasnippet
                           ac-source-dictionary
                           ac-source-gtags
                           ac-source-words-in-same-mode-buffers))

(global-auto-complete-mode t)

;; for cperl-mode
(setq plcmp-use-keymap nil)
(require 'perl-completion)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq plcmp-use-keymap nil)
             (add-to-list 'ac-sources 'ac-source-perl-completion)
             (perl-completion-mode t)))

;; http://d.hatena.ne.jp/sugyan/20120103/1325523629
(defvar ac-source-my-perl-completion
  '((candidates . plcmp-ac-make-cands)))
(defun my-cperl-mode-hook ()
  (interactive)
  (perl-completion-mode t)
  (require 'auto-complete)
  (add-to-list 'ac-sources 'ac-source-my-perl-completion))
(add-hook 'cperl-mode-hook 'my-cperl-mode-hook)

;; for emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (add-to-list 'ac-sources 'ac-source-functions)
             (add-to-list 'ac-sources 'ac-source-symbols)))

;; for objc-mode
(ac-company-define-source ac-source-company-xcode company-xcode)
(add-to-list 'etags-table-alist
             '("\\.[mh]$" "~/.emacs.d/tags/objc.TAGS"))
(defvar ac-source-objc-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-candidate-face)
    (selection-face . ac-selection-face)
    (requires . 1))
  "add etags to ac-source")
(add-hook 'objc-mode-hook
          (lambda ()
            ;(add-to-list 'ac-sources 'ac-source-c++-keywords)
            (add-to-list 'ac-sources 'ac-source-clang)
            ;(add-to-list 'ac-sources 'ac-source-objc-etags)
            (add-to-list 'ac-sources 'ac-source-company-xcode)))

;; for c-mode
(add-hook 'c-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-clang)))

;; for c++-mode
(add-hook 'c++-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-clang)))

;; for ruby-mode
;; (install-elisp "http://www.cx4a.org/pub/auto-complete-ruby.el")
;; http://d.hatena.ne.jp/tkng/20090207/1234020003
(add-hook 'ruby-mode-hook
          (lambda ()
            (require 'rcodetools)
            (require 'auto-complete-ruby)
            (make-local-variable 'ac-omni-completion-sources)
            (setq ac-omni-completion-sources '(("\\.\\=" . (ac-source-rcodetools))))))
