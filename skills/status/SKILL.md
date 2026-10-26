---
name: status
description: Publica uma atualização de status como comentário na task do ClickUp da branch atual. Use quando o usuário quiser registrar, enviar ou atualizar o status, progresso ou andamento da task, ou invocar /status.
---

# Status

Publica um comentário de status na task do ClickUp.

## 1. Identificar a task

O ID é o prefixo do nome da branch atual (ex. `FIN-1429/ajusta-calculo` → `FIN-1429`).
Se o usuário informar outro ID no pedido, use o informado.
Se a branch não seguir o padrão e nenhum ID for informado, pergunte.

## 2. Montar o texto

Formato:

```
**DD/MM** - <status>
```

Use a data de hoje, obtida com `date +%d/%m`.

**Se o usuário escreveu o status:** mantenha as palavras dele. Corrija apenas erros de digitação e pontuação. Não reescreva, não resuma, não acrescente informação.

**Se o usuário só invocou `/status`, sem texto:** proponha um rascunho com base no que foi feito nesta sessão e, se existir, em `.harness/tasks/<ID>.md`. Escreva em primeira pessoa, no mesmo tom do exemplo abaixo, em 1 a 3 frases: o que foi feito, onde está e qual o próximo passo.

Exemplo de tom:

```
**26/10** - realizei o estudo da task e consegui avançar no entendimento do que precisa ser implementado, já possuo um plano de ação e amanhã iniciarei a implementação
```

Nunca inclua dados de clientes, tokens, URLs internas ou trechos de código no status.

## 3. Confirmar antes de publicar

O comentário fica visível para o time, então mostre o texto final e o ID da task e aguarde confirmação.
Se o usuário ajustar o texto, use a versão dele.

## 4. Publicar

Use a ferramenta de criação de comentário do MCP do ClickUp na task identificada.
Se o MCP não estiver disponível ou a publicação falhar, avise e mostre o texto para o usuário publicar manualmente.

## 5. Registrar localmente

Se existir `.harness/tasks/<ID>.md`, adicione a linha publicada ao final, em uma seção `## Histórico de status` (crie a seção se não existir).

Responda em uma linha: status publicado na task `<ID>`.
