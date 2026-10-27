---
name: revisao
description: Revisa um bloco de implementação concluído antes do commit, verificando erros, aderência ao contexto da task e testes, e ao final pede permissão para usar a skill commit. Use ao terminar um bloco de implementação, quando o usuário pedir para revisar o que foi feito, ou ao invocar /revisao.
---

# Revisão

Revise o bloco como um revisor cético, não como quem o escreveu. Esta skill não altera código: ela aponta, e só corrige com aprovação.

## Antes de começar

- Leia `~/Documents/projects/perro/memoria/padroes.md` e aplique cada padrão na revisão.
- Se existir `.harness/tasks/<ID>.md` (ID = prefixo da branch), leia Objetivo, Critérios de aceite, Decisões e Andamento.
- Delimite o bloco: `git status`, `git diff`, `git diff --cached` e os arquivos novos não rastreados. Se não houver mudanças, diga isso e pare.

## O que revisar

### 1. Erros
- Bugs e casos de borda: vazio, nulo, duplicado, concorrência, falha no meio do fluxo.
- Tratamento de erro: falha silenciosa, detalhe interno exposto ao usuário.
- Segurança: escopo por empresa/tenant, sanitização, secrets ou PII em código e logs.
- Sobras: debug, stub provisório, código morto, arquivos temporários.

### 2. Contexto
- Cada mudança vem do Objetivo, dos Critérios ou das Decisões da task? Aponte o que foi feito sem ter sido pedido.
- Contratos entre camadas (backend ↔ front, API) batem com o que foi combinado?
- As regras do projeto (CLAUDE.md, skills do repositório) e os padrões de `padroes.md` foram seguidos? Ex.: fragmentação desnecessária de arquivos.

### 3. Testes
- Cada regra nova ou alterada tem teste? Aponte testes de baixo valor (lógica trivial).
- Rode os testes, o lint e a checagem de tipos dos arquivos tocados, com os comandos do projeto (CLAUDE.md e skill de testes). Não rode a suíte inteira sem pedido.
- Registre o comando e o resultado. O que não foi rodado vai como "não verificado".

## Formato da resposta

### Bloco revisado
Arquivos e resumo em uma linha.

### Erros
Cada achado com `arquivo:linha`, severidade (Alta, Média ou Baixa) e sugestão. Se não houver, "Nenhum".

### Contexto
Desvios de escopo, contrato ou padrão. Se não houver, "Nenhum".

### Testes
Comandos rodados com resultado; lacunas de cobertura; o que ficou sem verificar.

### Veredito
**Pronto para commit** ou **Ajustes necessários**, com uma frase de justificativa.

## Depois da revisão

- **Ajustes necessários:** liste o que bloqueia e pergunte se deve corrigir. Corrija só o aprovado e revise de novo os pontos afetados. Não ofereça commit enquanto houver bloqueio.
- **Pronto para commit:** pergunte "Posso usar a skill commit para commitar este bloco?". Só acione a skill `commit` com um sim explícito. Sem resposta clara, não commite.
