;;; init.el --- My init.el -*- lexical-binding: t; -*-

;;; Commentary:
;;; Code:
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

(leaf *user-settings
  :config
  (setq user-full-name "Taisuke Miyazaki"
        user-mail-address "imishinist@gmail.com"))

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "buildin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "buildin" "install"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))

  :bind (("M-ESC ESC" . c/redraw-frame))
  :custom '((user-full-name . "Taisuke Miyazaki")
            (user-mail-address . "imishinist@gmail.com")
            (user-login-name . "imishinist")
            (create-lockfiles . nil)
            (debug-on-error . t)
            (init-file-debug . t)
            (frame-resize-pixelwise . t)
            (enable-recursive-minibuffers . t)
            (history-length . 1000)
            (history-delete-duplicates . t)
            (scroll-preserve-screen-position . t)
            (scroll-conservatively . 100)
            (mouse-wheel-scroll-amount . '(1 ((control) . 5)))
            (ring-bell-function . 'ignore)
            (text-quoting-style . 'straight)
            (truncate-lines . t)
            ;; (use-dialog-box . nil)
            ;; (use-file-dialog . nil)
            ;; (menu-bar-mode . t)
            ;; (tool-bar-mode . nil)
            (scroll-bar-mode . nil)
            (indent-tabs-mode . nil))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p))
    

(leaf autorevert
      :doc "revert buffers when files on disk change"
      :tag "builtin"
      :custom ((auto-revert-interval .0.3)
	       (auto-revert-check-vc-info . t))
      :global-minor-mode global-auto-revert-mode)

(leaf cc-mode
  :doc "major mode for editing C and similar languages"
  :tag "builtin"
  :defvar (c-basic-offset)
  :bind (c-mode-base-map
         ("C-c c" . compile))
  :mode-hook
  (c-mode-hook . ((c-set-style "bsd")
                  (setq c-basic-offset 4)))
  (c++-mode-hook . ((c-set-style "bsd")
                    (setq c-basic-offset 4))))

(leaf delsel
  :doc "delete selection if you insert"
  :tag "builtin"
  :global-minor-mode delete-selection-mode)


