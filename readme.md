## Forgejo
Estou utilizando o Forgejo para programar esse projeto. O Github está servindo apenas de vitrine para o projeto. Você pode conferir os commits pelo Github normalmente, pois estou usando o método `Push Mirror`.

# Slack-C.el 
A ideia é apenas automatizar as criações de repositórios de C para meu Forgejo, evitando ter que repetir sempre. Geralmente costumo usar o mesmo padrão de makefile e diretório para programar, editando quando preciso. Esse projeto cria um pacote para o Emacs, enquanto me aprofundo, para automatizar a criação de projetos.

## Templates
Você pode editar os templates que serão carregados em um projeto C pelos arquivos `main.template`, `makefile.template` e `gitignore.template` dentro do diretório de `templates/`. Na próxima atualização será criado uma personalização para quem quiser trocar o arquivo de template carregável para outro diretório e permitir organização própria.

### Makefile padrão
Acredito que seja o único que merece uma explicação melhor, por enquanto. É assim que geralmente eu produzo algoritmos editando apenas alguma necessidade ou outra. Até então considero uma boa configuração de makefile, e no futuro posso trocar.
```makefile
NAME=              # Nome do binario
DIR=               # Diretório das builds
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
# Aqui você poderia personalizar comandos extras ou argumentos
test: debug
	./$(DIR)/debug/$(NAME)

# Verificação para garantir os diretórios
$(DIR):
	@mkdir -p $(DIR)/debug
	@mkdir -p $(DIR)/release

```