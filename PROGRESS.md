# PROGRESS.md
> LEIA ESTE ARQUIVO NO INÍCIO DE CADA SESSÃO antes de fazer qualquer coisa.
> ATUALIZE ao final de cada task concluída ou ao pausar o trabalho.

## Estado atual
- **Última task concluída:** feat/harness-setup (em andamento)
- **Próxima task:** feat/ci-setup → criar .github/workflows/flutter-ci.yml
- **Branch atual:** feat/harness-setup
- **CI:** não configurado ainda (feat/ci-setup é a próxima)
- **Repo GitHub:** https://github.com/guiima/flutter-harness-poc

## O que foi feito
- [x] Repo GitHub criado (`flutter-harness-poc`) e base de código subida
- [x] Branch `main` protegida (CI obrigatório + 1 review)
- [x] Branch `feat/harness-setup` criada
- [x] `HARNESS_IMPLEMENTATION_PLAN.md` criado (referência histórica)
- [x] `CLAUDE.md` criado
- [x] `SPEC.md` criado
- [x] `core-beliefs.md` criado
- [x] `tech-tracker.md` criado
- [x] `quality-score.md` criado
- [x] `PROGRESS.md` criado (este arquivo)
- [ ] `DECISIONS.md` a criar
- [ ] `TASKS.md` a criar
- [ ] `analysis_options.yaml` atualizado
- [ ] pre-commit hook criado

## Bloqueadores ativos
- Nenhum

## Decisões tomadas nesta sessão
- Stack: Flutter + http nativo (sem dio, sem state management)
- Repo público no GitHub: `guiima/flutter-harness-poc`
- Coverage mínima: 80% (validada no CI)

## Contexto importante para próxima sessão
- Dart SDK: ^3.10.4
- Repo: https://github.com/guiima/flutter-harness-poc
- Após merge da feat/harness-setup, iniciar feat/ci-setup
- O pre-commit hook está em `.git/hooks/pre-commit` (não versionado pelo git — normal)
