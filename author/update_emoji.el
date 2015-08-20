;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>

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

;;; Code:

(require 'cl-lib)
(require 'json)

(defconst emoji-db-url "https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json")

(defun collect-emojis ()
  (with-temp-buffer
    (unless (process-file "curl" nil t nil "-sL" emoji-db-url)
      (error "Failed: 'curl -sL %s'" emoji-db-url))
    (let ((emojis (json-read-from-string (buffer-string))))
      (setq caos emojis)
      (cl-loop for emoji across emojis
               for str = (assoc-default 'emoji emoji)
               when str
               collect
               (let ((codepoint (string-to-char str))
                     (alias (aref (assoc-default 'aliases emoji) 0)))
                 (list :key alias :codepoint codepoint))))))

(defun dump-emoji (emojis)
  (princ ";; This file is generated automatically. Don't change this file !!\n")
  (princ "(defvar ac-emoji--data\n")
  (princ "  '(")
  (cl-loop for emoji in emojis
           for key = (plist-get emoji :key)
           for codepoint = (plist-get emoji :codepoint)
           do
           (princ (format "    (\":%s:\" . \"\\x%x\")\n" key codepoint)))
  (princ "))\n")
  (princ "(provide 'ac-emoji-data)"))

(dump-emoji (collect-emojis))
