# CLAUDE.md
> Lido automaticamente em toda sessão. Mantenha abaixo de 60 linhas.

## Stack
- Flutter + Dart ^3.10.4
- API: https://pokeapi.co/api/v2/pokemon/{name}
- Plataforma alvo: Android / Web

## Comandos
- Build: `flutter build apk`
- Test: `flutter test --coverage`
- Lint: `flutter analyze`
- Dependências: `flutter pub get`

## Regras arquiteturais (ver core-beliefs.md)
- Widgets não conhecem a API — apenas recebem dados prontos
- Models são imutáveis (const + final, sem setters)
- Services recebem dependências via construtor (sem singletons ocultos)
- Erros de API são tipos explícitos — nunca silenciados com catch vazio
- Um PR por task — nunca misturar features

## Fluxo de trabalho (PEV Loop)
1. Ler PROGRESS.md → saber onde estamos
2. Ler SPEC.md → confirmar critérios
3. Ler core-beliefs.md → não violar princípios
4. Criar branch da task → implementar → verificar
5. Atualizar PROGRESS.md ao finalizar

## Ignorar durante desenvolvimento
- HARNESS_IMPLEMENTATION_PLAN.md (referência histórica, não instrução)
- DECISIONS.md (log de decisões, não instrução)