(leaf *delimitor-settings
  :config
  (leaf paren
    :ensure t
    :doc "highlight matching paren"
    :tag "builtin"
    :custom ((show-paren-delay . 0.1)
             (show-paren-style . 'mixed))
    :hook (after-init-hook . show-paren-mode)))

(leaf symbol-overlay
  :ensure t
  :bind (("M-i" . symbol-overlay-put)
         (symbol-overlay-map
          ((kbd "C-p") . symbol-overlay-jump-prev)
          ((kbd "C-n") . symbol-overlay-jump-next)
          ((kbd "C-g") . symbol-overlay-remove-all)))
  :hook ((prog-mode-hook . symbol-overlay-mode)
         (markdown-mode-hook . symbol-overlay-mode)))

(leaf simple
  :doc "basic editing commands for Emacs"
  :tag "builtin" "internal"
  :custom ((kill-ring-max . 100)
           (kill-read-only-ok . t)
           (kill-whole-line . t)
           (eval-expression-print-length . nil)
           (eval-expression-print-level . nil)))

(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :blackout t
  :leaf-defer nil
  :custom ((ivy-initial-inputs-alist . nil)
           (ivy-hight . 15)
           (ivy-re-builders-alist . '((t . ivy--regex-fuzzy)
                                      (swiper . ivy--regex-plus)))
           (ivy-use-selectable-prompt . t))
  :global-minor-mode t
  :config
  (leaf avy-migemo
    :ensure t
    :hook (ivy-mode-hook . avy-migemo-mode))
  (leaf ivy-rich
    :doc "More friendly display transformer for ivy."
    :req "emacs-24.5" "ivy-0.8.0"
    :tag "ivy" "emacs>=24.5"
    :emacs>= 24.5
    :ensure t
    :hook (ivy-mode-hook . ivy-rich-mode))
  (leaf swiper
    :doc "Isearch with an overview. Oh, man!"
    :req "emacs-24.5" "ivy-0.13.0"
    :tag "matching" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :bind (("C-s" . swiper)))

  (leaf counsel
    :doc "Various completion functions using Ivy"
    :req "emacs-24.5" "swiper-0.13.0"
    :tag "tools" "matching" "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :blackout t
    :bind (("C-S-s" . counsel-imenu)
           ("C-x C-r" . counsel-recentf))
    :custom `((counsel-yank-pop-separator . "\n----------\n")
              (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group)))
    :global-minor-mode t))

    
(leaf prescient
  :doc "Better sorting and filtering"
  :req "emacs-25.1"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :commands (prescient-persist-mode)
  :custom `((prescient-aggressive-file-save . t)
            (prescient-save-file . ,(locate-user-emacs-file "prescient")))
  :global-minor-mode prescient-persist-mode)
  
(leaf ivy-prescient
  :doc "prescient.el + Ivy"
  :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :after prescient ivy
  :custom ((ivy-prescient-retain-classic-highlighting . t))
  :global-minor-mode t)

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "minor-mode" "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :commands flycheck-mode
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :hook (prog-mode-hook . flycheck-mode))

(leaf company
  :doc "Modular text completion framework"
  :req "emacs-24.3"
  :tag "matching" "convenience" "abbrev" "emacs>=24.3"
  :url "http://company-mode.github.io/"
  :emacs>= 24.3
  :ensure t
  :blackout t
  :leaf-defer nil
  :bind ((company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("<tab>" . company-complete-selection))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom ((company-idle-delay . 0)
           (company-minimum-prefix-length . 3)
           (company-transformers . '(company-sort-by-occurrence)))
  :global-minor-mode global-company-mode)

(leaf company-c-headers
  :doc "Company mode backend for C/C++ header files"
  :req "emacs-24.1" "company-0.8"
  :tag "company" "development" "emacs>=24.1"
  :added "2020-03-25"
  :emacs>= 24.1
  :ensure t
  :after company
  :defvar company-backends
  :config
  (add-to-list 'company-backends 'company-c-headers))

(leaf lsp-mode
  :ensure t
  :custom
  (lsp-print-io . nil)
  (lsp-rust-server . 'rls)
  :hook ((go-mode-hook . lsp)
         (java-mode-hook . lsp)
         (rust-mode-hook . lsp)
         (c-mode-hook . lsp)
         (c++-mode-hook . lsp)))

(defun lsp-go-install-save-hooks()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(leaf smart-jump
  :ensure t ivy
  :bind
  ("C-c C-j" . smart-jump-go)
  :custom
  (dumb-jump-mode . t)
  (dumb-jump-selector . 'ivy)
  (dumb-jump-use-visible-window . nil)
  :config
  (smart-jump-setup-default-registers))

(leaf lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode-hook . lsp-ui-mode)
  :bind ((lsp-mode-map
          ("C-c C-r" . lsp-ui-peek-find-references)
          ("C-c C-j" . lsp-ui-peek-find-definitions)
          ("C-c i"   . lsp-ui-peek-find-implementation)
          ("C-c m"   . lsp-ui-imenu)
          ("C-c s"   . lsp-ui-sideline-mode)
          ("C-c d"   . ladicle/toggle-lsp-ui-doc)))
  :custom
  (lsp-ui-doc-enable . t)
  (lsp-ui-doc-header . t)
  (lsp-ui-doc-include-signature . t)
  (lsp-ui-doc-position . 'top)
  (lsp-ui-doc-max-width . 60)
  (lsp-ui-doc-max-height . 20)
  (lsp-ui-doc-use-childframe . t)
  (lsp-ui-doc-use-webkit . nil)
  (lsp-ui-flycheck-enable . t)
  (lsp-ui-sideline-enable . nil)
  (lsp-ui-sideline-ignore-duplicate . t)
  (lsp-ui-sideline-show-symbol . t)
  (lsp-ui-sideline-show-hover . t)
  (lsp-ui-sideline-show-diagnostics . nil)
  (lsp-ui-sideline-show-code-actions . nil)
  (lsp-ui-imenu-enable . nil)
  (lsp-ui-imenu-kind-position . 'top)
  (lsp-ui-peek-enable . t)
  (lsp-ui-peek-peek-height . 20)
  (lsp-ui-peek-list-width . 50))

(leaf company-lsp
  :ensure t)

(leaf rust-mode
  :ensure t)

(leaf exec-path-from-shell
 :ensure t
 :config
    (let ((envs '("GOROOT" "GOPATH" "PATH")))
      (exec-path-from-shell-copy-envs envs)))

(leaf *golang-settings
  :config
  (leaf go-mode
    :ensure t
    :commands (go-mode)
    :config
    (setq indent-tabs-mode t)
    (setq gofmt-command "goimports")
    :hook ((go-mode-hook . lsp-deferred)
           (before-save . gofmt-before-save))
           ))

(leaf *java-settings
  :config
  (leaf lsp-java
    :ensure t))

(leaf *rust-settings
  :config
  (leaf rust-mode
    :ensure t
    :custom
    (rust-format-on-save . t))
  (leaf cargo
    :ensure t
    :hook ((rust-mode . cargo-minor-mode))))

(leaf *c-settings
  :config
  (leaf ccls
    :ensure t))

(leaf doom-themes
  :ensure t
  :custom
  (doom-themes-enable-italic . t)
  (doom-themes-enable-bold  . t)
  :config
  (load-theme 'doom-material t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; (leaf material-theme
;;   :doc "material theme"
;;   :tag "theme"
;;   :ensure t
;;   :config (load-theme 'material t))

(leaf *language-settings
  :config
  (setq default-file-name-coding-system nil)
  (set-language-environment 'Japanese)
  (set-default-coding-systems 'utf-8-unix)
  (set-terminal-coding-system 'utf-8-unix)
  (setq default-file-name-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8 . utf-8))
  (prefer-coding-system 'utf-8-unix))

(leaf *editor-settings
  :config
  (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
  (setq create-lockfiles nil)
  (setq make-backup-files nil)
  (setq delete-auto-save-files t))

(leaf *startup-settings
  :config
  (setq inhibit-startup-message t)
  (setq inhibit-startup-echo-area-message -1))

(leaf *line-settings
  :config
  (leaf linum
    :ensure t
    :config
    (global-linum-mode t)
    (setq linum-format " %4d│")))

(leaf git-gutter+
  :emacs>= 25
  :ensure t
  :init
  (global-git-gutter+-mode t))

(leaf yaml-mode
  :ensure t
  :mode (("\\.yml\\'")
         ("\\.yaml\\'")))

(leaf org
  :leaf-defer t
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :mode ("\\.org$'" . org-mode)
  :config
  (setq org-directory "~/workspace/org/")
  (setq org-agenda-files
        (list (concat org-directory "todo.org")
              (concat org-directory "notes.org")
	      (concat org-directory "schedule.org")))

  (setq org-default-notes-file (concat org-directory "notes.org"))
  (setq org-default-todos-file (concat org-directory "todo.org"))
  :custom
  (org-startup-with-inline-images . t)
  (org-hide-leading-stars . t)
  (org-log-done . 'time)
  (org-todo-keywords . '((sequence "TODO" "DOING" "WAITING" "REVIEWING" "|" "DONE" "CANCELED")))
  (org-todo-keyword-faces . '(("TODO" :foreground "red" :weight bold)
                            ("DOING" :foreground "cornflower blue" :weight bold)
                            ("WAITING" :foreground "orange" :weight bold)
                            ("REVIEWING" :foreground "magenta" :weight bold)
                            ("DONE" :foreground "green" :weight bold)
                            ("CANCELED" :foreground "green" :weight bold)))
  (org-agenda-time-grid .
                        '((daily today require-timed)
	                  (900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100)
	                  "......" "-----------------")))

(leaf org-capture
  :leaf-defer t
  :after org
  :commands (org-capture)
  :custom
  (setq org-directory "~/workspace/org/")
  (org-capture-templates .
                         '(("t" "Task" entry (file+headline org-default-todos-file "Inbox")
	                    "** TODO %?\n   %U\n %i")
	                   ("n" "Note" entry (file+headline org-default-notes-file "Notes")
	                    "* %?\nEntered on %U\n %i"))))

(provide 'init)

;;; init.el ends here
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
