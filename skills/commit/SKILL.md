---
name: commit
description: Cria um commit local do bloco implementado, com mensagem baseada no diff e no contexto da task (.harness/tasks/<ID>.md). Use quando o usuário pedir para commitar ou salvar o progresso no git, quando a skill revisao receber permissão para commitar, ou ao invocar /commit.
---

# Commit

Commita o bloco implementado com uma mensagem que explique o que mudou e por quê.

## 1. Reunir o contexto

1. O ID da task é o prefixo da branch atual (ex. `FIN-1429/ajusta-calculo` → `FIN-1429`).
2. Se existir `.harness/tasks/<ID>.md`, leia o Objetivo, as Decisões e o Andamento.
3. Rode `git status`, `git diff`, `git diff --cached` e `git log --oneline -10` para ver as mudanças e a convenção de mensagens do repositório.

Se a branch atual for a padrão do repositório (`master`/`main`), pare e avise: não se commita direto nela.

## 2. Definir o que entra

- Entram só os arquivos do bloco implementado, incluindo os gerados por codegen junto com a sua origem.
- Nunca entram: `.harness/`, `.env`, arquivos com secrets, artefatos temporários ou de debug.
- Se houver mudanças sem relação com o bloco, liste-as e pergunte se entram, ficam de fora ou vão em outro commit.
- Adicione os arquivos pelo nome. Nunca use `git add -A` ou `git add .`.

## 3. Escrever a mensagem

- **Assunto:** siga a convenção do `git log` (ex. `feat: ...`, `fix: ...`), no idioma dos commits recentes, com até 72 caracteres, dizendo o que mudou.
- **Corpo:** o porquê, com o ID da task, e em tópicos o que foi feito. Use o documento da task para o contexto de negócio; não copie o diff.
- Sem dados de clientes, tokens, URLs internas ou trechos de código.
- Se o ambiente definir linhas de atribuição (ex. `Co-Authored-By`), inclua-as no fim.

Se a revisão deste bloco não rodou nesta sessão, ou algum teste falhou, diga isso na prévia.

## 4. Confirmar

Mostre e aguarde confirmação:

```
Branch: <branch>
Arquivos:
  <arquivo>
Mensagem:
  <assunto>

  <corpo>
```

Se o usuário ajustar a mensagem ou os arquivos, use a versão dele.

## 5. Commitar

- `git add <arquivos>` e `git commit -F -` com a mensagem via heredoc.
- Nunca use `--amend`, `--no-verify`, rebase ou push.
- Se um hook falhar, mostre a saída, corrija se o problema for do bloco e crie um commit novo.

## 6. Registrar localmente

Se existir `.harness/tasks/<ID>.md`, adicione `- <hash curto> <assunto>` à seção `## Commits` (crie se não existir).

Responda em uma linha: hash e assunto do commit. Sugira `/status` se o bloco fechar uma etapa da task.
