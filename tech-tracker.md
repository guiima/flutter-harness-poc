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

## Sob avaliação (requer decisão antes de usar)
- `google_fonts` — apenas se necessário para fidelidade visual da carta
