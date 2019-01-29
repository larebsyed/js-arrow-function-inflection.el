;;; js-arrow-function-inflection.el --- The package provides a couple of function to convert javascript es6 arrow function to normal functions and vice versa  -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Lareb Syed
;;
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;; ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;; OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;; LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;; OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;; SUCH DAMAGE.


;; Author: Lareb Syed <lareb@inventionist>
;; URL: https://github.com/knu/replace-with-inflections.el
;; Created: 29 Jan 2019
;; Version: 1.0.0
;; Package-Requires: ((cl-lib "0.5") (string-inflection "1.0.10") (inflections "1.1"))
;; Keywords: lisp, tools, matching
;;; Commentary:

;; The package provides * `js-arrow-function-inflections'
;; It has provides access to three functions
;;
;; `js-arrow-function-inflection-convert-to-arrow-function'
;; Used to convert normal function to arrow function in javascript es6
;; For further info get doc-string for this `js-arrow-function-inflection-convert-to-arrow-function'
;;
;; `js-arrow-function-inflection-convert-to-function'
;; Used to convert arrow function to normal function in javascript es6
;; For further info get doc-string for `js-arrow-function-inflection-convert-to-function'
;;
;; `js-arrow-function-inflection-toggle'
;; Used to toggle between the two forms of function in javascript es6
;;; Code:

;;;###autoload
(defun js-arrow-function-inflection-convert-to-arrow-function ()
  "\ Interactively convert the simple function to arrow function
     The function matches the current line and tries to find a pattern like \"()={\"

     Examples:
      () {} -> () => {}
      function abc () {} -> const abc = () => {}
      abc () {} -> abc =() => {}
      function abc (x, y) {} => const abc (x, y) => {}
  "
  (interactive)
  (save-excursion
    (unless (save-excursion
              (re-search-forward "\\(const\\|var\\|let\\)?\s*\\w*\s*\\(=\s*\\)?\\((\\).*\\()\\)\s*\\(\s*=>\s*\\)" (line-end-position) t))
      (if (re-search-forward "\\(function\\)?\\(\s*\\w*\s*(\\)?.*\\()\s*\\){" (line-end-position) t)
          (progn (cond ((match-string 1)
                        (replace-match "const" nil nil nil 1)))
                 (cond ((and (match-string 2)
                             (string-match-p  "\\w\s*("  (match-string 2)))
                        (replace-match (replace-regex-in-string "(" "= (" (match-string 2)) nil nil nil 2)))
                 (replace-match ") => " nil nil nil 3)
                 t)
        nil))))

;;;###autoload
(defun js-arrow-function-inflection-convert-to-function ()
  "\ Interactively convert the simple function to arrow function
     The function matches the current line and tries to find a pattern like \"()={\"

     Examples:
      () => {} -> () {}
      const abc = () => {} -> function abc () {}
      abc =() => {} -> abc () {}
      const abc (x, y) => {} => function abc (x, y) {}
  "
  (interactive)
  (save-excursion (cond ((re-search-forward "\\(const\\|var\\|let\\)?\s*\\w*\s*\\(=\s*\\)?\\((\\).*\\()\\)\s*\\(\s*=>\s*\\){" (line-end-position) t)
                         (cond ((match-string 1)
                                (replace-match "function" nil nil nil 1)))
                         (cond ((match-string 2)
                                (replace-match "" nil nil nil 2)))
                         (replace-match "" nil nil nil 5)
                         t
                         ))))

;;;###autoload
(defun js-arrow-function-inflection-toggle ()
  "Toggle between Arrow function and normal javascript function"
  (interactive)
  (cond ((js-arrow-function-inflection-convert-to-arrow-function) t)
        ((js-arrow-function-inflection-convert-to-function) t)
        (t nil)
        ))

(provide 'js-arrow-function-inflections)
;;; js-arrow-function-inflections.el ends here
