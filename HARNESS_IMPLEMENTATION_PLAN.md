# POC: Harness Engineering com Flutter + PokéAPI
> **Arquivo de referência — não usado pelo agente durante o desenvolvimento.**
> Serve como documentação histórica das decisões de arquitetura e harness desta POC.
> Inspirado no projeto da OpenAI que construiu 1M+ linhas sem código escrito manualmente.

---

## Contexto
Construir uma POC que demonstra Harness Engineering na prática: estrutura completa de contexto, sensores de feedback automático, memória entre sessões, PEV Loop, CI/CD e fluxo de desenvolvimento via PRs — em cima de um projeto Flutter que consome a PokéAPI e exibe uma carta Pokémon fiel ao TCG oficial.

Projeto: `claude_learning` | Stack: Flutter / Dart ^3.10.4 | Repositório: GitHub

---

## Parte 0 — Setup Inicial

### 0.1 Criar repo e subir base de código
```bash
git init
git add .
git commit -m "chore: initial flutter boilerplate"
gh repo create claude-learning-harness --public --source=. --remote=origin --push
```

### 0.2 Proteção da branch main
- Push direto bloqueado — tudo via PR
- CI obrigatório verde antes de merge
- 1 aprovação de review obrigatória

---

## Parte 1 — Harness Completo (inspirado no projeto OpenAI)

O harness é composto por **8 arquivos de contexto** + **sensores automáticos**.
Cada arquivo tem uma responsabilidade específica — nenhum substitui o outro.

### 1.1 Mapa completo dos arquivos de contexto

```
raiz do projeto/
├── CLAUDE.md                    # instrução geral do agente (stack, comandos, regras)
├── SPEC.md                      # o que a feature deve fazer (critérios de aceitação)
├── TASKS.md                     # micro-tarefas com status (granular, 20-30 itens)
├── core-beliefs.md              # princípios arquiteturais INEGOCIÁVEIS
├── tech-tracker.md              # guardrails de tecnologia (pode/não pode usar)
├── quality-score.md             # critérios de qualidade e scoring
├── PROGRESS.md                  # bastão entre sessões (estado atual, decisões, bloqueadores)
└── DECISIONS.md                 # log de decisões arquiteturais (por que X em vez de Y)
```

---

### 1.2 `CLAUDE.md` — Instrução geral do agente
```markdown
# CLAUDE.md
Stack: Flutter + Dart 3.10+
API: https://pokeapi.co/api/v2/pokemon/{name}

## Comandos
- Build: flutter build apk
- Test: flutter test --coverage
- Lint: flutter analyze

## Regras arquiteturais
- Sem lógica de negócio em widgets
- Models são imutáveis (use const + final)
- Services são testáveis (injeção de dependência)
- Cada branch = 1 task = 1 PR

## Ignorar durante desenvolvimento
- HARNESS_IMPLEMENTATION_PLAN.md (referência apenas)
- DECISIONS.md (log, não instrução)

## Antes de qualquer task
1. Leia PROGRESS.md para saber onde paramos
2. Leia SPEC.md para confirmar critérios
3. Leia core-beliefs.md para não violar princípios
```

---

### 1.3 `SPEC.md` — Critérios de aceitação
```markdown
# SPEC.md
Feature: Exibir carta Pokémon fiel ao TCG oficial

## Problema
Consumir PokéAPI e exibir os dados no formato visual de uma carta TCG.

## Critérios de aceitação
- [ ] Busca dados de "ditto" em https://pokeapi.co/api/v2/pokemon/ditto
- [ ] Exibe carta com: nome, HP, tipo, imagem oficial, 2 ataques, fraqueza, retreat cost, número
- [ ] Cor/gradiente da carta corresponde ao tipo do Pokémon
- [ ] Loading state enquanto busca
- [ ] Error state se API falhar
- [ ] flutter analyze sem warnings
- [ ] flutter test passando com coverage >= 80%

## Fora do escopo
- Busca por outros pokémons
- Efeito holográfico
- Animações
- Múltiplos pokémons
```

---

