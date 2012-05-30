;; server
(if (or (eq window-system 'x)(eq window-system 'ns))
  (server-start))

;; PATH
;; http://d.hatena.ne.jp/syohex/20111117/1321503477
;;
;; add script below to .zshrc
;; <script>
;; perl -wle \
;;     'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
;;     PATH > ~/.emacs.d/shellenv.el
;; </script>
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

;; mail address
(setq user-mail-address "tokyoincidents.g@gmail.com")

;; meta & super key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; don't save backup files
(setq make-backup-files nil)

;; inhibit bell ring
(setq ring-bell-function 'ignore)

;; scroll settings
(setq scroll-step 1)

;; display column number
(column-number-mode t)

;; inhibit truncate
(setq-default truncate-lines nil)
(setq-default truncate-partial-width-windows t)

;; indent settings
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
;; (setq-default tab-width 4)

;; http://masutaka.net/chalow/2009-07-10-4.html
(defun set-aurora-tab-width (num &optional local redraw)
  (interactive "nTab Width: ")
  (when local
    (make-local-variable 'tab-width)
    (make-local-variable 'tab-stop-list))
  (setq tab-width num)
  (setq tab-stop-list ())
  (while (<= num 256)
    (setq tab-stop-list `(,@tab-stop-list ,num))
    (setq num (+ num tab-width)))
  (when redraw (redraw-display)) tab-width)

(set-aurora-tab-width (setq default-tab-width (setq-default tab-width 4)))

;; http://masutaka.net/chalow/2009-07-02-2.html
(defvar ctl-q-map (make-keymap))                 ;;; (★a)
(define-key global-map (kbd "C-q") ctl-q-map)    ;;; (★b)

(define-key ctl-q-map (kbd "2") (lambda () (interactive) (set-aurora-tab-width 2 t t)))
(define-key ctl-q-map (kbd "4") (lambda () (interactive) (set-aurora-tab-width 4 t t)))
(define-key ctl-q-map (kbd "8") (lambda () (interactive) (set-aurora-tab-width 8 t t)))

(c-set-offset 'case-label '+)

;; enable narrowing
(put 'narrow-to-region 'disabled nil)

;; hide startup message
(setq inhibit-startup-message t)

;; set time local
(setq system-time-locale "C")

;; change default grep command to ack
;; https://github.com/sugyan/dotfiles/.emacs.d/inits/03-editing.el
;; (setq grep-command "ack --nogroup ")

;; Displays the time in the mode line
(setq display-time-format "%Y-%m-%d (%a) %H:%M")
(display-time)

(if (eq system-type 'gnu/linux)
  (setq browse-url-browser-function 'browse-url-generic
    browse-url-generic-program "google-chrome"))