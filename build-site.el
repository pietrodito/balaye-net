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
             :publishing-directory "../pietrodito.github.io"
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
                     "<link rel=\"shortcut icon\" type=\"image/png\" href=\"img/favicon.png\" />"
                     "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />"
                     "<link rel=\"stylesheet\" href=\"./css/ulys.css\" />"
                     "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css\">"
                     "<header>"
                     "      <h1><code>balaye.net</code></h1>"
                     "      <p>A personal eclectic domain.</p>"
                     "      <nav>"
                     "  <a href=\"./index.html\"><i class=\"fas fa-home\"></i> Home</a>"
                     "  <a href=\"./snds-blog/\"><i class=\"fas fa-stethoscope\"></i> SNDS Blog</a>"
                     "  <a href=\"./comp-blog/\"><i class=\"fas fa-laptop-code\"></i> Linux Blog</a>"
                     "  <a href=\"https://stackoverflow.com/users/6537892/pietrodito\"><i class=\"fab fa-stack-overflow\"></i> Stack Overflow</a>"
                     "  <a href=\"https://github.com/pietrodito\"><i class=\"fab  fa-github\"></i> Github</a>"
                     "  <a href=\"./guitar-repertoire.html\"><i class=\"fas  fa-guitar\"></i> Guitar</a>"
                     "  <a href=\"./how-to.html\"><i class=\"fa-solid fa-screwdriver-wrench\"></i> Making of</a>"
                     "  <a href=\"./contact.html\"><i class=\"fas fa-address-book\"></i> Contact</a>"
                     "      </nav>"
                     "</header>"
                     ))



;; Generate the site output"
(org-publish-all t)
(message "Build complete!")
