;;; ac-emoji.el --- auto-complete source of Emoji

;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/emacs-ac-emoji
;; Version: 0.02
;; Package-Requires: ((auto-complete "1.5.0") (cl-lib "0.5"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; auto-complete source of Emoji. It is useful for writing markdown or
;; commit message which are uploaded to github.com

;;; Code:

(require 'cl-lib)
(require 'auto-complete)
(require 'ac-emoji-data)

(defgroup ac-emoji nil
  "auto-complete source of Emoji."
  :group 'auto-complete)

(defvar ac-emoji--candidates
  (cl-loop for emoji in ac-emoji--data
           collect
           (popup-make-item (plist-get emoji :key)
                            :document (plist-get emoji :description)
                            :summary (plist-get emoji :codepoint))))

;;;###autoload
(defun ac-emoji-setup ()
  (interactive)
  (add-to-list 'ac-sources 'ac-source-emoji))

(ac-define-source emoji
  '((candidates . ac-emoji--candidates)
    (prefix . ":\\S-+")))

(provide 'ac-emoji)

;;; ac-emoji.el ends here
