;; Enable native compilation
(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors nil)
  (setq native-comp-deferred-compilation t))

;; Increase garbage collection threshold
(setq gc-cons-threshold 100000000) ;; 100mb

;; Increase the amount of data which Emacs reads from processes
(setq read-process-output-max (* 1024 1024)) ;; 1mb
;; Fix double buffering issues on macOS
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
;; Adjust for high-DPI displays
(setq frame-resize-pixelwise t)

(map! :leader
      (:prefix ("f". "")
       :desc "Config"                    "x" #'(lambda () (interactive) (find-file "~/.config/doom/emacs.org")))
      )

(map! :leader
      (:prefix ("d". "")
       :desc "Inbox"                    "i" #'(lambda () (interactive) (find-file "~/Dropbox/admin/gtd/inbox.org"))
       :desc "Gtd"                    "g" #'(lambda () (interactive) (find-file "~/Dropbox/admin/gtd/gtd.org"))
       )
      )

(setq doom-theme 'doom-one)



(setq display-line-numbers-type t)
(setq doom-modeline-major-mode-icon t)
(setq org-ellipsis " ▾ ")
(setq org-startup-folded 'content)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 18 :weight 'Light))
(setq doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 18 :weight 'Light))

;; Set frame transparency (93 = 93% opaque)
(set-frame-parameter (selected-frame) 'alpha 98)
(add-to-list 'default-frame-alist '(alpha . 98))

(setq org-directory "~/Dropbox/admin/gtd/")
(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "BOOK(b)" "|" "DONE(d)" "DROP(x)")
                            (sequence "[](T)" "|" "[X](D)")))
  (setq org-todo-keyword-faces
        '(
          ("TODO" . (:foreground "teal" :weight bold))
          ("NEXT" . (:foreground "red" :weight bold))
          ("PROJ" . (:foreground "yellow" :weight bold))
          ("BOOK" . (:foreground "orange" :weight bold))
          ("DROP" . (:foreground "#638154" :weight bold))
          )
        )

  )

(setq org-agenda-files '("~/Dropbox/admin/gtd/"))
(setq +org-capture-todo-file "~/Dropbox/admin/gtd/inbox.org")
(setq org-deadline-warning-days 7)
(setq org-agenda-tag-filter-preset '("-someday" "-inbox"))

;; (setq org-capture-templates
;;       '(("i" "Inbox" entry
;;          (file +org-capture-todo-file)
;;          "* TODO %?\n%i"
;;          :prepend t
;;          :empty-lines 0)))
;; (setq org-capture-templates
;;       '(("i" "Inbox" entry
;;          (file +org-capture-todo-file)
;;          "* TODO %?\n%i"
;;          :prepend t
;;          :empty-lines 0)
;;         ("t" "Todo" entry (file+headline "~/Dropbox/gtd/inbox.org" "Inbox")
;;          "* TODO %?\n  %i")))
(setq org-capture-templates
      '(("i" "Inbox" entry
         (file +org-capture-todo-file)
         "* TODO %?\n%i"
         :append t
         :empty-lines 0)
        ("t" "Todo" entry (file "~/Dropbox/admin/gtd/inbox.org")
         "* TODO %?\n  %i")))

(map! :leader
      (:prefix ("t". "Org Babel Tangle")
       :desc "Tangle File"                    "t" #'org-babel-tangle)
      )


(use-package! org-auto-tangle
  :ensure t
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t)
  )

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("cc" . "src C"))
(add-to-list 'org-structure-template-alist '("cf" . "src conf"))

(setq org-roam-db-location "~/Dropbox/admin/org/org-roam/org-roam.db")
(setq org-journal-dir "~/Dropbox/admin/org/journal")
(setq deft-directory "~/Dropbox/admin/org/org-roam")
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Dropbox/admin/org/org-roam")
  (org-roam-complete-everywhere t)
  (+org-roam-enable-auto-backlinks-buffer-h t)
  )
(after! org
  (setq org-fold-core-style 'overlays)
  )

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(require 'org-roam-protocol)

(setq doc-view-resolution 300)
(setq pdf-view-use-scaling t)

(use-package xmind-org
  :after org ; Ensures that xmind-org is loaded for org
  :config

  )

(use-package! gptel
  :config
  (setq gptel-backend (gptel-make-gemini "MyGemini" ; Choose a name for your backend
                                       :key (getenv "GEMINI_API_KEY")
                                       :stream t)) ; Enable streaming responses
  (setq gptel-model "gemini-2.5-pro-preview-05-06") ; Or your preferred Gemini model, e.g., "gemini-1.5-flash"
  ;; You can also set this as the default backend if you primarily use Gemini
  ;; (setq gptel-default-backend gptel-backend)
  )

(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools
