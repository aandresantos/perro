---
name: analise
description: Analisa uma tarefa de desenvolvimento (bug, feature ou refactor) antes de qualquer implementação, com hipóteses, alternativas, plano de validação e nível de confiança. Use sempre que o usuário pedir análise, planejamento, investigação ou entendimento de uma tarefa, bug ou feature, quando for começar uma implementação não trivial, ou quando invocar /analise.
---

# Análise

Analise a tarefa antes de escrever qualquer código. Não implemente nada nesta etapa.

## Antes de começar

Leia `~/harness/memoria/padroes.md`. Aplique cada padrão registrado nesta análise.
Se um padrão parecer conflitar com a tarefa, aponte o conflito em vez de ignorá-lo.

Se existir `.harness/tasks/<ID>.md` para a branch atual (o ID é o prefixo do nome da branch), leia-o e use como contexto da tarefa. Trate as **Lacunas** desse documento na seção Perguntas.

## Processo

1. **Classifique a tarefa** como bug, feature ou refactor. Se for uma mistura, escolha o tipo predominante e diga qual é a parte secundária.
2. **Separe** o que foi dito explicitamente do que você está deduzindo.
3. **Explore o código** antes de pensar em solução: arquivos afetados, fluxo atual, quem consome o que será alterado (telas, serviços, pipelines, outros times) e testes existentes. Não proponha abordagem antes de terminar esta etapa; soluções pensadas antes da exploração tendem a ignorar o código real.
4. **Monte a análise** no formato abaixo.
5. **Revise a análise** (ver "Revisão") antes de entregar.

## Ênfase por tipo

- **Bug:** o foco é a causa, não o sintoma. Preencha a seção Hipóteses.
- **Feature:** o foco é o comportamento esperado e o impacto em quem consome. Preencha Alternativas se houver mais de um caminho razoável.
- **Refactor:** o foco é preservar o comportamento atual. O plano de validação precisa provar que nada mudou para quem consome.

## Formato da resposta

Use estas seções nesta ordem. As marcadas como condicionais são omitidas quando não se aplicam. O formato fixo permite comparar análises ao longo do tempo.

### Tipo

Bug, feature ou refactor, com uma frase de justificativa.

### Objetivo entendido

Uma ou duas frases com o que precisa ser feito e por quê.

### Contexto mapeado

- **Arquivos e módulos:** caminhos envolvidos.
- **Impacto:** quem consome o que será alterado e como pode ser afetado.
- **Testes existentes:** o que já cobre essa área, ou "Nenhum".

### Hipóteses (condicional: só bugs)

Para cada hipótese de causa:

- **Hipótese:** <causa provável>
- **A favor:** <evidência no código, logs ou na task>
- **Contra:** <o que enfraquece a hipótese>
- **Como confirmar:** <teste, log ou passo de reprodução>

Ordene da mais para a menos provável. Pergunte "por quê?" até chegar a uma causa que, corrigida, impede o problema de voltar.

### Premissas

Tudo que você está assumindo sem confirmação. Numere cada premissa.

### Riscos e casos de borda

O que pode quebrar, efeitos colaterais e cenários de erro.
Pergunta-guia: se isso quebrasse em produção, qual seria o motivo mais provável?

### Alternativas (condicional: só quando houver decisão real)

Duas abordagens, cada uma com prós, contras e custo. Termine com a recomendação e o motivo.
Omita se só houver um caminho razoável.

### Abordagem proposta

Passos de implementação em ordem, com o motivo de cada decisão relevante.

### Plano de validação

- **Testes automatizados:** o que criar ou ajustar.
- **Validação manual:** cenários a percorrer, incluindo casos de borda.
- **Depois do deploy:** o que observar (métricas, logs, alertas), se aplicável.

### Fora de escopo

O que você conscientemente decidiu não fazer.

### Perguntas

Só o que realmente bloqueia ou muda a abordagem. Se não houver, escreva "Nenhuma".

### Padrões aplicados

Quais padrões de `padroes.md` influenciaram esta análise e onde.

### Revisão

O que foi ajustado na revisão e o nível de confiança.

## Revisão

Antes de entregar, releia a análise como um revisor cético:

1. **Rastreabilidade:** cada afirmação sobre o código foi verificada na exploração? Marque com `(inferido)` o que não foi.
2. **Coerência:** a abordagem resolve o objetivo? Em bugs, ela ataca a hipótese mais provável? O plano de validação comprova o objetivo?
3. **Premissas escondidas:** existe alguma suposição usada na abordagem que não está listada em Premissas?
4. **Proporção:** a análise está do tamanho da tarefa? Corte o que não ajuda a decidir.

Corrija a análise e preencha a seção **Revisão** com:

- o que foi ajustado
- o nível de confiança: Alto, Médio ou Baixo, com uma frase de justificativa

Se a confiança for Baixa, diga isso no início da resposta e recomende resolver as Perguntas antes de implementar.

## Depois da análise

Pare e aguarde. O usuário vai aprovar, ajustar ou apontar diferenças.
Quando ele apontar uma diferença entre o que você fez e o que ele esperava, pergunte se deve memorizá-la (skill `memorizar`).
