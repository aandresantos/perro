# Padrões

### Dimensionar a estrutura de arquivos ao tamanho da mudança; em features pequenas, agrupar em poucos arquivos

- **Por quê:** fragmentar uma feature pequena em muitos arquivos é over engineering; dificulta a leitura e a revisão sem trazer reuso.
- **Evidência:** "Preciso entender se há necessidade de termos alterações em 15 arquivos diferentes? Não estamos seguindo um caminho de over engineering? Me parece que poderiamos realizar essa implementação de forma muito mais enxuta"
- **Fiz:** separei um modal de ~540 linhas em 13 arquivos (Components/, Hooks/, Form/, api.ts, types.ts, stub em arquivo próprio), com wrappers de uma linha e testes de funções triviais → **Esperado:** poucos arquivos (componente + funções puras + teste), separando só quando um arquivo ficar grande ou a peça for reutilizada, e testes apenas para regras com valor.
- **Aplicar em:** análise (ao propor a estrutura) e implementação, principalmente de front.
- **Data:** 2026-10-27
