;; init.el --- Emacs configuration

;; Here's a temporary workaround
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; INSTALL PACKAGES
;; --------------------------------------
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ace-jump-mode
    color-theme-modern
    nasm-mode
    ag
    elpy
    pyvenv
    flycheck
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; Company (COMPlete ANYthing)
(add-hook 'after-init-hook 'global-company-mode)

;; Set C code style to "linux"
(setq c-default-style "linux"
      c-basic-offset 4)
;; BASIC CUSTOMIZATION
;; --------------------------------------
;;(load-theme 'material t t)
;;(enable-theme 'material)
(load-theme 'jsc-dark t t)
(enable-theme 'jsc-dark)
(desktop-save-mode 1)
(setq inhibit-startup-message t) ;; hide the startup message
(menu-bar-mode -1)
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
(setq column-number-mode t)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
;;(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Add ace-jump-mode

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; nasm-mode
(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))

;; ag
(require 'ag)

;; session saving across restarts
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")

;; Delelte trailing whitespaces in every mode
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; fix bindings

(define-key function-key-map "\e[A" [up])
(define-key function-key-map "\e[B" [down])
(define-key function-key-map "\e[C" [right])
(define-key function-key-map "\e[D" [left])

(define-key function-key-map "\e[1;2A" [S-up])
(define-key function-key-map "\e[1;2B" [S-down])
(define-key function-key-map "\e[1;2C" [S-right])
(define-key function-key-map "\e[1;2D" [S-left])

(define-key function-key-map "\e[1;5A" [C-up])
(define-key function-key-map "\e[1;5B" [C-down])
(define-key function-key-map "\e[1;5C" [C-right])
(define-key function-key-map "\e[1;5D" [C-left])

(define-key function-key-map "\e[1;3A" [M-up])
(define-key function-key-map "\e[1;3B" [M-down])
(define-key function-key-map "\e[1;3C" [M-right])
(define-key function-key-map "\e[1;3D" [M-left])

;(define-key function-key-map "\e[1;7A" [C-M-up])
;(define-key function-key-map "\e[1;7B" [C-M-down])
;(define-key function-key-map "\e[1;7C" [C-M-right])
;(define-key function-key-map "\e[1;7D" [C-M-left])

(define-key function-key-map "\e[2~" [insert])
(define-key function-key-map "\e[3~" [delete])
(define-key function-key-map "\e[7~" [home])
(define-key function-key-map "\e[8~" [end])
(define-key function-key-map "\e[5~" [prior])
(define-key function-key-map "\e[6~" [next])

(define-key function-key-map "\e[2;2~" [S-insert])
(define-key function-key-map "\e[3;2~" [S-delete])

(define-key function-key-map "\e[2;5~" [C-insert])
(define-key function-key-map "\e[3;5~" [C-delete])
(define-key function-key-map "\e[1;5H" [C-home])
(define-key function-key-map "\e[1;5F" [C-end])
(define-key function-key-map "\e[1;5F" [C-end])
(define-key function-key-map "\e[5;5~" [C-prior])
(define-key function-key-map "\e[6;5~" [C-next])

;; Set midori as default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "midori")

;; Start the server
;; Currently not running it in this mode, commented out
;;(server-start)

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (color-theme-modern py-autopep8 nasm-mode material-theme flycheck elpy ein better-defaults ag ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
