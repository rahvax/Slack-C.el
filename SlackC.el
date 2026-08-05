;;; SlackC.el --- Criando projetos em C pré-configurados -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Gabriel Caelestis

;; Author: Gabriel Caelestis <gabriel@caelestis.one>
;; Version: 0.0.1
;; Package-Requires: ((emacs "30.2"))
;; Keywords: clang, git, Forgejo
;; URL: https://github.com/rahvax/slack-c.el.git

;;; Commentary:
;;; Abrir um diretório para projetos em C de forma genérica e configurável.
;;; Code:
(defgroup SlackC-directory nil
  "Configurações para o diretorio."
  :group 'slackc-dir
  :prefix "dir-")
(defcustom dir-path "~/Documents/Forgejo/"
  "O PATH padrão onde o projeto vai ser criado."
  :type 'string
  :group 'slackc-dir)

(defun slackc-new-project ()
  "Criar o projeto de C."
  (interactive)
  (let* ((project-name (read-from-minibuffer "Nome: "))
         (project-dir (expand-file-name project-name dir-path))
         (src-dir (expand-file-name "src/" project-dir))
         (include-dir (expand-file-name "include/" project-dir))
         (main-file (expand-file-name "src/main.c" project-dir))
         (makefile (expand-file-name "makefile" project-dir))
         (gitignore (expand-file-name ".gitignore" project-dir)))

    (make-directory src-dir t)
    (make-directory include-dir t)

    (with-temp-file main-file
      (insert-file-contents "main.template"))

    (let ((make-template
	   (with-temp-buffer
	     (insert-file-contents "makefile.template")
	     (buffer-string))))
    (with-temp-file makefile
      (insert (format make-template project-name))))

    (with-temp-file gitignore
      (insert
       "*.tmp\n"
       "*.el\n"
       "*.org\n"
       "build/\n"))
    
    (message "Projeto %s criado em: %s" project-name project-dir)))

(provide 'Slack-C.el)
;;; SlackC.el ends here
