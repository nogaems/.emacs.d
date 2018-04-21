(require 'org-install)    
(require 'org-protocol)
(require 'org-capture)
(require 'org-crypt)
(require 'org-archive)
(require 'ox-publish)

(require 'bh-helpers)

; Encrypt all entries before saving
;(org-crypt-use-before-save-magic)
;(setq org-tags-exclude-from-inheritance (quote ("crypt")))
; GPG key to use for encryption
;(setq org-crypt-key "F00BAR")

(setq org-modules (quote (org-bbdb
						  org-bibtex
						  org-docview
						  org-gnus
						  org-info
						  org-jsinfo
						  org-habit
						  org-irc
						  org-mew
						  org-mhe
						  org-protocol
						  org-rmail
						  org-vm
						  org-wl
						  org-w3m
						  org-mouse
						  org-choose
						  org-eshell
						  org-expiry
						  org-git-link
						  org-interactive-query
						  org-mairix
						  org-panel
						  org-registry
						  org-secretary
						  org-toc
						  org-track
						  org-velocity
						  org-wikinodes)))

; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?H)
                            (:endgroup)
                            ("WAITING" . ?w)
                            ("HOLD" . ?h)
                            ("PERSONAL" . ?P)
                            ("WORK" . ?W)
                            ("FARM" . ?F)
                            ("ORG" . ?O)
                            ("NORANG" . ?N)
                            ("crypt" . ?E)
                            ("astro" . ?a)
                            ("devel" . ?d)
                            ("radio" . ?r)
                            ("MARK" . ?M)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-log-state-notes-insert-after-drawers nil)

(add-hook 'message-mode-hook 'orgstruct++-mode 'append)
(add-hook 'message-mode-hook 'turn-on-auto-fill 'append)
(add-hook 'message-mode-hook 'orgtbl-mode 'append)
(add-hook 'message-mode-hook 'turn-on-flyspell 'append)
(add-hook 'message-mode-hook
                    '(lambda () (setq fill-column 72))
                              'append)
(add-hook 'message-mode-hook
                    '(lambda () (local-set-key (kbd "C-c M-o") 'org-mime-htmlize))
                              'append)

(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

(setq org-todo-file        (concat org-directory "todo.org")
      org-diary-file       (concat org-directory "diary.org")
      org-org-file         (concat org-directory "org.org")
      org-bookmarks-file   (concat org-directory "bookmarks.org")
      org-refile-file      (concat org-directory "refile.org")
      org-work-file        (concat org-directory "work.org")
      org-work-file        (concat org-directory "events.org")
      org-paste-file       (concat org-directory "paste.org"))
(setq org-agenda-files (list org-todo-file 
							 org-diary-file 
							 org-org-file 
							 org-bookmarks-file 
							 org-refile-file 
							 org-work-file
							 org-paste-file))
(setq org-default-notes-file org-refile-file)
(setq org-agenda-diary-file org-diary-file)
(setq org-agenda-include-diary nil)

; Archiving
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

; Include agenda archive files when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion
(setq org-completion-use-ido t)

; Make indentation by default
(setq org-startup-indented t)

;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda habit-down time-up user-defined-up priority-down effort-up category-keep)
              (todo category-up priority-down effort-up)
              (tags category-up priority-down effort-up)
              (search category-up))))

;; Start the weekly agenda on Monday
(setq org-agenda-start-on-weekday 1)

;; Enable display of the time grid so we can see the marker for the current time
(setq org-agenda-time-grid (quote ((daily today remove-match)
                                   #("----------------" 0 16 (org-heading t))
                                   (0900 1100 1300 1500 1700))))

;; Display tags farther right
(setq org-agenda-tags-column -102)

;;
;; Agenda sorting functions
;;
(setq org-agenda-cmp-user-defined 'bh/agenda-sort)

(setq org-enforce-todo-dependencies t)

; Extend TODO states
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))

; Define TODO sequences of states
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

; Select TODO state by C-c C-t <key>
(setq org-use-fast-todo-selection t)

; Enable using S-<arrows> to change state according to workflow
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

; Add default tags to TODO tasks according to it's state
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING" . t) ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(add-hook 'org-mode-hook 'turn-on-flyspell 'append)

(setq org-refile-target-verify-function 'bh/verify-refile-target)

(setq org-return-follows-link t)

; Define capture templates
(setq org-capture-templates
      '(("t" "Todo" entry (file org-refile-file)
		 "* TODO %?\n  %i\n  %a")
        ("p" "Paste" entry (file+datetree org-paste-file)
		 "* %?\nEntered on %U\n  %i\n  %a")
		("r" "Respond" entry (file org-refile-file)
		 "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :immediate-finish t)
        ("m" "Meeting" entry (file org-refile-file)
         "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
        ("h" "Habit" entry (file org-refile-file)
         "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
        ("n" "Note" entry (file org-refile-file)
         "* %? :NOTE:\n%U\n%a\n")
        ("j" "Journal" entry (file+datetree org-diary-file)
         "* %?\n%U\n")
        ("u" "URI Bookmark" entry
         (file+headline org-bookmarks-file "Bookmarks")
         "*** %^{Title|%:description}    %^g\n:PROPERTIES:\n:Title: %:description\n:Time: %u\n:URL: %:link\n:Comment: %:initial%?\n:END:")))

(add-hook 'org-after-todo-state-change-hook 'bh/mark-next-parent-tasks-todo 'append)
(add-hook 'org-clock-in-hook 'bh/mark-next-parent-tasks-todo 'append)

(setq org-show-entry-below (quote ((default))))
(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings (quote ((default))))

(setq org-id-method (quote uuidgen))

(setq org-deadline-warning-days 30)

(setq org-table-export-default-format "orgtbl-to-csv")


(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

;(org-babel-do-load-languages
; (quote org-babel-load-languages)
; (quote ((emacs-lisp . t)
;         (dot . t)
;         (ditaa . t)
;         (R . t)
;         (python . t)
;         (ruby . t)
;         (gnuplot . t)
;         (clojure . t)
;         (sh . t)
;         (ledger . t)
;         (org . t)
;         (plantuml . t)
;         (latex . t))))

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

(add-hook 'org-agenda-mode-hook
          '(lambda () (hl-line-mode 1))
          'append)

;; Keep tasks with dates on the global todo lists
(setq org-agenda-todo-ignore-with-date nil)

;; Keep tasks with deadlines on the global todo lists
(setq org-agenda-todo-ignore-deadlines nil)

;; Keep tasks with scheduled dates on the global todo lists
(setq org-agenda-todo-ignore-scheduled nil)

;; Keep tasks with timestamps on the global todo lists
(setq org-agenda-todo-ignore-timestamp nil)

;; Remove completed deadline tasks from the agenda view
(setq org-agenda-skip-deadline-if-done t)

;; Remove completed scheduled tasks from the agenda view
(setq org-agenda-skip-scheduled-if-done t)

;; Remove completed items from search results
(setq org-agenda-skip-timestamp-if-done t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
                (tags-todo "-WAITING-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
                           ((org-agenda-overriding-header "Tasks")
                            (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED+WAITING/!"
                           ((org-agenda-overriding-header "Waiting and Postponed Tasks")
                            (org-agenda-skip-function 'bh/skip-stuck-projects)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled 'future)
                            (org-agenda-todo-ignore-deadlines 'future)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil)
              ("b" "Bookmarks" tags "bookmark"
               ((org-agenda-overriding-header "Bookmarks")
                (org-tags-match-list-sublevels t)))
              ("r" "Tasks to Refile" tags "REFILE"
               ((org-agenda-overriding-header "Tasks to Refile")
                (org-tags-match-list-sublevels nil)))
              ("b" "Bookmarks" tags "bookmark"
               ((org-agenda-overriding-header "Bookmarks")
                (org-tags-match-list-sublevels t)))
              ("#" "Stuck Projects" tags-todo "-CANCELLED/!"
               ((org-agenda-overriding-header "Stuck Projects")
                (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
              ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
               ((org-agenda-overriding-header "Next Tasks")
                (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                (org-agenda-todo-ignore-scheduled t)
                (org-agenda-todo-ignore-deadlines t)
                (org-agenda-todo-ignore-with-date t)
                (org-tags-match-list-sublevels t)
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ("R" "Tasks" tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
               ((org-agenda-overriding-header "Tasks")
                (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                (org-agenda-sorting-strategy
                 '(category-keep))))
              ("p" "Projects" tags-todo "-HOLD-CANCELLED/!"
               ((org-agenda-overriding-header "Projects")
                (org-agenda-skip-function 'bh/skip-non-projects)
                (org-agenda-sorting-strategy
                 '(category-keep))))
              ("w" "Waiting Tasks" tags-todo "-CANCELLED+WAITING/!"
               ((org-agenda-overriding-header "Waiting and Postponed tasks"))
               (org-tags-match-list-sublevels nil))
              ("A" "Tasks to Archive" tags "-REFILE/"
               ((org-agenda-overriding-header "Tasks to Archive")
                (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                (org-tags-match-list-sublevels nil))))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

; Publishing configuration

; Inline images in HTML instead of producting links to the image
(setq org-export-html-inline-images t)
; Do not use sub or superscripts - I currently don't need this functionality in my documents
(setq org-export-with-sub-superscripts nil)
; Export with LaTeX fragments
(setq org-export-with-LaTeX-fragments t)
; Increase default number of headings to export
(setq org-export-headline-levels 6)

(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))
(setq org-latex-create-formula-image-program 'imagemagick)

; shows the syntax highlighting when viewing in the org-mode buffer
(setq org-src-fontify-natively t)

(provide 'init-org)
