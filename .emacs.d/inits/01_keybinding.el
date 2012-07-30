(global-set-key (kbd "C-c a")     'align)
(global-set-key (kbd "C-c M-a")   'align-regexp)
(global-set-key (kbd "C-h")       'backward-delete-char)
(global-set-key (kbd "C-x f")     'fill-paragraph)
(global-set-key (kbd "C-x M-f")   'fill-region)
(global-set-key (kbd "M-g")       'goto-line)
(global-set-key (kbd "C-S-i")     'indent-region)
(global-set-key (kbd "C-S-o")     'join-line)
(global-set-key (kbd "C-m")       'newline-and-indent)
(global-set-key (kbd "C-t")       'next-multiframe-window)
(cond
 ((eq window-system 'ns)
  (global-set-key (kbd "M-<RET>")   'ns-toggle-fullscreen))
 ((eq window-system 'x)
  (defun my-fullscreen ()
    (interactive)
    (let ((fullscreen (frame-parameter (selected-frame) 'fullscreen)))
      (cond
       ((null fullscreen)
        (set-frame-parameter (selected-frame) 'fullscreen 'fullboth))
       (t
        (set-frame-parameter (selected-frame) 'fullscreen 'nil))))
    (global-set-key (kbd "M-RET")   'my-fullscreen))))
 
(global-set-key (kbd "C-M-r")     'replace-regexp)
(global-set-key (kbd "C-r")       'replace-string)
(global-set-key (kbd "C-/")       'undo)

(global-set-key (kbd "C-x C-b")   nil)
(global-set-key (kbd "C-x M-b")   'list-buffers)

;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(define-prefix-command 'windmove-map)
(global-set-key (kbd "C-q") 'windmove-map)
(define-key windmove-map "h" 'windmove-left)
(define-key windmove-map "j" 'windmove-down)
(define-key windmove-map "k" 'windmove-up)
(define-key windmove-map "l" 'windmove-right)