(setq use-package-always-ensure t)

(require 'package)
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/") t)

(use-package eglot
  :ensure t)

;; https://systemcrafters.net/emacs-from-scratch/the-best-default-settings/
(setq history-length 25)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(save-place-mode 1)
(recentf-mode 1)
(setq scroll-conservatively 101)

(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(menu-bar--display-line-numbers-mode-relative)

(setf dired-kill-when-opening-new-dired-buffer t)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(add-to-list 'default-frame-alist '(font . "iosevka_spw-13" ))
(set-face-attribute 'default nil :font "iosevka_spw-13" )
(set-frame-font "iosevka_spw-13" nil t)

(use-package evil
  :ensure t
  :init
  (progn
	(setq evil-want-keybinding nil)))

(use-package evil-collection)
(evil-collection-init '(dired elfeed magit))

(use-package doom-themes
  :ensure t)

(use-package which-key
	:ensure t)
(which-key-mode)


(use-package general
	:ensure t)

(use-package devdocs)
(use-package markdown-mode)

(use-package aggressive-indent)
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(add-hook 'html-mode-hook #'aggressive-indent-mode)

;; Eglot customization can be done through
;; C-h v 'eglot-ignored-server-capabilities'
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'rust-mode-hook 'eglot-ensure)
(add-hook 'tuareg-mode-hook 'eglot-ensure)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
			   '((c-mode c++-mode) . ("clangd"
									  "--background-index"
									  "--clang-tidy"
									  "--cross-file-rename"
									  "--completion-style=detailed"
									  "--header-insertion=never"
									  "--header-insertion-decorators=0"
									  )))
  )


;; https://stackoverflow.com/a/35469843
(with-eval-after-load 'smartparens
  (sp-with-modes
	  '(c++-mode objc-mode c-mode java-mode rust-mode tuareg-mode go-mode)
	(sp-local-pair "{" nil :post-handlers '(:add ("||\n[i]" "RET")))))

;; disable mouse highlight
;; https://stackoverflow.com/questions/23789962/how-to-disable-emacs-highlighting-whitespace-in-parenthesis
(setq sp-highlight-pair-overlay nil)

(setq-default indent-tabs-mode t)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide
(defvaralias 'c-basic-offset 'tab-width)

(setq auto-save-default nil
      make-backup-files nil)


(use-package projectile)
(use-package magit)
(use-package consult)

(use-package org-modern)
(add-hook 'org-mode-hook #'org-modern-mode)

(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)
							 (js . t)
							 (python . t)
							 (shell . t)))

(require 'org-tempo)

(setq org-image-actual-width 400)

(add-hook 'org-mode-hook #'org-toggle-inline-images)

(add-to-list 'org-structure-template-alist '("sh" . "src sh"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("cpp" . "src C++"))
(add-to-list 'org-structure-template-alist '("dennis" . "src C"))

(use-package vertico
  :init
  (vertico-mode))

;;(use-package savehist
;;  :ensure t)
(savehist-mode 1)

(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
		 :map minibuffer-local-map
		 ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(load "~/.emacs.d/elpa/corfu-0.34/corfu-popupinfo.el")
(corfu-popupinfo-mode)

(load-theme 'modus-operandi-deuteranopia t)
;;(load-theme 'doom-outrun-electric t)
;;(load-theme 'doom-ayu-dark t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(evil-mode)
(evil-set-undo-system 'undo-redo)

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-echo-documentation t)
  (corfu-count 10)
  (corfu-auto-delay 0)
  (corfu-auto-prefix 1)
  :hook ((prog-mode . corfu-mode)
		 (shell-mode . corfu-mode)
		 (eshell-mode . corfu-mode))
  :bind
  (:map corfu-map
		("C-n" . corfu-scroll-down)
		("C-p" . corfu-scroll-up)
		("<escape>" . corfu-quit)
		("<return>" . corfu-insert)
		("M-d" . corfu-show-documentation)
		("M-l" . corfu-show-location))
  :init
  (global-corfu-mode))

;; Option 1: Specify explicitly to use Orderless for Eglot
(setq completion-category-overrides '((eglot (styles orderless))))

;; Option 2: Undo the Eglot modification of completion-category-defaults
(with-eval-after-load 'eglot
	(setq completion-category-defaults nil))


(use-package orderless
	:init
	(setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides nil))

(use-package web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; TODO https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide?h=feature/tree-sitter
(use-package tree-sitter-langs
  :ensure t)

(use-package tree-sitter
  :ensure t
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package rust-mode)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))
(setq rust-format-on-save t)

(use-package flycheck-rust)
(with-eval-after-load 'rust-mode
	(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

(use-package tuareg)
(add-hook 'tuareg-mode-hook
		  (lambda() (setq tuareg-mode-name "🐫")))

(use-package smartparens)
(add-hook 'prog-mode-hook #'smartparens-global-mode)

(global-hl-line-mode t)

(use-package corfu-prescient)
(corfu-prescient-mode 1)

(use-package elfeed)
;; Somewhere in your .emacs file
(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
		"https://scientiac.tilde.team/atom.xml"
		"https://danluu.com/atom/index.xml"
		"https://luitelaagaman.com.np/atom.xml"
		"https://drewdevault.com/blog/index.xml"
		"https://briancallahan.net/blog/feed.xml"
		"https://shafik.github.io/feed.xml"
		"https://zserge.com/rss.xml"
		"https://0xax.github.io/index.xml"
		"https://brennan.io/blog/rss.xml"
		"https://jvns.ca/atom.xml"
		"https://0pointer.net/blog/index.rss20"
		"https://austinmorlan.com/index.xml"
		"https://fasterthanli.me/index.xml"
		"https://www.nayuki.io/rss20.xml"
		"https://austinhenley.com/blog/feed.rss"
		))


(use-package all-the-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package nyan-mode)
(setq nyan-animate-nyancat t)
(setq nyan-wavy-trail t)
(nyan-mode)

(general-unbind 'insert
	"C-n"
	"C-l"
	"C-p"
	"C-x C-n")

(general-unbind 'normal
  "C-x C-n")

(general-define-key
 :states '(insert visual)
 "C-l" 'normal-mode
 "C-x C-n" 'consult-buffer)

(defun open_foot()
  "Opens foot terminal in current buffer with its own process."
  (interactive)
  (start-process-shell-command "foot terminal" nil "foot"))

(general-define-key
 "C-c C-t" 'open_foot
 "C-x C-n" 'consult-buffer)

(general-define-key
 :keymaps 'corfu-map
 "C-n" 'corfu-next
 "C-l" 'corfu-quit
 "C-p" 'corfu-previous)

(general-define-key
 :keymaps 'vertico-map
 "C-w" 'backward-kill-word
 "C-c" 'keyboard-escape-quit)

 (general-define-key
  :keymaps 'eglot-mode-map
  :prefix "C-x"
  "C-n" 'consult-buffer)

(general-define-key
	:states 'normal
	:keymaps 'eglot-mode-map
	"C-e" 'flymake-goto-next-error)

(general-define-key
 :states 'normal
 :keymaps 'eglot-mode-map
 :prefix "C-c"
 "C-d" 'xref-find-definitions
 "C-r" 'xref-find-references
 "C-e" 'consult-flymake)

(general-define-key
 :states 'normal
 :keymaps 'xref--xref-buffer-mode-map
 "C-c" 'xref-goto-xref)

(use-package merlin)
(use-package geiser-mit)
;;; init.el ends here
