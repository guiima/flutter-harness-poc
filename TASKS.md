# TASKS.md
> Cada task = 1 commit atômico.
> Marque [x] APENAS após `flutter analyze` + `flutter test` passarem.
> Use `/impact-map <nome da task>` antes de implementar qualquer task.

## Structured Task Template
```
Task: <nome>
Branch: feat/<nome>
Arquivos a criar/modificar: <lista explícita>
Símbolos reutilizados: <classes/funções existentes>
Critério de conclusão: <o que deve ser verdade ao final>
```

---

## feat/harness-setup
- [x] Criar CLAUDE.md na raiz
- [x] Criar SPEC.md na raiz
- [x] Criar core-beliefs.md na raiz
- [x] Criar tech-tracker.md na raiz
- [x] Criar quality-score.md na raiz
- [x] Criar PROGRESS.md na raiz
- [x] Criar DECISIONS.md na raiz
- [x] Criar TASKS.md na raiz
- [x] Atualizar analysis_options.yaml com regras rígidas
- [x] Criar .git/hooks/pre-commit (flutter analyze + flutter test)
- [ ] Criar .claude/agents/verifier/agent.md (Opus, avaliador independente)
- [ ] Criar .claude/agents/executor/agent.md (Sonnet, implementador)
- [ ] Criar .claude/skills/impact-map/SKILL.md (Repository Impact Map)

## feat/ci-setup
- [ ] Criar .github/workflows/flutter-ci.yml
- [ ] Sensor 1: flutter analyze
- [ ] Sensor 2: flutter test + coverage >= 80%
- [ ] Sensor 3: TruffleHog (secrets hardcoded)
- [ ] Sensor 4: dependency check (packages autorizados)
- [ ] Sensor 5: architecture fitness (widgets não importam services)
- [ ] Validar que CI dispara em PR para main

## feat/dependencies
- [ ] Adicionar http: ^1.2.0 ao pubspec.yaml
- [ ] Adicionar cached_network_image: ^3.3.0
- [ ] Adicionar mockito: ^5.4.0 (dev)
- [ ] Adicionar build_runner: ^2.4.0 (dev)
- [ ] Rodar flutter pub get e validar sem erros

## feat/pokemon-model
```
Arquivos a criar: lib/models/pokemon.dart, lib/models/pokemon_stat.dart,
                  lib/models/pokemon_move.dart, lib/models/pokemon_type.dart,
                  test/models/pokemon_test.dart,
                  test/fixtures/ditto_response.json
Símbolos reutilizados: nenhum (arquivos novos)
Critério: fromJson parseia fixture sem erros, coverage >= 80%
```
- [ ] Criar test/fixtures/ditto_response.json (resposta real da API salva)
- [ ] Criar lib/models/pokemon_type.dart
- [ ] Criar lib/models/pokemon_stat.dart
- [ ] Criar lib/models/pokemon_move.dart
- [ ] Criar lib/models/pokemon.dart (imutável, fromJson)
- [ ] Escrever test/models/pokemon_test.dart (usa fixture, não API real)
- [ ] Validar coverage >= 80% no model

## feat/pokemon-service
```
Arquivos a criar: lib/services/http_client.dart, lib/services/pokemon_service.dart,
                  test/services/pokemon_service_test.dart
Símbolos reutilizados: PokemonModel (lib/models/pokemon.dart)
Critério: service retorna PokemonModel no sucesso, lança exceção no erro
```
- [ ] Criar lib/services/http_client.dart (abstração para mock)
- [ ] Criar lib/services/pokemon_service.dart (injeção via construtor)
- [ ] Escrever test/services/pokemon_service_test.dart — HTTP 200 com fixture
- [ ] Escrever teste HTTP 404 — lança PokemonNotFoundException
- [ ] Escrever teste erro de rede — lança NetworkException
- [ ] Validar coverage >= 80% no service

## feat/pokemon-card-widget
```
Arquivos a criar: lib/theme/pokemon_type_colors.dart,
                  lib/widgets/pokemon_card_header.dart,
                  lib/widgets/pokemon_card_artwork.dart,
                  lib/widgets/pokemon_card_attacks.dart,
                  lib/widgets/pokemon_card_footer.dart,
                  lib/widgets/pokemon_card.dart,
                  test/widgets/pokemon_card_test.dart,
                  test/goldens/pokemon_card_ditto.png
Símbolos reutilizados: PokemonModel, todos os sub-models
Critério: card renderiza com dados do Ditto, golden file aprovado
```
- [ ] Criar lib/theme/pokemon_type_colors.dart (mapa tipo → gradiente)
- [ ] Criar lib/widgets/pokemon_card_header.dart
- [ ] Criar lib/widgets/pokemon_card_artwork.dart
- [ ] Criar lib/widgets/pokemon_card_attacks.dart
- [ ] Criar lib/widgets/pokemon_card_footer.dart
- [ ] Criar lib/widgets/pokemon_card.dart (orquestra todos)
- [ ] Escrever test/widgets/pokemon_card_test.dart
- [ ] Gerar golden file test/goldens/pokemon_card_ditto.png (regressão visual)
- [ ] Validar coverage >= 80% nos widgets

## feat/home-screen
```
Arquivos a modificar: lib/main.dart
Arquivos a criar: lib/screens/home_screen.dart,
                  test/screens/home_screen_test.dart
Símbolos reutilizados: PokemonService, PokemonCard
Critério: FutureBuilder exibe loading → card, error state trata falha
```
- [ ] Criar lib/screens/home_screen.dart (FutureBuilder + loading + error)
- [ ] Atualizar lib/main.dart (remover boilerplate, HomeScreen)
- [ ] Escrever test/screens/home_screen_test.dart
- [ ] Rodar `flutter run` e verificar carta visualmente (self-verification)
- [ ] Validar coverage >= 80% total

## feat/entropy-management (futuro — após MVP)
- [ ] Configurar `/schedule` semanal para verificar docs desatualizadas
- [ ] Criar skill de limpeza: verifica se PROGRESS.md está atualizado
- [ ] Verificar se DECISIONS.md reflete o estado atual do código
