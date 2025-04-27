;;; init.el --- My init.el -*- lexical-binding: t; -*-

;;; Commentary:
;;; Code:
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
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
;; </leaf-install-code>

;; <leaf-code>
(leaf *leaf
  :config
  (leaf leaf-convert
    :ensure t
    :config (leaf use-package :ensure t))
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))
;; </leaf-code>

(leaf macrostep
  :doc "Interactive macro expander."
  :req "cl-lib-0.5" "compat-29"
  :tag "debugging" "macro" "languages" "lisp"
  :url "https://github.com/emacsorphanage/macrostep"
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf *custom-emacs
   :init
   (leaf cus-edit
     :doc "tools for customizing Emacs and Lisp packages"
     :tag "builtin" "faces" "help"
     :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

   (leaf cus-start
     :doc "define customization properties of builtins"
     :tag "builtin" "install"
     :preface
     (defun c/redraw-frame nil
       (interactive)
       (redraw-frame))

     :bind (("M-ESC ESC" . c/redraw-frame))
     :custom '((user-full-name . "Taisuke Miyazaki")
               (user-mail-address . "imishinist@gmail.com")
               (user-login-name . "imishinist")
               (create-lockfiles . nil)
               (make-backup-files . t)
               (delete-auto-save-files . nil)
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
               (which-function-mode . t)
               ;; (use-dialog-box . nil)
               ;; (use-file-dialog . nil)
               (inhibit-startup-message . t)
               (inhibit-startup-echo-area-message . nil)
               (menu-bar-mode . nil)
               (tool-bar-mode . nil)
               (scroll-bar-mode . nil)
               (indent-tabs-mode . nil))
     :config
     (defalias 'yes-or-no-p 'y-or-n-p))
   (leaf simple
     :doc "basic editing commands for Emacs"
     :tag "builtin" "internal"
     :custom
     (kill-ring-max . 100)
     (kill-read-only-ok . t)
     (kill-whole-line . t)
     (eval-expression-print-length . nil)
     (eval-expression-print-level . nil))
   (leaf files
     :doc "file input and output commands for Emacs"
     :tag "builtin"
     :custom
     `((auto-save-timeout . 15)
       (auto-save-interval . 60)
       (auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
       (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
                                   (,tramp-file-name-regexp . nil)))
       (version-control . t)
       (delete-old-versions . t)))
   (leaf startup
     :doc "process Emacs shell arguments"
     :tag "builtin" "internal"
     :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-")))))

;; <theme-code>
(leaf theme
  :init
  (leaf modus-themes
    :ensure t
    :req "eamcs-28"
    :emacs>= 28.0
    :custom ((modus-themes-italic-constructs . t)
             (modus-themes-bold-constructs . nil)
             (modus-themes-region . '(bg-only no-extend)))
    :config
    (load-theme 'modus-vivendi-tinted t)))
;; </theme-code>

;; <general-editting-code>
(leaf *editting
  :config
  (leaf autorevert
    :doc "revert buffers when files on disk change"
    :ensure t
    :global-minor-mode global-auto-revert-mode
    :custom ((auto-revert-interval . 0.3)
             (auto-revert-check-vc-info . t)))
  (leaf delsel
    :doc "delete selection if you insert"
    :ensure t
    :global-minor-mode delete-selection-mode)
  (leaf diff-hl
    :doc "Highlight uncommitted changes using VC"
    :emacs>= 26.1
    :ensure t
    :commands (diff-hl-margin-mode)
    :global-minor-mode (global-diff-hl-mode)
    :config
    (diff-hl-flydiff-mode))

  (leaf highlight-indent-guides
    :doc "Minor mode to highlight indentation."
    :emacs>= 26.1
    :ensure t
    :hook
    (prog-mode-hook . highlight-indent-guides-mode)
    :custom ((highlight-indent-guides-method . 'column)
             (highlight-indent-guides-auto-enabled . t)
             (highlight-indent-guides-responsive . t)
             (highlight-indent-guides-character . ?\|)))

  (leaf paren
    :doc "show paren mode"
    :ensure t
    :commands (show-paren-mode)
    :global-minor-mode show-paren-mode
    :custom ((show-paren-delay . 0.2)
             (show-paren-style . 'mixed)))
  (leaf symbol-overlay
    :doc "highlight symbols with keymap-enabled overlays"
    :req "emacs-24.3" "seq-2.2"
    :emacs>= 24.3
    :ensure t
    :hook
    (prog-mode-hook . symbol-overlay-mode)
    (markdown-mode-hook . symbol-overlay-mode)
    :bind (("M-i" . symbol-overlay-put)
           ("M-p" . symbol-overlay-jump-prev)
           ("M-n" . symbol-overlay-jump-next)
           (symbol-overlay-map
            ("C-g" . symbol-overlay-remove-all))))
  (leaf undo-tree
    :doc "Treat undo history as a tree"
    :ensure t
    :global-minor-mode global-undo-tree-mode
    :custom ((undo-tree-auto-save-history . t)
	     (undo-tree-history-directory-alist
              . `((".*" . ,(expand-file-name "undo-history" user-emacs-directory))))))
  (leaf vc-hooks
    :doc "resident support for version-control"
    :custom ((vc-follow-symlinks . t))))
