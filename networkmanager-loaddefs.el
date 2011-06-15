;;; networkmanager-loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (networkmanager-mode networkmanager-connect-p)
;;;;;;  "networkmanager" "networkmanager.el" "1e2545ffcb5a847eaf56d750122278cf")
;;; Generated autoloads from networkmanager.el

(autoload 'networkmanager-connect-p "networkmanager" "\
Return non-nil if you connect networks.

\(fn)" nil nil)

(defvar networkmanager-mode nil "\
Non-nil if Networkmanager mode is enabled.
See the command `networkmanager-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `networkmanager-mode'.")

(custom-autoload 'networkmanager-mode "networkmanager" nil)

(autoload 'networkmanager-mode "networkmanager" "\
Integration with NetworkManager.

\(fn &optional ARG)" t nil)

;;;***

(provide 'networkmanager-loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; networkmanager-loaddefs.el ends here
