(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cb-generalise-file-name-alist (quote (("^\\$SW_DM_DIR" . "C:\\github\\dm\\design_manager") ("^\\$SW_GAS_DIST_OFFICE_DIR" . "C:\\github\\gdo\\gas_distribution_office") ("^\\$SW_ELECTRIC_OFFICE_DIR" . "C:\\github\\eo\\electric_office") ("^\\$SW_COMMON_OFFICE_DIR" . "C:\\github\\sw_common_office\\sw_common_office") ("" . ""))))
 '(cb-jump-replaces-cb-buffer t)
 '(gis-command-history (quote ("[C:\\Github\\epcor\\scripts/] C:\\Smallworld517\\core\\bin\\x86\\runalias.exe -e C:\\Github\\epcor\\config\\environment.bat -a C:\\Github\\epcor\\config\\gis_aliases epcor -cli" "[%HOME%] sw_magik_win32 -Mextdir $TEMP -image ${SMALLWORLD_GIS}/images/swaf.msf" "[%HOME%] runalias -a %SMALLWORLD_GIS%\\..\\gas_distribution_office\\config\\gis_aliases -e %SMALLWORLD_GIS%\\config\\environment.bat dm_gdo_open -cli" "[%HOME%] runalias -a %SMALLWORLD_GIS%\\..\\gas_distribution_office\\config\\gis_aliases -e %SMALLWORLD_GIS%\\config\\environment.bat gdo_plotting_open -cli" "[%HOME%] runalias -a %SMALLWORLD_GIS%\\..\\cambridge_db\\config\\gis_aliases -e %SMALLWORLD_GIS%\\config\\environment.bat cambridge_db_open -cli" "[%HOME%] runalias -a %SMALLWORLD_GIS%\\..\\cambridge_db\\config\\gis_aliases -e %SMALLWORLD_GIS%\\config\\environment.bat cambridge_db_open_no_auth -cli" "[%HOME%] runalias -a %SMALLWORLD_GIS%\\..\\electric_office\\config\\gis_aliases -e %SMALLWORLD_GIS%\\config\\environment.bat eo_open -cli")))
 '(magik-transmit-method-eom-mode (quote end)))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;/////////////////////////////////////////////////////////////////////////////
;;
;;  GNU Emacs start-up file.  
;;
;;/////////////////////////////////////////////////////////////////////////////


;;////////////////////////////////////////
;; Abbreviations
;;////////////////////////////////////////

(define-abbrev global-abbrev-table "sv"      "load_file(\"C:/Users/212329983/Scripts/coe_setvars/source/setvars.magik\"); setvars()")
(define-abbrev global-abbrev-table "mom"      "sw_module_dialog.open()")

