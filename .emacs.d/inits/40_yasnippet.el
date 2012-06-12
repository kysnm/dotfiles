;; http://code.google.com/p/yasnippet/
(require 'yasnippet)

(yas/initialize)
;; http://capitaomorte.github.com/yasnippet/snippet-organization.html
(setq yas/root-directory '("~/.emacs.d/assets/snippets"
                           "~/.emacs.d/assets/yasnippets-rails/rails-snippets"))
(mapc 'yas/load-directory yas/root-directory)

(global-set-key (kbd "C-c s") 'yas/insert-snippet)

;; http://d.hatena.ne.jp/gan2/20080402/1207135480
;; http://tech.lampetty.net/tech/index.php/archives/384
(require 'dropdown-list)
(setq yas/text-popup-function #'yas/dropdown-list-popup-for-template)
 
;; コメントやリテラルではスニペットを展開しない
(setq yas/buffer-local-condition
      '(or (not (or (string= "font-lock-comment-face"
                             (get-char-property (point) 'face))
                    (string= "font-lock-string-face"
                             (get-char-property (point) 'face))))
           '(require-snippet-condition . force-in-comment)))
 
;;; yasnippet展開中はflymakeを無効にする
(defvar flymake-is-active-flag nil)
(defadvice yas/expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))
(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))


(set-face-background  'yas/field-highlight-face nil)
(set-face-underline-p 'yas/field-highlight-face t)
(set-face-underline   'yas/field-highlight-face "#404040")

;; hippie-expand
(global-set-key "\C-o" 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; http://d.hatena.ne.jp/sugyan/20120111/1326288445
(defun my-yas/prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  coice)))
         (selected (anything-other-buffer
                    `(((name . ,(format "%s" prompt))
                       (candidates . names)
                       (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*anything yas/prompt*")))
    (if selected
        (let ((n (position selected names :test 'equal)))
          (nth n choices))
      (signal 'quit "user quit!"))))
(custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
