;; init.el --- Emacs configuration

;; Make it possible to use several config files at the same time
(add-to-list 'load-path (expand-file-name "~/.emacs.d/inits/"))

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    pyvenv
    flycheck
    material-theme
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
(require 'color-theme)
(color-theme-initialize)
(color-theme-calm-forest)

(setq inhibit-startup-message t) ;; hide the startup message
;;(load-theme 'material t) ;; load material theme
;; Once i've moved to 26 version I don't need it anymore, so I commented it out
;;(global-linum-mode t) ;; enable line numbers globally
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))


(setq column-number-mode t)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; To support shortcuts in Russian keyboard layout

(loop
 for from across "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖ\ЭЯЧСМИТЬБЮ№"
 for to   across "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>#"
 do
 (eval `(define-key key-translation-map (kbd ,(concat "C-" (string from))) (kbd ,(concat
"C-" (string to)))))
 (eval `(define-key key-translation-map (kbd ,(concat "M-" (string from))) (kbd ,(concat
"M-" (string to))))))

;; Add ace-jump-mode

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; nasm-mode
(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))

;; ag
(require 'ag)

;; add automatic session saving during exit and restoring after restart
(desktop-save-mode 1)


;; Quicklisp
(if (file-exists-p "~/quicklisp/dists/quicklisp/software/")
    (let ((slime-path
           (car (file-expand-wildcards
                 (expand-file-name "~/quicklisp/dists/quicklisp/software/slime-*")))))
      (if (file-exists-p slime-path) (add-to-list 'load-path slime-path))))

;; Slime

  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")

;; Delelte trailing whitespaces in every mode
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Slime
;;(require 'slime)
;(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; Optionally, specify the lisp program you are using. Default is "lisp"
;;(setq inferior-lisp-program "yourlisp")


;; Org mode
(setq org-directory "~/.emacs.d/org/")
;; Don't forget to do that after setting this path
;; cd ~/.emacs.d/org ; touch touch todo.org diary.org org.org bookmarks.org refile.org work.org events.org paste.org
(require 'init-org)
;; Hotkeys
(define-prefix-command 'org-menu-map)
(define-key global-map (kbd "<f9>") 'org-menu-map)
(define-key global-map (kbd "<f9> <f9>") 'bh/show-org-agenda)
(define-key global-map (kbd "<f9> b") 'bbdb)
(define-key global-map (kbd "<f9> c") 'calendar)
(define-key global-map (kbd "<f9> f") 'boxquote-insert-file)
(define-key global-map (kbd "<f9> g") 'gnus)
(define-key global-map (kbd "<f9> h") 'bh/hide-other)
(define-key global-map (kbd "<f9> n") 'org-narrow-to-subtree)
(define-key global-map (kbd "<f9> u") 'bh/narrow-up-one-level)
(define-key global-map (kbd "<f9> o") 'bh/make-org-scratch)
(define-key global-map (kbd "<f9> s") 'bh/switch-to-scratch)
(define-key global-map (kbd "<f9> w") 'widen)
(define-key global-map (kbd "<f9> r") 'boxquote-region)
(define-key global-map (kbd "<f9> T") 'tabify)
(define-key global-map (kbd "<f9> U") 'untabify)
(define-key global-map (kbd "<f9> v") 'visible-mode)
(define-key global-map (kbd "<f7>") 'bh/set-truncate-lines)
(define-key global-map (kbd "<f5>") 'bh/org-todo)
(define-key global-map (kbd "S-<f5>") 'bh/widen)
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c b") 'org-iswitchb)
(define-key global-map (kbd "C-x m") 'browse-url-at-point)
(define-key global-map (kbd "<f8>") 'org-cycle-agenda-files)
(define-key global-map (kbd "C-<f9>") 'previous-buffer)
(define-key global-map (kbd "M-<f9>") 'org-toggle-inline-images)
(define-key global-map (kbd "C-<f10>") 'next-buffer)
(define-key global-map (kbd "<f11>") 'org-clock-goto)
(define-key global-map (kbd "C-<f11>") 'org-clock-in)
(define-key global-map (kbd "C-c c") 'org-capture)

;; Set palemoon as a default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "palemoon")

;; Start the server
(server-start)

;; init.el ends here
