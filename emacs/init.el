;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq default-input-method "MacOSX")

; package
; ------------------------------------------------------------------------------

(defvar package-list
  '(company-quickhelp
     company
     company-go
     company-rtags
     company-racer
     company-irony
     go-mode
     racer
     material-theme
     irony
     flycheck-rust
     flycheck-rtags)
  "packages to be installed")

(require 'package)
(add-to-list 'package-archives '("melpa"    .	"http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade"	.	"http://marmalade-repo.org/packages/"))
(fset 'package-desc-vers 'package--ac-desc-version)
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(dolist (pkg package-list)
  (unless (package-installed-p pkg)
    (package-install pkg)))

; ------------------------------------------------------------------------------


; emacs setting
; ------------------------------------------------------------------------------
(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 .   utf-8))
(prefer-coding-system 'utf-8-unix)

; 余計なファイルを作らない
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq delete-auto-save-files t)

; 括弧を強調表示
(show-paren-mode t)

; 行番号表示
(global-linum-mode t)
(setq linum-format "%3d │")

; C-kで行削除
(setq kill-whole-line t)

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c ;") 'comment-region)
(global-set-key (kbd "C-c :") 'uncomment-region)

(ido-mode t)
; ------------------------------------------------------------------------------


; org-modeの設定
; ------------------------------------------------------------------------------
(setq org-log-done 'time)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-directory "~/Documents/org/")

; org-agenda
(setq org-agenda-files
      (list (concat org-directory "todo.org")
        (concat org-directory "schedule.org")))

(setq org-default-notes-file (concat org-directory "notes.org"))
(setq org-default-todos-file (concat org-directory "todo.org"))

(setq org-agenda-time-grid
      '((daily today require-timed)
        (900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000)
        "......" "----------------"))

(require 'org-capture)
(setq org-capture-templates
      '(("t" "Task" entry (file+headline org-default-todos-file "Inbox")
         "** TODO %?\n   %U\n %i\n %a")
        ("n" "Note" entry (file+headline org-default-notes-file "Notes")
         "* %?\nEntered on %U\n %i\n %a")))

(defun show-org-buffer (file)
  "Show an org-file FILE on the current buffer."
  (interactive)
  (if (get-buffer file)
    (let ((buffer (get-buffer file)))
      (switch-to-buffer buffer)
      (message "%s" file))
    (find-file (concat org-directory file))))

(global-set-key (kbd "C-M-^") '(lambda () (interactive)
                                 (show-org-buffer "notes.org")))

; ------------------------------------------------------------------------------


; themaの設定
; ------------------------------------------------------------------------------
(eval-after-load "meterial-theme"
                 (load-theme 'material t))
; ------------------------------------------------------------------------------


; uniquify
; ------------------------------------------------------------------------------
; ファイル名が同じのときにバッファ名を区別する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

; ------------------------------------------------------------------------------


; 補完設定
; ------------------------------------------------------------------------------
(require 'company)

; 全バッファで有効
(global-company-mode +1)
; 特定のmodeだけ有効にするときは以下
; (add-hook 'python-mode-hook 'company-mode)

(company-quickhelp-mode +1)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "TAB") 'company-complete-selection)
(define-key company-active-map (kbd "C-f") 'company-complete-selection)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

; ------------------------------------------------------------------------------

; rust設定
; ------------------------------------------------------------------------------
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))
(setq racer-rust-src-path
      (concat (string-trim
               (shell-command-to-string "rustc --print sysroot"))
              "/lib/rustlib/src/rust/src"))
; rustup component add rustfmt
; cargo install racer
; rustup componant add rust-src
(eval-after-load "rust-mode" '(setq-default rust-format-on-save t))
(eval-after-load "rust-mode" '(require 'racer))

(require 'company-racer)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'flycheck-rust-setup)
(add-hook 'racer-mode-hook #'eldoc-mode)
(defun racer-mode-hook()
  (company-mode)
  (set (make-variable-buffer-local 'company-idle-delay) 0.1)
  (set (make variable-buffer-local 'company-minimum-prefix-length) 0))
(add-hook 'racer-mode-hook 'racer-mode-hook)
(add-hook 'rust-mode-hook (lambda()
			    (racer-mode)
			    (flycheck-rust-setup)))


; ------------------------------------------------------------------------------

; go設定
; ------------------------------------------------------------------------------
; goimports on file save

; go get github.com/rogpeppe/godef
; go get -u github.com/nsf/gocode
; go get github.com/golang/lint/golint
; go get github.com/kisielk/errcheck

(setq gofmt-command "goimports")
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda()
			  (add-hook 'before-save-hook 'gofmt-before-save)
			  (local-set-key (kbd "M-.") 'godef-jump)
			  (set (make-local-variable 'company-backends) '(company-go))
			  (setq indent-tabs-mode nil)
			  (setq c-basic-offset 4)
			  (setq tab-width 4)))


; ------------------------------------------------------------------------------


; rtags設定
; ------------------------------------------------------------------------------
(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
                 '(add-to-list
                    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)
; ------------------------------------------------------------------------------


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/Documents/org/todo.org")))
 '(package-selected-packages
   (quote
    (company-quickhelp company company-go racer material-theme irony flycheck-rust flycheck-rtags company-rtags company-racer))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
