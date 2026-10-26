---
name: memorizar
description: Registra como padrão uma diferença entre o que o agente fez e o que o usuário esperava. Use quando o usuário pedir para memorizar, registrar ou anotar uma correção, ou invocar /memorizar.
---

# Memorizar

Transforme uma correção do usuário em um padrão reutilizável.

## Processo

1. Identifique a diferença na conversa:
   - o que você fez ou propôs
   - o que o usuário esperava
   - o trecho exato em que ele corrigiu
2. Generalize: qual regra, se seguida, teria evitado a diferença? Ela precisa servir para tarefas futuras, não só para esta.
3. Leia `~/harness/memoria/padroes.md`.
   - Se já existir um padrão parecido, proponha atualizá-lo em vez de criar outro.
   - Se a nova regra conflitar com uma existente, mostre o conflito.
4. Mostre a proposta no formato abaixo e espere aprovação.
5. Só após aprovação, grave no arquivo.

## Formato da entrada

```markdown
### <Regra em uma linha>

- **Por quê:** <motivo, nas palavras do usuário quando possível>
- **Evidência:** "<trecho da correção>"
- **Fiz:** <o que o agente fez> → **Esperado:** <o que o usuário queria>
- **Aplicar em:** <tipo de tarefa ou etapa: análise, implementação, revisão…>
- **Data:** <AAAA-MM-DD>
```

## Regras

- Nunca grave sem aprovação explícita.
- Se o "por quê" não estiver claro na conversa, pergunte antes de propor.
- Se a correção parecer pontual e não um padrão, diga isso e pergunte se ainda assim deve registrar.
