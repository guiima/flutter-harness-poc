---
name: impact-map
description: Gera um Repository Impact Map antes de implementar qualquer task — analisa o codebase e mapeia exatamente quais arquivos serão criados, modificados ou deletados. Use ANTES de iniciar qualquer implementação.
context: fork
agent: Explore
---

## Repository Impact Map

Antes de implementar a task: **$ARGUMENTS**

Analise o codebase atual e produza um mapa de impacto estruturado.

### 1. Analise o estado atual
- Liste os arquivos existentes em `lib/`, `test/` e raiz
- Identifique imports e dependências relevantes
- Identifique símbolos (classes, funções) que serão reutilizados

### 2. Mapeie o impacto da task
Para cada arquivo afetado, classifique como:
- `[CREATE]` — arquivo novo a ser criado
- `[MODIFY]` — arquivo existente a ser alterado
- `[DELETE]` — arquivo a ser removido (raro)

### 3. Identifique riscos
- Existem dependências circulares potenciais?
- Algum arquivo existente será quebrado pela mudança?
- A mudança viola algum princípio em `core-beliefs.md`?

### Output esperado

```
REPOSITORY IMPACT MAP
=====================
Task: <nome da task>

Arquivos afetados:
  [CREATE] lib/models/pokemon.dart
  [CREATE] test/models/pokemon_test.dart
  [MODIFY] pubspec.yaml (adicionar dependência X)

Símbolos reutilizados:
  - Nenhum (arquivo novo)

Riscos identificados:
  - Nenhum

APROVADO PARA IMPLEMENTAÇÃO: Sim/Não
Motivo se Não: ...
```

Aguarde aprovação humana antes de prosseguir com a implementação.
