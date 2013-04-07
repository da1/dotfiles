;; ~/.emacs.d/lisp ディレクトリをロードパスに追加する
;; ただし、add-to-load-path関数を作成した場合は不要
;; (add-to-list 'load-path "~/.emacs.d/elisp")

(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d"))

;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (pat paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "conf" "public_repos")

;; C-hをbackspaceに
(keyboard-translate ?\C-h ?\C-?)
;; 別のキーボードにヘルプを割り当てる
(global-set-key (kbd "C-x ?") 'help-command)

;; C-mにnewline-and-indentを割り当てる
;; global-set-keyはdefine-key global-mapと同じ
(global-set-key (kbd "C-m") 'newline-and-indent)
;; 折り返しトグルコマンド
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

(show-paren-mode t)

;; *.~ というバックアップファイルを作らない
(setq make-backup-files nil)

(defun window-toggle-division ()
"window2分割時に縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "window not division"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )
    (switch-to-buffer-other-window other-buf)
    (other-window -1)))
(global-set-key (kbd "C-c C-t") 'window-toggle-division)
;(define-key inferior-scheme-mode-map "\b")

;; 行番号、カラム番号表示
(line-number-mode t)
(column-number-mode t)

;; 色づけ
(global-font-lock-mode t)

;; タブの代わりにスペースを使う
(setq tab-width 4 indent-tabs-mode nil)

;; 括弧の対応をハイライト
(setq show-paren-mode t)

;; 起動時の画面はいらない
(setq inhibit-startup-message t)

;; 全角スペース、タブの強調表示
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-2 '((t (:background "medium aquamarine"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks
          '(lambda ()
             (if font-lock-mode nil
               (font-lock-mode t))) t)

;; "M-k" でカレントバッファを閉じる。初期値は kill-sentence
(define-key global-map (kbd "M-k") 'kill-this-buffer)

;; "C-t" でウィンドウを切り替える。初期値は transpose-chars
(define-key global-map (kbd "C-t") 'other-window)

;; install-elispの設定
;http://d.hatena.ne.jp/tomoya/20090121/1232536106
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp")
;M-x install-elisp
;M-x install-elisp-from-emacswiki
;M-x dired-install-elisp-from-emacswiki

;; auto-installの設定
(when (require 'auto-install nil t)
  ;; インストールディレクトリ設定
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;;EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;;install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))

;; redo+の設定
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-c r") 'redo))

;; package.elの設定
(when (require 'package nil t)
  ;;パッケージリポジトリにMarmaladeと開発者運営のELPAを追加
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
	       '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))

;;; anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間 デフォルト値0.5
   anything-idle-delay 0.3
   ;; タイプして再描画するまでの時間 デフォルト値0.1
   anything-input-idle-delay 0.2
   ;; 候補最大表示数 デフォルト値50
   anything-candidate-number-limit 100
   ;;候補が多いときに体感速度を早くする
   anything-quick-update t
   ;;候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;;root権限でアクションを実行するときのコマンド
    (setq anything-su-or-sudo "sudo"))
  (require 'anything-match-plugin nil t)
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nil t))
  (when (require 'anything-complete nil t)
    ;; lispシンボルの保管候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))
  (require 'anything-show-completion nil t)
  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))
  (when (require 'descbinds-anything nil t)
    ;; describe-bindingsをAnythingに置き換える
    (descbinds-anything-install)))

;; color-moccurの設定
(when (require 'color-moccur nil t)
  ;; M-oにoccur-by-moccurを割り当て
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索の時除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "#.+#$")
  ;; Migemoを利用できる環境ならMigemoを使う
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; auto-completeの設定
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
	       "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; undohistの設定
;; M-x install-elisp RET http://cx4a.org/pub/undohist.el
(when (require 'undohist nil t)
  (undohist-initialize))

;; undo-treeの設定
;; M-x package-install RET undo-tree RET
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; point-undoの設定
;; M-x auto-install-from-emacswiki RET point-undo.el RET
(when (require 'point-undo nil t)
  (define-key global-map [f5] 'point-undo)
  (define-key global-map [f6] 'point-redo)
  ;; key-bind
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )

;; scheme 
(add-hook 'inferior-scheme-mode-hook '(lambda()
(define-key inferior-scheme-mode-map [up] 'comint-previous-input)
(define-key inferior-scheme-mode-map [down] 'comint-next-input)
(define-key inferior-scheme-mode-map "\C-p" 'comint-previous-input)
(define-key inferior-scheme-mode-map "\C-n" 'comint-next-input)))

(setq scheme-program-name "gosh")
(require 'cmuscheme)

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(define-key global-map
  "\C-cS" 'scheme-other-window)
