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
  (let* ((project-name (read-from-minibuffer "Nome:")))

    (unless (file-directory-p (concat dir-path project-name))
      (make-directory (concat dir-path project-name)))
    (with-temp-file (concat dir-path project-name "/main.c")
      (insert "#include <stdio.h>"))
    (message "Criado %s" (concat dir-path project-name)))
  )
(provide 'SlackC-Project)
;;; SlackC.el ends here
