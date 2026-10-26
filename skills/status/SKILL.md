---
name: status
description: Publica uma atualização de status como comentário na task do ClickUp da branch atual e, quando o usuário pedir, troca o status da task (ex. para "em revisão"). Use quando o usuário quiser registrar, enviar ou atualizar o status, progresso ou andamento da task, mover a task de coluna/status, ou invocar /status.
---

# Status

Publica um comentário de status na task do ClickUp e, se o usuário ordenar, troca o status da task.

## 1. Identificar a task

O ID é o prefixo do nome da branch atual (ex. `FIN-1429/ajusta-calculo` → `FIN-1429`).
Se o usuário informar outro ID no pedido, use o informado.
Se a branch não seguir o padrão e nenhum ID for informado, pergunte.

## 2. Montar o texto

Formato:

```
dia DD/MM - <status>
```

Use a data de hoje, obtida com `date +%d/%m`.

**Se o usuário escreveu o status:** mantenha as palavras dele. Corrija apenas erros de digitação e pontuação. Não reescreva, não resuma, não acrescente informação.

**Se o usuário só invocou `/status`, sem texto:** proponha um rascunho com base no que foi feito nesta sessão e, se existir, em `.harness/tasks/<ID>.md`. Escreva em primeira pessoa, no mesmo tom do exemplo abaixo, em 1 a 3 frases: o que foi feito, onde está e qual o próximo passo.

Exemplo de tom:

```
dia 26/10 - realizei o estudo da task e consegui avançar no entendimento do que precisa ser implementado, já possuo um plano de ação e amanhã iniciarei a implementação
```

Nunca inclua dados de clientes, tokens, URLs internas ou trechos de código no status.

## 3. Troca de status (somente se ordenada)

Só troque o status da task quando o usuário pedir explicitamente (ex. "move para em revisão", "muda o status para done").
Nunca deduza a troca a partir do texto do comentário: "amanhã iniciarei a implementação" não é uma ordem para mudar o status.

Quando houver a ordem:

1. Busque a task no MCP do ClickUp e obtenha o status atual e os status disponíveis na lista dela.
2. Relacione o pedido a um status válido, ignorando caixa e acentos.
   - Correspondência única: use-a.
   - Nenhuma ou mais de uma: mostre os status disponíveis e pergunte qual usar.
3. Se a task já estiver no status pedido, avise e não altere.

Também é possível trocar só o status, sem comentário (ex. "/status move para em revisão"). Nesse caso, pule o passo 2.

## 4. Confirmar antes de publicar

O comentário e a troca de status ficam visíveis para o time. Mostre tudo junto e aguarde uma única confirmação:

```
Task: <ID>
Comentário: dia DD/MM - <status>
Status: <atual> → <novo>
```

Omita as linhas que não se aplicam. Se o usuário ajustar algo, use a versão dele.

## 5. Publicar

1. Publique o comentário com a ferramenta de criação de comentário do MCP do ClickUp.
2. Se houver troca de status, atualize a task com a ferramenta de atualização de task do MCP.

Se o MCP não estiver disponível ou alguma etapa falhar, diga exatamente o que foi feito e o que falhou, e mostre o que o usuário precisa fazer manualmente.

## 6. Registrar localmente

Se existir `.harness/tasks/<ID>.md`:

- adicione o comentário publicado ao final, em uma seção `## Histórico de status` (crie a seção se não existir)
- se o status mudou, registre também: `dia DD/MM - status: <atual> → <novo>`
- atualize o campo **Status** no topo do documento

Responda em uma linha: o que foi publicado na task `<ID>` (comentário, troca de status ou ambos).
