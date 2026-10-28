---
name: pr
description: Cria o Pull Request da implementação da branch atual com o template do time — título padronizado, labels, contexto, testes executados e espaço para vídeos. Use quando o usuário pedir para abrir, criar ou preparar o PR, ou invocar /pr.
---

# PR

Cria o Pull Request da branch atual com `gh`.

## 1. Pré-checagens

1. Se houver alterações não commitadas, pare e pergunte o que fazer.
2. Se já existir um PR aberto para esta branch (`gh pr view`), mostre o link e pergunte se deve atualizar título, labels e descrição em vez de criar outro.
3. Identifique a branch base (branch padrão do repositório, salvo se o usuário indicar outra).

## 2. Reunir contexto

- **ID da task:** prefixo do nome da branch (ex. `FIN-1429/...` → `FIN-1429`).
- **Documento da task:** `.harness/tasks/<ID>.md`, se existir. Use Problema, Objetivo e Histórico de status.
- **Mudanças reais:** `git log <base>..HEAD` e `git diff <base>...HEAD --stat`, lendo os arquivos alterados quando precisar entender o que mudou.
- **Task no ClickUp:** via MCP, busque o link da task e se há issue ou task relacionada.

A descrição do PR deve refletir o que está no diff. Se o documento da task disser algo que o código não fez, siga o código e avise o usuário.

## 3. Título

Formato:

```
[Financeiro][<Módulo>] <tipo>: <emoji> <descrição>
```

Exemplo:

```
[Financeiro][Link de pagamento] feat: ✨ banners de destaque do link de pagamento no pedido de venda
```

- **`[Financeiro]`:** sempre.
- **`[<Módulo>]`:** módulo ou domínio alterado (ex. Link de pagamento, Conta Digital, Extrato), com iniciais maiúsculas só na primeira palavra e em nomes próprios. Deduza pelos arquivos alterados e pela task; se houver dúvida, pergunte.
- **Tipo e emoji:**

| Tipo       | Emoji | Quando                                      |
| ---------- | ----- | ------------------------------------------- |
| `feat`     | ✨    | nova funcionalidade                         |
| `fix`      | 🐛    | correção de bug                             |
| `hotfix`   | 🚑️    | correção urgente em produção                |
| `refactor` | ♻️    | mudança de código sem alterar comportamento |
| `perf`     | ⚡️    | melhoria de performance                     |
| `style`    | 💄    | ajuste visual/UI sem mudança de lógica      |
| `test`     | ✅    | só testes                                   |
| `docs`     | 📝    | só documentação                             |
| `ci`       | 👷    | pipelines e CI/CD                           |
| `chore`    | 🔧    | configuração, dependências, manutenção      |

- **Descrição:** em minúsculas, no presente, dizendo o que o PR entrega para quem usa — não como foi feito.

## 4. Labels

- `Financeiro`: sempre.
- `Conta Digital`: **somente** quando o usuário disser que é de Conta Digital. Não deduza pelo código.

Confira com `gh label list` se as labels existem. Se alguma não existir, avise; não crie labels.

## 5. Descrição

Use exatamente este template:

```markdown
### 🚀 O que está incluído neste PR?

- <mudança> — `<arquivo ou módulo>`

---

### 📊 Como isso foi testado?

- <cenário testado>

| <Cenário 1>                | <Cenário 2>                | <Cenário 3>                |
| -------------------------- | -------------------------- | -------------------------- |
| <!-- cole o vídeo aqui --> | <!-- cole o vídeo aqui --> | <!-- cole o vídeo aqui --> |

---

### 📝 Checklist de validação

- [ ] Testes unitários cobrem a nova feature
- [ ] Testado manualmente em ambiente local
- [ ] Lint aprovado

---

### 🔗 Links relacionados

- `Issue`: <link>
- `Task`: [<ID>](<link da task no ClickUp>)
```

Como preencher:

- **O que está incluído:** um bullet por mudança relevante, citando onde foi feita. Agrupe mudanças pequenas do mesmo arquivo. Nada de detalhes de implementação que não ajudem o revisor.
- **Como foi testado:** liste só cenários que foram de fato testados — na sessão, no Plano de validação aprovado ou informados pelo usuário. Se não souber o que foi testado, pergunte. Nunca invente cenários.
- **Tabela de vídeos:** uma coluna por cenário que tem demonstração visual, com o nome curto do cenário no cabeçalho. Deixe as células com o comentário `<!-- cole o vídeo aqui -->`, que não aparece no PR renderizado.
- **Checklist:** marque `[x]` apenas no que foi verificado:
  - _Testes unitários_ e _Lint_: rode os scripts de teste e lint do projeto. Marque se passarem. Se falharem, pare e mostre o erro antes de criar o PR.
  - _Testado manualmente_: marque apenas se o usuário confirmou.
- **Issue:** inclua se a task tiver issue ou task relacionada no ClickUp; caso contrário, remova a linha.
- **Task:** sempre, com o ID e o link.

Nunca inclua dados de clientes, tokens, credenciais ou URLs de ambientes internos na descrição.

## 6. Confirmar

Mostre título, labels, branch base e descrição completa. Aguarde confirmação. Se o usuário ajustar algo, use a versão dele.

## 7. Criar

1. Se a branch não existir no remoto, faça `git push -u origin <branch>`. Nunca use `--force`.
2. Salve a descrição em `.harness/tasks/<ID>-pr.md` e crie o PR como **draft**, para os vídeos serem adicionados antes da revisão:

```bash
gh pr create --draft --base <base> --title "<título>" --body-file .harness/tasks/<ID>-pr.md --label "Financeiro"
```

Acrescente `--label "Conta Digital"` quando aplicável.

## 8. Finalizar

- Registre o link do PR no documento `.harness/tasks/<ID>.md`, no campo **PR** do topo (crie o campo se não existir).
- Responda em poucas linhas: link do PR e lembrete para colar os vídeos e marcar como "Ready for review" (`gh pr ready`).
- Sugira `/status` para avisar na task que o PR foi aberto.