(define-abbrev global-abbrev-table "ldv"     "smallworld_product.add_product(
write_string(system.getenv(\"SMALLWORLD_GIS\"), \"/sw_core/modules/sw_dev_tools\") ); sw_module_manager.load_module( :dev_tools_application )")


;;////////////////////////////////////////////////////////////
;; Load Programmer Tags and set Key mappings
;;////////////////////////////////////////////////////////////

;;Define favourite gis-commands
;; FOr some reason the time-stamp.el is no longer found at new emacs -- so using
;; old is good enough for me
(load-file (concat (getenv "HOMEDRIVE") (getenv "HOMEPATH") "/custom-lisp/time-stamp.el"))



;;(setenv "ENV" nil)                      ; fix for subshells... -AJM? why???
;; Uncomment the next 4 lines to make numbered backups
;;(setq version-control t
;;      kept-old-versions 0
;;      kept-new-versions 2
;;      delete-old-versions t)
(setq inhibit-startup-message t)        ; shut up!

;;
;; Non specific programming control

(setq lpr-command "")                   ; print on NT requires printer-name correctly set too:
;;(setq printer-name "\\\\Sapphire\\HP LaserJet 4050 Series PS dev")
(setq-default abbrev-mode t)            ; enable global abbreviations
(setq visible-bell t)                   ; flash not beep
(setq fill-column 80)                   ; line wrap column
(auto-fill-mode 1)                      ; auto fill mode on  
(global-font-lock-mode t)               ; fontify all buffers
(setq line-number-display-limit nil)    ; Show line count for big files
(setq magik-method-name-mode t)         ; must be done before SW code loaded.

;;(require 'gnuserv)
;;(gnuserv-start)
;;(setq gnuserv-frame (selected-frame))

;; Key Bindings

(global-set-key [home] 'beginning-of-buffer)        ; top 
(global-set-key [end]  'end-of-buffer)              ; bottom
(global-set-key [f5]   "\e1\excompare-windows")     ; compare-windows ignoring whitespace
;; (global-set-key [f5]   'compare-windows)         ; compare-windows with whitespace   

;; Customisation from gui starts here




;;================ FRAME POSITION AND SIZE =========================
(set-frame-width (selected-frame) 120)
(set-frame-position (selected-frame) 100 50)
;;==================================================================

;;;////////////////////////////////////////
;;; Window colours
;;;////////////////////////////////////////
;; For a list of all available colours type: M-x list-colors-display
(set-background-color "black")
(set-foreground-color "gray")
(set-cursor-color "purple")
;;(set-mouse-color  "purple")
;; See also initial-frame-alist and default-frame-alist variables to
;; configure the initial and default (i.e. new frames using C-x 5 2) frame parameters
;; (setq default-frame-alist '((vertical-scroll-bars . right) (width . 80)))
;; (setq initial-frame-alist '((vertical-scroll-bars . right) (width . 80)))

(split-window)

;;--------------------------------------------------
;; Load Programmer Tags and set Key mappings
;;--------------------------------------------------
(defun insert-programmer-file-header-in-empty-buffer()
  ""
  (interactive)
  (if (not (equal (point-max) (point-min)))
      ()
      (insert-programmer-file-header)
      (not-modified)
    )
  )
;(load "smallworld-programmer-tags")
(add-hook 'magik-mode-hook 'insert-programmer-file-header-in-empty-buffer)
(setq programmer-tag "Tibor Karan, GE")
;(setq extra-programmer-created-note
;     "\t# (xx/xx/xx):REVIEWER reviewed.\n")
(global-set-key "\M-n" 'insert-programmer-note)
;(global-set-key "\M-c" 'insert-method-comment)
;(global-set-key "\M-m" 'mark-method-reviewed)
;(setq enable-code-reviewing nil)

(defun programmer-note ()
  "a string of date tag and programmer-tag."
  (interactive)
  (concat "# ("
	  (time-stamp-month-dd-yyyy)
	  " "
	  (if (equal nil programmer-tag)
	      (user-login-name)
	    programmer-tag)
	  "): "
	  )
  )

(defun insert-programmer-note ()
  "insert the start of a programmer note at point."
  (interactive)
  (insert (programmer-note))
  )

(defun insert-programmer-file-header ()
  ""
  (interactive)
  (goto-char (point-min))
    (insert (concat "#% text_encoding = iso8859_1\n\n"
			"_package user\n"
			"$\n\n"
			"########################################################################\n"
			"##\n"
			"## Last Saved Time-stamp: " (time-stamp-month-dd-yyyy) "\n"
			"##\n"
			"## Created By:  " programmer-tag "\n"
			"## Date: " (time-stamp-month-dd-yyyy) "\n"
			"## Copyright (C) 2018, GE All Rights Reserved.\n"
			"##\n"
			"## Description:\n"
			"##\n"
			"########################################################################\n\n"
		    )
	    )

  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Titlebar mods
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar sw-ver " [[[ ]]]")

;;; format for the title on the titlebar
(setq frame-title-format
              '(:eval
                (format "%s@%s: %s %s "
			(or (file-remote-p default-directory 'user)
                            user-real-login-name)
                        (or (file-remote-p default-directory 'host)
                            system-name)
                        (buffer-name)
                        (cond
                         (buffer-file-truename
                          (concat "(" buffer-file-truename ")"))
                         (dired-directory
                          (concat "{" dired-directory "}"))
                         (t
                          "[no file]")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Init plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elpa/neotree-20180616.1603/")
(require 'neotree)
(global-set-key [f12] 'neotree-toggle)

;; Using all-the-icons package
;;(add-to-list 'load-path "~/.emacs.d/elpa/memoize-20180614.1930/")
;;(require 'memoize)

;; Using all-the-icons package
;;(add-to-list 'load-path "~/.emacs.d/elpa/all-the-icons-20180125.1557/")
;;(require 'all-the-icons)
;;(require 'all-the-icons-dired)
;;(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FONTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-face-attribute 'default nil :font "Office Code Pro D Light" )
(set-frame-font "Office Code Pro D Light" nil t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PROXY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setq url-proxy-services 
;;      '(("no_proxy" . "work\\.com")
;;	("http" . "proxy.work.com:911")))

(setq url-proxy-services
      '(("http"     . "PITC-Zscaler-Americas-Alpharetta3pr.proxy.corporate.ge.com:80")
	("no_proxy" . "^.*\\(ge\\|bhge\\)\\.com")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Manager
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-initialize)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; ----------------------- TESTING
;; ----------------------- -------------------------------------------------------
;;
;;
;;
;; turn the blinking off
;;(blink-cursor-mode 0)

;;; turn off the tool-bar (<=0 off, >0 on)
;;(tool-bar-mode 0)

;;; turn off the menu bar (<=0 off, >0 on)
;;(menu-bar-mode 0) 


;;;======================================================================
;; Make Emacs behave like most X11 programs with regard to pasting
;; text. Paste at the point rather than where the mouse clicks when
;; pasting
;;;======================================================================
;;(when window-system (setq-default mouse-yank-at-point t))


;;;======================================================================
;;; get rid of the default messages on startup
;;;======================================================================
;;(setq initial-scratch-message nil)
;;(setq inhibit-startup-message t)
;;(setq inhibit-startup-echo-area-message t)


;;;////////////////////////////////////////
;;; Enable various commands that are disabled by default
;;;////////////////////////////////////////
;;(put 'narrow-to-region 'disabled nil)
;;(put 'upcase-region    'disabled nil)
;;(put 'eval-expression  'disabled nil)
;;(put 'downcase-region  'disabled nil)
;;(put 'erase-buffer     'disabled nil)

;;;////////////////////////////////////////
;;; Disable unwanted commands
;;;////////////////////////////////////////
;;(put 'backward-kill-sentence 'disabled t)


