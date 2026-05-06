# tech-tracker.md

> O que pode e não pode ser usado.
> Qualquer adição requer decisão explícita registrada em DECISIONS.md.

## Aprovado

- `http: ^1.2.0` — chamadas HTTP à PokéAPI
- `cached_network_image: ^3.3.0` — carregamento de imagens da API
- `mockito: ^5.4.0` — mocks em testes
- `build_runner: ^2.4.0` — geração de código para mockito
- `flutter_lints: ^6.0.0` — lint padrão Flutter
- Flutter Material Design — UI base

## Proibido

- `get` / `provider` / `riverpod` / `bloc` — desnecessário para esta POC
- `dio` — `http` nativo é suficiente
- Qualquer package de geração de UI automática
- `dart:mirrors` — proibido em Flutter

## Ferramentas de CI (não entram no pubspec.yaml)

- `jscpd` (npm) — detecção de duplicação de código no CI; threshold 5%, mínimo 6 linhas / 50 tokens

## Sob avaliação (requer decisão antes de usar)

- `google_fonts` — apenas se necessário para fidelidade visual da carta

## Melhorias futuras (mapeadas, não priorizadas)

- `flutter_driver` / `integration_test` — testes de integração ponta-a-ponta com app rodando em emulador real; equivalente Flutter ao Puppeteer; aumenta confiança no comportamento dinâmico mas exige emulador no CI e aumenta tempo de build significativamente
