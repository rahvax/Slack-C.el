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

(defun slackc-project-new ()
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
      (insert
       "#include <stdio.h>\n\n"
       "int main(void){\n"
       "  printf(\"Hello, world!\\n\");\n"
       "  return 0;\n"
       "}\n"))

    (with-temp-file makefile
      (insert
       (format"
NAME=%s\n\
DIR=build\n\
FLAGS = -std=c17 -Wall -Wextra -Wpedantic -Iinclude\n\
DBGFLAGS = -g -O0 -DDEBUG\n\
RELFLAGS = -O2\n\
\n\
debug: src/main.c | $(DIR)\n\
\tgcc $(FLAGS) $(DBGFLAGS) src/*.c -o $(DIR)/debug/$(NAME)\n\
\n\
release: src/main.c | $(DIR)\n\
\tgcc $(FLAGS) $(RELFLAGS) src/*.c -o $(DIR)/release/$(NAME)\n\
\n\
test: debug\n\
\t./$(DIR)/debug/$(NAME)\n\
\n\
$(DIR):\n\
\t@mkdir -p $(DIR)/debug\n\
\t@mkdir -p $(DIR)/release\n"
        project-name)))
    (with-temp-file gitignore
      (insert
       "*.tmp\n"
       "*.el\n"
       "*.org\n"
       "build/\n"))
    (message "Projeto C criado em: %s" project-dir)))

(provide 'SlackC-Project)
;;; SlackC.el ends here

