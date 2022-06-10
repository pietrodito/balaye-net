;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(with-eval-after-load 'ox
   (setq org-export-allow-bind-keywords t))

;; Load the publishing system
(require 'ox-publish)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             ;; Source and destinations
             :base-directory "./content"
             :publishing-directory "./public"
             ;; Selecting files
             :recursive t
             ;; Publishing action
             :publishing-function 'org-html-publish-to-html
             ;; Publishing options
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head (concat
                     "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />"
                     "<header>"
                     "      <h1><code>balaye.net</code></h1>"
                     "      <p>A personal website dispatcher.</p>"
                     "      <nav>"
                     "  <a href=\"./index.html\">Home</a>"
                     "  <a href=\"https://github.com/pietrodito\">Github</a>"
                     "  <a href=\"./snds.html\">SNDS</a>"
                     "  <a href=\"./how-to.html\">Making of</a>"
                     "  <a href=\"./contact.html\">Contact</a>"
                     "      </nav>"
                     "</header>"
                     ))

;; Generate the site output"
(org-publish-all t)
(message "Build complete!")
