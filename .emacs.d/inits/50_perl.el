;; INSTALL
;; (auto-install-from-emacswiki "cperl-mode")
;; (auto-install-batch "perl-completion")

(defalias 'perl-mode 'cperl-mode)

;; Indent
(setq cperl-indent-level 4)
(setq cperl-continued-statement-offset 4)
(setq cperl-close-paren-offset -4)
(setq cperl-indent-region-fix-constructs t)
(setq cperl-indent-parens-as-block t)
(setq cperl-comment-column 40)

(add-to-list 'auto-mode-alist '("\\.pl$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

;; use perl installed by perlbrew
;; http://d.hatena.ne.jp/kiririmode/20100925/p1
;; http://gugod.org/2010/05/perlbrew-path-in-emacsapp.html
(load "cl-seq")
; Prepend perlbrew paths to exec-path
(mapc (lambda (x) (add-to-list 'exec-path x))
      (mapcar 'expand-file-name
              (list "~/perl5/perlbrew/bin" "~/perl5/perlbrew/perls/current/bin")))
; set PATH to be the same as exec-path, clobber the old PATH value.
(setenv "PATH"
        (reduce (lambda (a b) (concatenate 'string a ":" b))
                exec-path))

(defun perldoc-m ()
  (interactive)
  (let ((module (thing-at-point 'perl-module-thing))
        (pop-up-windows t)
        (cperl-mode-hook nil))
    (when (string= module "")
      (setq module (read-string "Module Name: ")))
    (let ((result (substring (shell-command-to-string (concat "perldoc -m " module)) 0 -1))
          (buffer (get-buffer-create (concat "*Perl " module "*")))
          (pop-or-set-flag (string-match "*Perl " (buffer-name))))
      (if (string-match "No module found for" result)
          (message "%s" result)
        (progn
          (with-current-buffer buffer
            (toggle-read-only -1)
            (erase-buffer)
            (insert result)
            (goto-char (point-min))
            (cperl-mode)
            (toggle-read-only 1)
            )
          (if pop-or-set-flag
              (switch-to-buffer buffer)
            (display-buffer buffer)))))))

;; code format
;; http://d.hatena.ne.jp/hakutoitoi/20090208/1234069614
(defun perltidy-region ()
  "Run perltidy based on Perl Best Practice  on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q -pbp" nil t)))

(defun perltidy-buffer ()
  "Run perltidy on the current buffer."
  (interactive)
  (save-excursion (mark-whole-buffer)
                  (perltidy-region)))

(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))

;; pod-mode
;; INSTALL
;; (install-elisp "http://github.com/renormalist/emacs-pod-mode/raw/master/pod-mode.el")
(require 'pod-mode)
(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))
(add-hook 'pod-mode-hook
          '(lambda ()
             (progn
               (font-lock-mode)
               (auto-fill-mode 1)
               (flyspell-mode 1)
               (local-set-key (kbd "C-x m") 'perldoc-m)
               )))

;; set-perl5lib
;; INSTALL
;; (install-elisp "http://coderepos.org/share/browser/lang/elisp/set-perl5lib/set-perl5lib.el?format=txt")
(require 'set-perl5lib)

;; tmt-mode
;; for Text::MicroTemplate
;; INSTALL
;; (install-elisp "https://github.com/yoshiki/tmt-mode/raw/master/tmt-mode.el")
(autoload 'tmt-mode "tmt-mode"
  "Major mode for editing Text::MicroTemplate syntax")
(add-to-list 'auto-mode-alist '("\\.mt$" . tmt-mode))

;; perl-eval
(defun perl-eval (begin end)
  "Run selected region as Perl code"
  (interactive "r")
  (shell-command-on-region begin end "perl"))

;; flymake
;; http://unknownplace.org/memo/2007/12/21#e001
(require 'flymake)
(defvar flymake-perl-err-line-patterns
  '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

(defconst flymake-allowed-perl-file-name-masks
  '(("\\.pl$" flymake-perl-init)
    ("\\.pm$" flymake-perl-init)
    ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (set-perl5lib)
  (defadvice flymake-post-syntax-check
    (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (flymake-mode t))

;; hook
(add-hook
 'cperl-mode-hook
 '(lambda ()
    (progn
      (flymake-perl-load)
      (local-set-key (kbd "C-x m") 'perldoc-m)
      (local-set-key (kbd "C-x C-e") 'perl-eval)
      (local-set-key (kbd "C-c C-p d") 'plcmp-cmd-show-doc)
      (local-set-key (kbd "C-c C-p D") 'plcmp-cmd-show-doc-at-point))))