### 1.4 `TASKS.md` — Micro-tarefas granulares
```markdown
# TASKS.md
> Cada task = 1 commit atômico. Marque [x] APENAS após flutter test passar.

## feat/harness-setup
- [ ] Criar CLAUDE.md na raiz
- [ ] Criar SPEC.md na raiz
- [ ] Criar core-beliefs.md na raiz
- [ ] Criar tech-tracker.md na raiz
- [ ] Criar quality-score.md na raiz
- [ ] Criar PROGRESS.md na raiz
- [ ] Criar DECISIONS.md na raiz
- [ ] Atualizar analysis_options.yaml com regras rígidas
- [ ] Criar .git/hooks/pre-commit (lint + test)

## feat/ci-setup
- [ ] Criar .github/workflows/flutter-ci.yml
- [ ] Validar que CI dispara em PR para main
- [ ] Validar que CI bloqueia se coverage < 80%

## feat/dependencies
- [ ] Adicionar http: ^1.2.0 ao pubspec.yaml
- [ ] Adicionar cached_network_image: ^3.3.0
- [ ] Adicionar mockito: ^5.4.0 (dev)
- [ ] Adicionar build_runner: ^2.4.0 (dev)
- [ ] Rodar flutter pub get e validar sem erros

## feat/pokemon-model
- [ ] Criar lib/models/pokemon.dart (imutável, fromJson)
- [ ] Criar lib/models/pokemon_stat.dart
- [ ] Criar lib/models/pokemon_move.dart
- [ ] Criar lib/models/pokemon_type.dart
- [ ] Escrever test/models/pokemon_test.dart (parse JSON real)
- [ ] Validar coverage >= 80% no model

## feat/pokemon-service
- [ ] Criar lib/services/pokemon_service.dart
- [ ] Criar lib/services/http_client.dart (abstração para mock)
- [ ] Escrever test/services/pokemon_service_test.dart (mock HTTP 200)
- [ ] Escrever teste HTTP 404 / erro de rede
- [ ] Validar coverage >= 80% no service

## feat/pokemon-card-widget
- [ ] Criar lib/widgets/pokemon_card_header.dart (nome + HP + tipo)
- [ ] Criar lib/widgets/pokemon_card_artwork.dart (imagem + CachedNetworkImage)
- [ ] Criar lib/widgets/pokemon_card_attacks.dart (2 ataques + custo energia)
- [ ] Criar lib/widgets/pokemon_card_footer.dart (fraqueza + resistência + retreat)
- [ ] Criar lib/widgets/pokemon_card.dart (orquestra todos acima)
- [ ] Criar lib/theme/pokemon_type_colors.dart (mapa tipo → cores)
- [ ] Escrever test/widgets/pokemon_card_test.dart
- [ ] Validar coverage >= 80% nos widgets

## feat/home-screen
- [ ] Criar lib/screens/home_screen.dart (FutureBuilder + loading + error)
- [ ] Atualizar lib/main.dart (remover boilerplate, apontar para HomeScreen)
- [ ] Escrever test/screens/home_screen_test.dart
- [ ] Rodar app localmente e verificar carta visualmente (self-verification)
- [ ] Validar coverage >= 80% total
```

---

### 1.5 `core-beliefs.md` — Princípios inegociáveis
```markdown
# core-beliefs.md
> Estes princípios NUNCA são violados. Se uma task conflitar com um deles, a task muda — não o princípio.

1. **Separação de responsabilidades**: widgets não conhecem a API, services não conhecem widgets
2. **Imutabilidade**: todos os models são imutáveis (const, final, sem setters)
3. **Testabilidade**: todo service recebe dependências via construtor (sem singletons ocultos)
4. **Sem estado global**: não usar variáveis globais ou singletons de estado
5. **Falha explícita**: erros de API são modelados como tipos (nunca silenciados com try/catch vazio)
6. **Um PR por task**: nunca misturar features em um único PR
7. **CI é lei**: nenhum merge se o CI estiver vermelho, sem exceções
```

---

### 1.6 `tech-tracker.md` — Guardrails de tecnologia
```markdown
# tech-tracker.md
> O que pode e não pode ser usado. Qualquer mudança aqui requer decisão explícita em DECISIONS.md.

## Aprovado
- http: ^1.2.0 (chamadas HTTP)
- cached_network_image: ^3.3.0 (imagens da API)
- mockito: ^5.4.0 (mocks em testes)
- flutter_lints: ^6.0.0 (lint padrão Flutter)
- flutter Material Design (UI base)

## Proibido
- get / provider / riverpod / bloc (desnecessário para POC)
- dio (http nativo é suficiente)
- qualquer package de geração de UI automática
- dart:mirrors (proibido em Flutter)

## Sob avaliação
- google_fonts (apenas se necessário para fidelidade da carta)
```

---

