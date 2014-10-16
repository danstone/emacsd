(require 'package)

(setq package-check-signature nil)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives
	       '("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(defvar required-packages)

(setq required-packages
      '(rainbow-delimiters
	paredit
	ido
	eldoc
	company
	cider
	lush-theme))

(require 'cl)

(defun packages-installed-p ()
  (loop for p in required-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;rainbow
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;paredit
(require 'paredit)

(autoload 'enable-paredit-mode  "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;;ido
(require 'ido)
(ido-mode t)
(setq ido-everywhere t)
(setq ido-ubiquitous t)
(setq ido-enable-flex-matching t)


;;eldoc
(require 'eldoc)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

;;company
(require 'company)
(global-company-mode)
(global-set-key (kbd "C-.") 'company-complete)

;;cider
(require 'cider)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-log-messages t)
(setq nrepl-hide-special-buffers t)
(setq cider-auto-select-error-buffer nil)

;;theme
(load-theme 'lush t)

;;destroy bars
(tool-bar-mode -1)
(menu-bar-mode -1)





