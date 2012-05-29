(require 'twittering-mode)

;; http://www.mew.org/~kazu/proj/cipher/ja/
;; (install-elisp "http://www.mew.org/~kazu/proj/cipher/alpaca.el")
(autoload 'alpaca-after-find-file "alpaca" nil t)  
(add-hook 'find-file-hooks 'alpaca-after-find-file)

(setq twittering-use-master-password t)

;; http://masutaka.net/chalow/2009-06-07-5.html
;; (setq twittering-icon-mode t)
;; (setq twittering-jojo-mode t)
(setq twittering-status-format "%i %s/%S,  %C %@:\n%FILL[  ]{%T // from %f%L%r%R}\n ")
(defun twittering-mode-hook-func ()
  (set-face-bold-p 'twittering-username-face t)
  (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
  (set-face-foreground 'twittering-uri-face "gray35")
  (define-key twittering-mode-map (kbd "<") 'my-beginning-of-buffer)
  (define-key twittering-mode-map (kbd ">") 'my-end-of-buffer)
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite))

(add-hook 'twittering-mode-hook 'twittering-mode-hook-func)
