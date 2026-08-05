## Forgejo
Estou utilizando o Forgejo para programar esse projeto. O Github está servindo apenas de vitrine para o projeto. Você pode conferir os commits pelo Github normalmente, pois estou usando o método `Push Mirror`.

# Slack-C.el 
A ideia é apenas automatizar as criações de repositórios de C para meu Forgejo, evitando ter que repetir sempre. Geralmente costumo usar o mesmo padrão de makefile e diretório para programar, editando quando preciso. Esse projeto cria um pacote para o Emacs, enquanto me aprofundo, para automatizar a criação de projetos.

## Makefile
```makefile
NAME=              # Nome do binario
DIR=build
FLAGS =            # Flags padrões do compilador
DBGFLAGS =         # Flags para debug (+ flag para macros de debug)
RELFLAGS =         # Flags para a versão final

# Compilação para debug: flags mais rígidas e flag para funções de macro
debug: src/main.c | $(DIR)
	gcc $(FLAGS) $(DBGFLAGS) src/*.c -o $(DIR)/debug/$(NAME)

# Compilação final: flags para otimização
release: src/main.c | $(DIR)
	gcc $(FLAGS) $(RELFLAGS) src/*.c -o $(DIR)/release/$(NAME)

# Testar a compilação de debug
test: debug
	./$(DIR)/debug/$(NAME)

# Verificação para garantir os diretórios
$(DIR):
	@mkdir -p $(DIR)/debug
	@mkdir -p $(DIR)/release

```