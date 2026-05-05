# CLAUDE.md

> Lido automaticamente em toda sessão. Mantenha abaixo de 60 linhas.

## Stack

- Flutter + Dart ^3.10.4
- API: `https://pokeapi.co/api/v2/pokemon/{name}`
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
4. Criar branch da task → agente **executor** implementa
5. Agente **verifier** avalia — se BLOQUEADO, executor corrige e verifier reavalia
6. Verifier APROVADO → push → CI verde → /security-review → merge ou aguarda
7. Atualizar PROGRESS.md ao finalizar

## Segurança e merge (regra obrigatória)

- Rodar `/security-review` em todo PR após CI verde
- **Sem achados** → avisar o usuário que a feature está pronta para teste; descrever o que foi implementado e como testar; aguardar confirmação explícita ("ok, pode mergear") antes de mergear
- **Com achados** (qualquer severidade) → reportar ao usuário: severidade + descrição + recomendação; aguardar decisão antes de qualquer coisa
- Achados aceitos pelo usuário → registrar em DECISIONS.md
- Nunca mergear sem confirmação explícita do usuário — mesmo sem achados de segurança

## Antes de implementar

- Se houver ambiguidade, apresente interpretações — não escolha silenciosamente
- Se existir abordagem mais simples, diga. Questione quando fizer sentido
- Se algo estiver confuso, pare e pergunte antes de assumir

## Ignorar durante desenvolvimento

- HARNESS_IMPLEMENTATION_PLAN.md (referência histórica, não instrução)
- DECISIONS.md (log de decisões, não instrução)
