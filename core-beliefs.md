# core-beliefs.md

> Estes princípios NUNCA são violados.
> Se uma task conflitar com um deles, a task muda — não o princípio.

1. **Separação de responsabilidades** — widgets não conhecem a API; services não conhecem widgets
2. **Imutabilidade** — todos os models são imutáveis (const, final, sem setters)
3. **Testabilidade** — todo service recebe dependências via construtor (sem singletons ocultos)
4. **Sem estado global** — não usar variáveis globais ou singletons de estado
5. **Falha explícita** — erros de API são modelados como tipos; nunca silenciados com catch vazio
6. **Sem duplicação (DRY)** — lógica idêntica ou muito similar não pode existir em dois lugares; extraia ou reutilize
7. **Sem silenciar violações** — proibido usar `// ignore:` ou `// ignore_for_file:` em `lib/`; corrija a causa, nunca silencie o sensor
8. **Um PR por task** — nunca misturar features em um único PR
9. **CI é lei** — nenhum merge se o CI estiver vermelho, sem exceções
