;; init.el
;; Author: Olivier Lemelin
;; --------------------------------
;; My Config file
;; Description: TODO
;; --------------------------------


; Minimalist look
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

; Display line number everywhere
(global-linum-mode 1)

; Clean start environment
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)  

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Ensure we save the open buffers so that they can be restore in a later session.
(desktop-save-mode 1)

; Auto-indent lines
(define-key global-map (kbd "RET") 'newline-and-indent)


;; Ensures that 'use-package' is installed.
(unless (package-installed-p 'use-package)
(package-install 'use-package))


; MELPA Packages
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; highlight the current line
(use-package hl-line
  :config
(global-hl-line-mode +1))


;;; UNDO Tree -- To visualize multiple undo paths.
(global-undo-tree-mode)

;;; Visual Changes

;; Load the Hack Font (monospace font)
(set-default-font "Hack-11")

;; Visual Theme
(load-theme 'spolsky t)



; Load Helm for auto-completion
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

; Company mode - autocomplete all the things
(add-hook 'after-init-hook 'global-company-mode)

; For Bindings autocompletion
(require 'helm-descbinds)
(global-set-key (kbd "C-h b") #'helm-descbinds)
(helm-descbinds-mode)

; Enable Paredit for Lisp-like languages
;;; (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;;; (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;;; (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;;; (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;;; (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;;; (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;;; (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;;; Attempting Smartparens test
; (require 'smartparens-config)

; (add-hook 'emacs-lisp-mode-hook       #'smartparens-mode)
; (add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-mode)
; (add-hook 'ielm-mode-hook             #'smartparens-mode)
; (add-hook 'lisp-mode-hook             #'smartparens-mode)
; (add-hook 'lisp-interaction-mode-hook #'smartparens-mode)
; (add-hook 'scheme-mode-hook           #'smartparens-mode)



; Enable matching parenthesis highlighting
(setq show-paren-delay 0)
(show-paren-mode 1)

; Rainbow delimiters for all programming modes.
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

; For Eldoc integration - add the paredit commands
(require 'eldoc
    (eldoc-add-command
     'paredit-backward-delete
     'paredit-close-round))

;(require 'parinfer)
;(use-package parinfer
;  :ensure t
;  :bind
;  (("C-," . parinfer-toggle-mode))
;  :init
;  (progn
;    (setq parinfer-extensions
;          '(defaults       ; should be included.
;            pretty-parens  ; different paren styles for different modes.
;            evil           ; If you use Evil.
;            lispy          ; If you use Lispy. With this extension, you should install Lispy and do not enable lispy-mode directly.
;            paredit        ; Introduce some paredit commands.
;            smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
;            smart-yank)   ; Yank behavior depend on mode.
;    (add-hook 'clojure-mode-hook #'parinfer-mode)
;    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
;    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
;    (add-hook 'scheme-mode-hook #'parinfer-mode)
;    (add-hook 'lisp-mode-hook #'parinfer-mode))

; Setup SLY for Common Lisp Devlopment
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'sly-autoloads)


;;; Python Setup
(elpy-enable)


;;; ORG Mode ;;;
(setq org-directory "/home/lemelino/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
     (define-key global-map "\C-cc" 'org-capture)


;;; AVY Mode
(global-set-key (kbd "C-c j") 'avy-goto-word-or-subword-1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" default)))
 '(package-selected-packages
   (quote
    (helm-ag sly sublime-themes use-package parinfer elpy cider avy undo-tree magit base16-theme rainbow-delimiters company paredit helm-descbinds helm zenburn-theme)))
 '(safe-local-variable-values
   (quote
    ((Base . 10)
     (Package . CL-PPCRE)
     (Syntax . COMMON-LISP)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