;; </general-editting-code>

;; <magit>
(leaf magit
  :doc "A Git porcelain inside Emacs."
  :emacs>= 27.1
  :ensure t)
;; </magit>

;; <ivy>
(leaf ivy
  :doc "Incremental Vertical completYon"
  :emacs>= 24.5
  :leaf-defer nil
  :ensure t
  :global-minor-mode ivy-mode
  :custom ((ivy-initial-inputs-alist . nil)
           (ivy-height . 15)
           (ivy-re-builders-alist . '((t . ivy--regex-fuzzy)
                                      (swiper . ivy--regex-plus)))
           (ivy-use-selectable-prompt . t))
  :config
  (leaf counsel
    :doc "Various completion functions using Ivy."
    :emacs>= 24.5
    :ensure t
    :after ivy swiper
    :global-minor-mode counsel-mode
    :bind (("C-S-s" . counsel-imenu)
           ("C-x C-r" . counsel-recentf))
    :custom `((counsel-yank-pop-separator . "\n----------\n")
              (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group))))

  (leaf ivy-rich
    :doc "More friendly display transformer for ivy"
    :emacs>= 25.1
    :ensure t
    :after ivy
    :hook
    (ivy-mode-hook . ivy-rich-mode))
  (leaf smart-jump
    :doc "Smart go to definition."
    :emacs>= 25.1
    :ensure t
    :custom ((dumb-jump-mode . t)
             (dumb-jump-selector . 'ivy)
             (dumb-jump-use-visible-window . nil))
    :config
    (smart-jump-setup-default-registers))
  (leaf swiper
    :doc "Isearch with an overview.  Oh, man!."
    :emacs>= 24.5
    :ensure t
    :after ivy
    :bind (("C-s" . swiper))))
;; </ivy>

;; <prescient>
(leaf prescient
  :doc "Better sorting and filtering."
  :emacs>= 25.1
  :ensure t
  :commands (prescient-persist-mode)
  :global-minor-mode prescient-persist-mode
  :custom `((prescient-aggressive-file-save . t)
            (prescient-save-file . ,(locate-user-emacs-file "prescient")))
  :config
  (leaf ivy-prescient
    :doc "Prescient.el + Ivy."
    :emacs>= 25.1
    :ensure t
    :after prescient ivy
    :global-minor-mode ivy-prescient-mode
    :custom ((ivy-prescient-retain-classic-highlighting . t))))
;; </prescient>

;; <flycheck>
(leaf flycheck
  :doc "On-the-fly syntax checking."
  :emacs>= 27.1
  :ensure t
  :hook
  (prog-mode-hook . flycheck-mode))
;; </flycheck>

