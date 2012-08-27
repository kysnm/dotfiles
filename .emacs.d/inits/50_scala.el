;; http://d.hatena.ne.jp/tototoshi/20100925/1285420294
(require 'scala-mode-auto)

(defvar my-scala-current-buffer nil)

(defun my-scala-switch-to-interpreter ()
  (interactive)
  (setq my-scala-switch-to-interpreter (current-buffer))
  (unless (scala-interpreter-running-p-1)
	(scala-run-scala "scala"))
  (scala-switch-to-interpreter))

(defun my-scala-back-to-editing-buffer ()
  (interactive)
  (switch-to-buffer my-scala-current-buffer))

(define-key scala-mode-map "\C-c\C-z" 'my-scala-switch-to-interpreter)
(define-key scala-mode-inf-map "\C-c\C-z" 'my-scala-back-to-editing-buffer)

(require 'scala-mode-feature-electric)
    (add-hook 'scala-mode-hook
	      (lambda ()
		(scala-electric-mode)))

(defadvice scala-eval-region (after pop-after-scala-eval-region)
  (pop-to-buffer scala-inf-buffer-name))
(ad-activate 'scala-eval-region)

(defadvice scala-eval-buffer (after pop-after-scala-eval-buffer)
  (pop-to-buffer scala-inf-buffer-name))
(ad-activate 'scala-eval-buffer)
