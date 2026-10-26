# Automação do plugin perro
# Uso: make release [BUMP=patch|minor|major] [MSG="mensagem"]

MARKETPLACE := perro
PLUGIN      := perro
PLUGIN_JSON := .claude-plugin/plugin.json
BUMP        ?= patch
MSG         ?= atualiza plugin

.PHONY: help check bump commit update release dev version

help: ## Lista os comandos
	@grep -E "^[a-z]+:.*##" $(MAKEFILE_LIST) | awk -F":.*## " "{printf \"  %-10s %s\\n\", \$$1, \$$2}"

version: ## Mostra a versão atual
	@python3 -c "import json;print(json.load(open(\"$(PLUGIN_JSON)\"))[\"version\"])"

check: ## Valida JSONs e frontmatter das skills
	@python3 -m json.tool $(PLUGIN_JSON) > /dev/null && echo "ok  $(PLUGIN_JSON)"
	@python3 -m json.tool .claude-plugin/marketplace.json > /dev/null && echo "ok  marketplace.json"
	@for f in skills/*/SKILL.md; do \
		head -1 $$f | grep -q "^---$$" && grep -q "^name:" $$f && grep -q "^description:" $$f \
			&& echo "ok  $$f" || { echo "ERRO frontmatter: $$f"; exit 1; }; \
	done

bump: ## Incrementa a versão (BUMP=patch|minor|major)
	@python3 -c "import json,sys;p=\"$(PLUGIN_JSON)\";d=json.load(open(p));v=[int(x) for x in d[\"version\"].split(\".\")];i={\"major\":0,\"minor\":1,\"patch\":2}[\"$(BUMP)\"];v[i]+=1;v[i+1:]=[0]*(2-i);d[\"version\"]=\".\".join(map(str,v));json.dump(d,open(p,\"w\"),indent=2,ensure_ascii=False);open(p,\"a\").write(\"\\n\");print(\"versão:\",d[\"version\"])"

commit: ## Commita as mudanças
	@git add -A
	@git diff --cached --quiet && echo "nada para commitar" || git commit -m "$(MSG) (v$$($(MAKE) -s version))"

update: ## Atualiza o plugin instalado no Claude Code
	@if claude plugin --help > /dev/null 2>&1; then \
		claude plugin marketplace update $(MARKETPLACE) && echo "plugin atualizado — abra uma nova sessão"; \
	else \
		echo "CLI sem subcomando plugin. Rode dentro do Claude Code:"; \
		echo "  /plugin marketplace update $(MARKETPLACE)"; \
	fi

release: check bump commit update ## Valida, versiona, commita e atualiza

dev: ## Abre o Claude Code com a versão local, sem instalar
	claude --plugin-dir $(CURDIR)