### 1.7 `quality-score.md` — Critérios de qualidade
```markdown
# quality-score.md
> Checklist de qualidade que o agente verifica antes de marcar qualquer task como concluída.

## Gate obrigatório (task não fecha sem isso)
- [ ] flutter analyze: 0 warnings, 0 errors
- [ ] flutter test: todos passando
- [ ] Coverage >= 80% no escopo da task
- [ ] Nenhuma violação de core-beliefs.md
- [ ] Nenhuma tecnologia proibida do tech-tracker.md

## Gate de PR (merge não acontece sem isso)
- [ ] CI verde (analyze + test + coverage)
- [ ] /review executado e sem bloqueadores críticos
- [ ] PROGRESS.md atualizado com o que foi feito nesta task
- [ ] TASKS.md com itens marcados [x]

## Scoring (referência, não bloqueante)
- 5/5 — Todos os gates passando + código limpo + testes bem nomeados
- 4/5 — Gates passando + pequenos ajustes de estilo necessários
- 3/5 — Gates passando mas coverage raspando no limite
- 2/5 — Algum gate falhando
- 1/5 — CI vermelho
```

---

### 1.8 `PROGRESS.md` — Bastão entre sessões ⭐
```markdown
# PROGRESS.md
> LEIA ESTE ARQUIVO NO INÍCIO DE CADA SESSÃO antes de fazer qualquer coisa.
> ATUALIZE ao final de cada task concluída ou ao pausar o trabalho.

## Estado atual
- Última task concluída: (nenhuma — início do projeto)
- Próxima task: feat/harness-setup → criar CLAUDE.md
- Branch atual: main
- CI: não configurado ainda

## O que foi feito
(vazio — início do projeto)

## Bloqueadores ativos
(nenhum)

## Decisões tomadas nesta sessão
(vazio)

## Contexto importante para próxima sessão
- Projeto Flutter boilerplate em claude_learning/
- Repo GitHub criado em: (preencher após criar)
- Dart SDK: ^3.10.4
```

---

### 1.9 `DECISIONS.md` — Log de decisões arquiteturais
```markdown
# DECISIONS.md
> Registro de decisões tomadas durante o desenvolvimento.
> Formato: data | decisão | alternativa rejeitada | motivo

## Template
| Data | Decisão | Alternativa | Motivo |
|------|---------|-------------|--------|
| YYYY-MM-DD | O que foi decidido | O que foi rejeitado | Por que |

## Decisões
(vazio — início do projeto)
```

---

### 1.10 Sensores de Feedback (Feedback Automatizado)

**Pre-commit hook** (`.git/hooks/pre-commit`):
```bash
#!/bin/sh
echo "🔍 Rodando flutter analyze..."
flutter analyze || exit 1
echo "🧪 Rodando flutter test..."
flutter test || exit 1
echo "✅ Pre-commit passou!"
```

**`analysis_options.yaml`** — regras adicionais:
```yaml
linter:
  rules:
    always_declare_return_types: true
    avoid_print: true
    prefer_const_constructors: true
    prefer_final_fields: true
    avoid_empty_catch: true
```

---

### 1.11 PEV Loop (Plan → Execute → Verify)

Cada task segue obrigatoriamente:

```
1. PLAN
   → Ler PROGRESS.md (onde estamos?)
   → Ler SPEC.md (o que deve ser feito?)
   → Ler core-beliefs.md (o que não posso violar?)
   → Criar branch da task
   → Abrir PR em draft

2. EXECUTE
   → Implementar apenas o escopo da task
   → Atualizar PROGRESS.md ao final

3. VERIFY
   → flutter analyze (0 warnings)
   → flutter test --coverage (todos passando)
   → Coverage >= 80%
   → Marcar itens [x] no TASKS.md
   → Converter PR de draft para review
   → CI verde → /review → merge
```

---

## Parte 2 — CI/CD (GitHub Actions)

### `.github/workflows/flutter-ci.yml`
```yaml
name: Flutter CI

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  flutter-ci:
    name: Analyze & Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: 'stable'
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Analyze
        run: flutter analyze

      - name: Test with coverage
        run: flutter test --coverage

      - name: Install lcov
        run: sudo apt-get install -y lcov

      - name: Check coverage threshold (min 80%)
        run: |
          COVERAGE=$(lcov --summary coverage/lcov.info 2>&1 | grep "lines" | grep -oP '\d+\.\d+(?=%)' | head -1)
          echo "Coverage: $COVERAGE%"
          if (( $(echo "$COVERAGE < 80" | bc -l) )); then
            echo "❌ Coverage $COVERAGE% is below 80% threshold"
            exit 1
          fi
          echo "✅ Coverage $COVERAGE% meets the 80% threshold"

      - name: Upload coverage report
        uses: actions/upload-artifact@v4
        with:
          name: coverage-report
          path: coverage/lcov.info
```

**O CI valida em todo PR:**
- `flutter analyze` — zero warnings/errors
- `flutter test` — todos passando
- **Coverage >= 80%** — PR bloqueado se abaixo
- Artefato de coverage salvo para consulta

### PR Review automatizado
```bash
/review           # Claude revisa o código
/security-review  # para lógica de rede/dados
```

---

## Parte 3 — Fluxo Git

