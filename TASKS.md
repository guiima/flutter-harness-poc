# TASKS.md
> Cada task = 1 commit atômico.
> Marque [x] APENAS após `flutter analyze` + `flutter test` passarem.

## feat/harness-setup
- [x] Criar CLAUDE.md na raiz
- [x] Criar SPEC.md na raiz
- [x] Criar core-beliefs.md na raiz
- [x] Criar tech-tracker.md na raiz
- [x] Criar quality-score.md na raiz
- [x] Criar PROGRESS.md na raiz
- [x] Criar DECISIONS.md na raiz
- [x] Criar TASKS.md na raiz
- [ ] Atualizar analysis_options.yaml com regras rígidas
- [ ] Criar .git/hooks/pre-commit (flutter analyze + flutter test)

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
- [ ] Criar lib/services/http_client.dart (abstração para mock)
- [ ] Criar lib/services/pokemon_service.dart
- [ ] Escrever test/services/pokemon_service_test.dart (mock HTTP 200)
- [ ] Escrever teste HTTP 404 / erro de rede
- [ ] Validar coverage >= 80% no service

## feat/pokemon-card-widget
- [ ] Criar lib/theme/pokemon_type_colors.dart (mapa tipo → cores)
- [ ] Criar lib/widgets/pokemon_card_header.dart (nome + HP + tipo)
- [ ] Criar lib/widgets/pokemon_card_artwork.dart (imagem oficial)
- [ ] Criar lib/widgets/pokemon_card_attacks.dart (2 ataques + custo energia)
- [ ] Criar lib/widgets/pokemon_card_footer.dart (fraqueza + resistência + retreat)
- [ ] Criar lib/widgets/pokemon_card.dart (orquestra todos acima)
- [ ] Escrever test/widgets/pokemon_card_test.dart
- [ ] Validar coverage >= 80% nos widgets

## feat/home-screen
- [ ] Criar lib/screens/home_screen.dart (FutureBuilder + loading + error)
- [ ] Atualizar lib/main.dart (remover boilerplate, apontar para HomeScreen)
- [ ] Escrever test/screens/home_screen_test.dart
- [ ] Rodar `flutter run` e verificar carta visualmente (self-verification)
- [ ] Validar coverage >= 80% total