;; <company>
(leaf company
  :doc "Modular text completion framework."
  :emacs>= 26.1
  :leaf-defer nil
  :ensure t
  :global-minor-mode global-company-mode
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
           (company-transformers . '(company-sort-by-occurrence))))
;; </company>

(setq read-process-output-max (* 1024 1024 10))
(setq gc-cons-threshold 100000000)

;; <lsp-mode>
(leaf lsp-mode
  :doc "LSP mode."
  :emacs>= 28.1
  :commands (lsp lsp-deferred)
  :ensure t
  :hook
  (prog-major-mode-hook . lsp-prog-major-mode-enable)
  :custom ((lsp-diagnostics-provider . :none)
           (lsp-print-io . nil))
  :config
  (leaf lsp-ui
    :doc "UI modules for lsp-mode."
    :emacs>= 28.1
    :after lsp-mode
    :ensure t
    :commands (lsp-ui-mode)
    :hook
    (lsp-mode-hook . lsp-ui-mode)
    :bind ((lsp-mode-map
            ("C-c C-r" . lsp-ui-peek-find-references)
            ("C-c C-j" . lsp-ui-peek-find-definitions)
            ("C-c i"   . lsp-ui-peek-find-implementation)
            ("C-c m"   . lsp-ui-imenu)
            ("C-c s"   . lsp-ui-sideline-mode)))
    :custom ((lsp-ui-doc-enable . t)
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
             (lsp-ui-peek-list-width . 50))))
;; </lsp-mode>

(leaf *language-settings
  :init
  (leaf *cc
    :defvar ((c-basic-offset)
             (flycheck-clang-include-path))
    :mode-hook
    (c-mode-hook . ((c-set-style "bsd")
                    (setq-local c-basic-offset 4)
                    (setq-local flycheck-clang-include-path '("/usr/local/include"))))
    (c++-mode-hook . ((c-set-style "bsd")
                      (setq-local c-basic-offset 4)
                      (setq-local flycheck-clang-include-path '("/usr/local/include"))))
    :init
    (leaf ccls
      :doc "Ccls client for lsp-mode."
      :emacs>= 28.1
      :ensure t
      :hook
      (c-mode-hook . lsp)
      (c++-mode-hook . lsp)))

  (leaf *go
    :config
    (leaf go-mode
      :doc "Major mode for the Go programming language."
      :emacs>= 26.1
      :ensure t
      :commands (go-mode)
      :defvar ((indent-tabs-mode)
               (gofmt-command))
      :config
      (leaf exec-path-from-shell
        :ensure t
        :config
        (let ((envs '("GOROOT" "GOPATH" "PATH")))
          (exec-path-from-shell-copy-envs envs)))
      (setq indent-tabs-mode t)
      (defun lsp-go-install-save-hooks()
        (add-hook 'before-save-hook #'lsp-format-buffer t t)
        (add-hook 'before-save-hook #'lsp-organize-imports t t))
      :hook
      (go-mode-hook . lsp)
      (go-mode-hook . lsp-go-install-save-hooks)))

  (leaf *haskell
    :config
    (leaf haskell-mode
      :doc "A Haskell editing mode"
      :emacs>= 25.1
      :ensure t
      :defvar (flycheck-disabled-checkers)
      :config
      (setq-local flycheck-disabled-checkers '(haskell-stack-ghc))
      :custom
      (flycheck-mode . nil)))

  (leaf *java
    :config
    (leaf lsp-java
      :doc "Java support for lsp-mode."
      :emacs>= 28.1
      :ensure t
      :hook
      (java-mode-hook . lsp)))

  (leaf *ocaml
    :config
    (leaf caml
      :doc "Caml mode for GNU Emacs"
      :emacs>= 24.4
      :ensure t)

    (leaf tuareg
      :doc "OCaml mode."
      :emacs>= 26.3
      :ensure t
      :after caml)

    (leaf dune
      :doc "Integration with the dune build system."
      :ensure t))

  (leaf *rust
    :config
    (leaf rust-mode
      :doc "A major-mode for editing Rust source code."
      :emacs>= 25.1
      :ensure t
      :custom
      (rust-format-on-save . t)
      :hook
      (rust-mode-hook . lsp))

    (leaf cargo
      :doc "Emacs Minor Mode for Cargo, Rust's Package Manager."
      :emacs>= 24.3
      :ensure t
      :hook
      (rust-mode-hook . cargo-minor-mode)))

  (leaf *web
    :config
    (leaf web-mode
      :doc "Major mode for editing web templates."
      :emacs>= 23.1
      :ensure t
      :defvar ((web-mode-markup-indent-offset)
               (web-mode-css-indent-offset)
               (web-mode-code-indent-offset))
      :config
      (setq-local web-mode-markup-indent-offset 2)
      (setq-local web-mode-css-indent-offset 2)
      (setq-local web-mode-code-indent-offset 2)
      :mode (("\\.ts[x]?\\'")
             ("\\.js[x]?\\'"))))

  (leaf yaml-mode
    :doc "Major mode for editing YAML files."
    :emacs>= 24.1
    :ensure t
    :mode (("\\.yml\\'")
           ("\\.yaml\\'")))

  (leaf fish-mode
    :doc "Major mode for fish shell scripts."
    :emacs>= 24
    :ensure t
    :mode (("\\.fish'"))))


;; (leaf org
;;   :leaf-defer t
;;   :bind (("C-c l" . org-store-link)
;;          ("C-c a" . org-agenda)
;;          ("C-c c" . org-capture))
;;   :mode ("\\.org$'" . org-mode)
;;   :defvar ((org-directory)
;;            (org-agenda-files)
;;            (org-default-notes-file)
;;            (org-default-todos-file)
;;            (org-default-diary-file))
;;   :config
;;   (setq org-directory "~/workspace/org/")
;;   (setq org-agenda-files (list org-directory))
;;   (setq org-default-notes-file (concat org-directory "notes.org"))
;;   (setq org-default-todos-file (concat org-directory "refile.org"))
;;   (setq org-default-diary-file (concat org-directory "diary.org"))
;;   :custom
;;   (org-refile-targets . '((org-agenda-files :maxlevel . 1)))
;;   (org-startup-with-inline-images . t)
;;   (org-hide-leading-stars . t)
;;   (org-log-done . 'time)
;;                                         ; TODO: 登録されたばかりのタスク
;;                                         ; NEXT: 現在進行中、または仕掛け中のタスク、直近着手すべき
;;                                         ; WAITING: 他人の作業街のタスク。街内容を記載する
;;                                         ; HOLD: 自分が諸事情で延期中のタスク。延期理由を記載する
;;                                         ; DONE: 完了したタスク
;;                                         ; CANCELED: 実施不要と判断したタスク。判断理由を記載する
;;   (org-todo-keywords . '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
;;                          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELED(c@/!)")))
;;   (org-todo-state-tags-triggers . '((("CANCELED" ("CANCELED" . t))
;;                                      ("WAITING" ("WAITING" . t))
;;                                      ("HOLD" ("WAITING") ("HOLD" . t))
;;                                      (done ("WAITING") ("HOLD"))
;;                                      ("TODO" ("WAITING") ("CANCELED") ("HOLD"))
;;                                      ("NEXT" ("WAITING") ("CANCELED") ("HOLD"))
;;                                      ("DONE" ("WAITING") ("CANCELED") ("HOLD")))))
;;   (org-todo-keyword-faces . '(("TODO" :foreground "red" :weight bold)
;;                               ("NEXT" :foreground "cornflower blue" :weight bold)
;;                               ("WAITING" :foreground "orange" :weight bold)
;;                               ("HOLD" :foreground "magenta" :weight bold)
;;                               ("DONE" :foreground "green" :weight bold)
;;                               ("CANCELED" :foreground "green" :weight bold)))
;;   (org-agenda-span . 'day)
;;   (org-capture-templates . '(("t" "Task" entry (file+headline org-default-todos-file "Refile")
;; 	                      "** TODO %?\n   %U\n %i")
;;                              ("n" "Note" entry (file+headline org-default-notes-file "Notes")
;;                               "** %?\n   %U\n %i")
;;                              ("d" "Dairy" entry (file+datetree org-default-diary-file)
;;                               "* %?\n   %U\n %i")))
;;   (org-agenda-custom-commands . '(("N" "Notes: メモ一覧" tags "NOTE"
;;                                    ((org-agenda-overriding-header "Notes")
;;                                     (org-tags-match-list-sublevels t)))
;;                                   ("h" "Habits: 習慣タスク一覧" tags-todo "STYLE=\"habit\""
;;                                    ((org-agenda-overriding-header "Habits")
;;                                     (org-agenda-sorting-strategy
;;                                      '(todo-state-down effort-up category-keep))))
;;                                   (" " "Agenda: 予定表"
;;                                    ((agenda "" nil)
;;                                     (tags "REFILE"
;;                                           ((org-agenda-overriding-header "リファイル待ち")
;;                                            (org-tags-match-list-sublevels nil)))
;;                                     (tags-todo "-CANCELLED/!NEXT"
;;                                                ((org-agenda-overriding-header "NEXTタスク")
;;                                                 (org-tags-match-list-sublevels t)
;;                                                 (org-agenda-sorting-strategy
;;                                                  '(todo-state-down effort-up category-keep))))
;;                                     (tags-todo "-HOLD-WAITING-CANCELLED/!-NEXT"
;;                                                ((org-agenda-overriding-header "処理待ち(NEXT候補)")
;;                                                 (org-tags-match-list-sublevels 'indented)
;;                                                 (org-agenda-sorting-strategy
;;                                                  '(category-keep))))
;;                                     (tags-todo "-CANCELLED+WAITING|HOLD/!"
;;                                                ((org-agenda-overriding-header "他者作業待ち・延期中")
;;                                                 (org-tags-match-list-sublevels nil)))
;;                                     nil))))
;;   (org-agenda-time-grid .
;;                         '((daily today require-timed)
;; 	                  (900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100)
;; 	                  "......" "-----------------")))

(provide 'init)

;;; init.el ends here