```
main (protegida)
 └── feat/harness-setup
       ├── chore: add CLAUDE.md and SPEC.md
       ├── chore: add core-beliefs.md and tech-tracker.md
       ├── chore: add quality-score.md
       ├── chore: add PROGRESS.md and DECISIONS.md
       ├── chore: update analysis_options.yaml
       └── chore: add pre-commit hook
       → PR → CI verde → /review → merge → atualiza PROGRESS.md
```

**Conventional Commits:**
- `feat:` nova funcionalidade
- `chore:` configuração/setup/harness
- `test:` testes
- `fix:` correção
- `docs:` documentação

---

## Parte 4 — Estrutura de Código

```
lib/
├── main.dart
├── models/
│   ├── pokemon.dart
│   ├── pokemon_stat.dart
│   ├── pokemon_move.dart
│   └── pokemon_type.dart
├── services/
│   ├── pokemon_service.dart
│   └── http_client.dart
├── theme/
│   └── pokemon_type_colors.dart
├── widgets/
│   ├── pokemon_card.dart
│   ├── pokemon_card_header.dart
│   ├── pokemon_card_artwork.dart
│   ├── pokemon_card_attacks.dart
│   └── pokemon_card_footer.dart
└── screens/
    └── home_screen.dart

test/
├── models/pokemon_test.dart
├── services/pokemon_service_test.dart
└── widgets/pokemon_card_test.dart

.github/
└── workflows/
    └── flutter-ci.yml
```

### Dependências
```yaml
dependencies:
  http: ^1.2.0
  cached_network_image: ^3.3.0

dev_dependencies:
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

---

## Parte 5 — Design da Carta Pokémon (fiel ao TCG)

### Layout
```
┌──────────────────────────────┐
│ NOME           HP [N]  [⚡]  │  ← header: gradiente do tipo
├──────────────────────────────┤
│     [Official Artwork]       │
├──────────────────────────────┤
│ Pokémon Basic   Nº 000       │
├──────────────────────────────┤
│ [⚡][⚡] Ataque 1      60    │
│  Texto de efeito              │
│ [⚡][⚡][⚡] Ataque 2   90   │
│  Texto de efeito              │
├──────────────────────────────┤
│ Weakness ×2  Res. -  Ret.[⚪]│
├──────────────────────────────┤
│ Illus.       Set   000/xxx ✦ │
└──────────────────────────────┘
Proporção: 63mm × 88mm (ratio ~2.5:3.5)
```

### Cores por tipo (TCG oficial)
| Tipo      | Gradiente             |
|-----------|-----------------------|
| Normal    | #D2D0CF → #A8A870     |
| Fire      | #FF9741 → #D8223B     |
| Water     | #4FC3F7 → #05A8D9     |
| Grass     | #78C850 → #19A648     |
| Lightning | #FFF176 → #FCD021     |
| Psychic   | #CE93D8 → #957DAB     |
| Fighting  | #FFCC80 → #B16232     |
| Darkness  | #4A4A4A → #2E7077     |
| Metal     | #CFD8DC → #9EA1A1     |
| Dragon    | #7E57C2 → #5060E1     |

### Dados da PokéAPI usados
- `name` → nome
- `id` → número da carta
- `sprites.other.official-artwork.front_default` → imagem
- `types[0].type.name` → tipo (define a cor)
- `stats` → HP, ataque, defesa, etc.
- `moves[0..1]` → dois primeiros moves
- `height` + `weight` → altura e peso

---

## Parte 6 — Ordem de Execução

| # | Branch | Entrega principal | CI verifica |
|---|--------|-------------------|-------------|
| 0 | — | gh repo create + push base | — |
| 1 | `feat/harness-setup` | Todos os 8 arquivos de contexto + hooks | flutter analyze |
| 2 | `feat/ci-setup` | GitHub Actions workflow | CI roda em si mesmo |
| 3 | `feat/dependencies` | pubspec.yaml atualizado | pub get + analyze |
| 4 | `feat/pokemon-model` | 4 models + testes | analyze + test + 80% |
| 5 | `feat/pokemon-service` | service + mock testes | analyze + test + 80% |
| 6 | `feat/pokemon-card-widget` | 5 widgets + tema + testes | analyze + test + 80% |
| 7 | `feat/home-screen` | home + main + self-verification | analyze + test + 80% |

---

## Verificação Final (Self-Verification)
```bash
flutter analyze              # zero warnings
flutter test --coverage      # todos passando, coverage >= 80%
flutter run                  # carta Ditto aparece na tela (verificação visual)
git commit                   # hook dispara lint + testes
# PR → CI verde → /review → merge
```

O harness completo garante: **nenhum código chega na main sem passar por lint + testes + coverage + CI + review**.
