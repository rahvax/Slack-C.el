;;; SlackC.el --- Criando projetos em C pré-configurados -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Gabriel Caelestis

;; Author: Gabriel Caelestis <gabriel@caelestis.one>
;; Version: 0.0.1
;; Package-Requires: ((emacs "30.2"))
;; Keywords: clang, git, Forgejo
;; URL: https://github.com/rahvax/slackc-project.git

;;; Commentary:
;;; Code:
(defgroup diretorio nil
  "Configurações para o diretorio."
  :group 'dir
  :prefix "dir-")
(defcustom dir-path "~/Documents/Forgejo/"
  "O PATH padrão onde o projeto vai ser criado."
  :type 'string
  :group 'dir)

(defun create-c-dir ()
  "Criar o projeto de C."
  (interactive)
  (let* ((project-name (read-from-minibuffer "Nome: "))
         (project-dir (expand-file-name project-name dir-path))
         (src-dir (expand-file-name "src/" project-dir))
         (include-dir (expand-file-name "include/" project-dir))
         (main-file (expand-file-name "src/main.c" project-dir))
         (makefile (expand-file-name "makefile" project-dir))
         (gitignore (expand-file-name ".gitignore" project-dir)))
    (message "Projeto C criado em: %s" project-dir)))

(provide 'SlackC-Project)
;;; SlackC.el ends here

