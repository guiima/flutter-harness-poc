# core-beliefs.md

> Estes princípios NUNCA são violados.
> Se uma task conflitar com um deles, a task muda — não o princípio.

1. **Separação de responsabilidades** — UI não conhece a API; serviços não conhecem UI
2. **Imutabilidade** — modelos de dados são imutáveis (sem setters, sem mutação direta)
3. **Testabilidade** — serviços recebem dependências via construtor (sem singletons ocultos)
4. **Sem estado global** — não usar variáveis globais ou singletons de estado
5. **Falha explícita** — erros são modelados como tipos; nunca silenciados com catch vazio
6. **Sem duplicação (DRY)** — lógica idêntica não pode existir em dois lugares; extraia ou reutilize
7. **Sem silenciar violações** — proibido suprimir warnings do linter inline; corrija a causa
8. **Um PR por task** — nunca misturar features em um único PR
9. **CI é lei** — nenhum merge se o CI estiver vermelho, sem exceções
