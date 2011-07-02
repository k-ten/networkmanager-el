;;; networkmanager.el --- define hooks which run after changing a status of network

;; Copyright (C) 2010, 2011  Hironori OKAMOTO

;; Author: Hironori OKAMOTO <k.ten87@gmail.com>
;; Keywords: comm, convenience, unix

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

(require 'dbus)

;;; Code:
(defgroup networkmanager nil
  ""
  :group 'convenience
  :prefix "networkmanager-")

(defcustom networkmanager-connect-hook nil
  "Hook run after connecting networks."
  :type 'hook
  :group 'networkmanager)

(defcustom networkmanager-disconnect-hook nil
  "Hook run after disconnecting networks."
  :type 'hook
  :group 'networkmanager)

(defconst networkmanager-service "org.freedesktop.NetworkManager")
(defconst networkmanager-path "/org/freedesktop/NetworkManager")
(defconst networkmanager-interface "org.freedesktop.NetworkManager")

(defvar networkmanager-dbus-registration nil)

(defun networkmanager-state-connect-p (state)
  (and (numberp state)
       (= state 3)))

(defun networkmanager-dbus-signal-handler (state)
  (if (networkmanager-state-connect-p state)
      (run-hooks 'networkmanager-connect-hook)
    (run-hooks 'networkmanager-disconnect-hook)))

;;;###autoload
(defun networkmanager-connect-p ()
  "Return non-nil if you connect networks."
  (networkmanager-state-connect-p
   (dbus-get-property :system
		      networkmanager-service
		      networkmanager-path
		      networkmanager-interface
		      "State")))

;;;###autoload
(define-minor-mode networkmanager-mode
  "Integration with NetworkManager."
  :global t
  (if networkmanager-mode
      (unless networkmanager-dbus-registration
	(setq networkmanager-dbus-registration
	      (dbus-register-signal :system
				    networkmanager-service
				    networkmanager-path
				    networkmanager-interface
				    "StateChanged"
				    'networkmanager-dbus-signal-handler)))
    (when networkmanager-dbus-registration
      (dbus-unregister-object networkmanager-dbus-registration)
      (setq networkmanager-dbus-registration nil))))

(provide 'networkmanager)

;;; networkmanager.el end here
