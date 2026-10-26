---
name: task
description: Inicia o trabalho em uma task do ClickUp a partir do custom ID (ex. FIN-1429). Cria a branch no padrão do usuário e um documento temporário de contexto. Use quando o usuário informar um ID de task no formato PREFIXO-NÚMERO ou invocar /task.
---

# Task

Entrada: custom ID da task no ClickUp (ex. `FIN-1429`). Se não vier no pedido, pergunte.

## 1. Buscar a task

Use a ferramenta de busca de task do MCP do ClickUp com o custom ID.
Colete: nome, descrição, status, responsáveis, critérios de aceite, subtasks, tasks vinculadas/dependências, anexos (só nomes) e comentários.

Se o MCP do ClickUp não estiver disponível ou a task não for encontrada, pare e avise. Não invente contexto.

## 2. Criar a branch

Padrão: `<ID>/<slug>` — ex. `FIN-1429/ajusta-calculo-taxa-pix`

Regras do slug:

- derivado do nome da task, no mesmo idioma dela
- minúsculas, kebab-case, sem acentos nem caracteres especiais
- 3 a 6 palavras, sem artigos e preposições
- o ID mantém a caixa original (`FIN-1429`, não `fin-1429`)

Antes de criar:

1. Se houver alterações não commitadas, pare e pergunte o que fazer.
2. Identifique a branch padrão do repositório, rode `git fetch` e crie a branch a partir dela atualizada.
3. Se já existir uma branch com o mesmo ID (local ou remota), não crie outra: mostre a existente e pergunte se deve fazer checkout.

Não faça push.

## 3. Criar o documento de contexto

Caminho: `.harness/tasks/<ID>.md` na raiz do repositório.

Garanta que `.harness/` esteja em `.git/info/exclude` (exclusão local, nada é commitado). Adicione a linha se não existir. Não altere o `.gitignore` do projeto.

Conteúdo:

```markdown
# <ID> — <nome da task>

- **Link:** <url da task>
- **Status:** <status>
- **Branch:** <ID>/<slug>
- **Criado em:** <AAAA-MM-DD>

## Problema

- **Situação atual:** <o que acontece hoje>
- **Comportamento esperado:** <o que deveria acontecer>
- **Impacto:** <quem é afetado e como>
- **Onde ocorre:** <tela, fluxo, serviço ou pipeline envolvido>
- **Como reproduzir:** <passos, se for bug; senão "Não se aplica">

## Objetivo

<resumo em 2-3 frases do que precisa ser feito e por quê>

## Critérios de aceite

<lista extraída da task; se não houver, escreva "Não definidos na task">

## Contexto relevante

<pontos importantes da descrição e dos comentários; resuma, não copie>

## Dependências e tasks vinculadas

<ids e nomes, ou "Nenhuma">

## Lacunas

<o que está ambíguo ou faltando na task e precisa ser esclarecido>

## Revisão

<resultado da revisão analítica do passo 4>
```

Ao escrever o documento:

- Não copie dados de clientes, e-mails, telefones, documentos ou tokens que apareçam na task. Substitua por `[removido]`.
- A seção **Lacunas** é obrigatória e deve ser honesta; é ela que alimenta a análise seguinte.
- No **Problema**, escreva só o que a task sustenta. Se um campo não puder ser preenchido com base nela, escreva "Não informado na task" e registre em Lacunas.

## 4. Revisar o documento

Releia o documento como um revisor cético, não como quem o escreveu. Verifique:

1. **Rastreabilidade:** cada afirmação vem da task? Marque com `(inferido)` o que for dedução sua e não estiver explícito.
2. **Coerência:** o Objetivo resolve o Problema descrito? Os Critérios de aceite comprovam que o Objetivo foi atingido?
3. **Completude:** falta algo que impediria começar a implementar? Se sim, vai para Lacunas.
4. **Contradições:** descrição, comentários e critérios dizem coisas diferentes? Registre qual versão foi usada e por quê.
5. **Escopo:** o documento está maior que a task? Remova o que não foi pedido.

Corrija o documento com base no que encontrar e preencha a seção **Revisão** com:

- o que foi ajustado
- o nível de confiança no entendimento: Alto, Médio ou Baixo, com uma frase de justificativa

Se a confiança for Baixa, diga isso no fechamento e recomende esclarecer as lacunas antes do `/analise`.

## 5. Finalizar

Responda em poucas linhas: branch criada, caminho do documento, nível de confiança e as lacunas encontradas.
Sugira rodar `/analise` em seguida. A skill `analise` deve ler `.harness/tasks/<ID>.md` se existir.
