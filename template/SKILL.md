---
name: harness-engineering
description: Inicializa a estrutura completa do Harness Engineering no projeto atual — cria todos os arquivos de contexto, substitui placeholders interativamente e orienta os próximos passos.
effort: high
allowed-tools: Read, Write, Edit
---

Você é um instalador de harness. Sua missão é inicializar a estrutura completa do Harness Engineering no projeto atual.

## Passo 1 — Criar toda a estrutura de arquivos

Leia cada arquivo abaixo usando o Read tool e crie-o no projeto atual com o conteúdo exato lido. Não substitua placeholders ainda.

Arquivos a criar (leia de `~/.claude/skills/harness-engineering/`):

- `CLAUDE.md` ← `~/.claude/skills/harness-engineering/CLAUDE.md`
- `SETUP.md` ← `~/.claude/skills/harness-engineering/SETUP.md`
- `README.md` ← `~/.claude/skills/harness-engineering/README.md`
- `harness/SPEC.md` ← `~/.claude/skills/harness-engineering/harness/SPEC.md`
- `harness/TASKS.md` ← `~/.claude/skills/harness-engineering/harness/TASKS.md`
- `harness/PROGRESS.md` ← `~/.claude/skills/harness-engineering/harness/PROGRESS.md`
- `harness/DECISIONS.md` ← `~/.claude/skills/harness-engineering/harness/DECISIONS.md`
- `harness/core-beliefs.md` ← `~/.claude/skills/harness-engineering/harness/core-beliefs.md`
- `harness/quality-score.md` ← `~/.claude/skills/harness-engineering/harness/quality-score.md`
- `harness/tech-tracker.md` ← `~/.claude/skills/harness-engineering/harness/tech-tracker.md`
- `.claude/agents/executor/agent.md` ← `~/.claude/skills/harness-engineering/.claude/agents/executor/agent.md`
- `.claude/agents/verifier/agent.md` ← `~/.claude/skills/harness-engineering/.claude/agents/verifier/agent.md`
- `.github/workflows/ci.yml` ← `~/.claude/skills/harness-engineering/.github/workflows/ci.yml`
- `.github/workflows/cd.yml` ← `~/.claude/skills/harness-engineering/.github/workflows/cd.yml`

Após criar todos os arquivos, informe o usuário que a estrutura está criada e que agora vamos configurar os placeholders.

---

## Passo 2 — Configurar placeholders seguindo o SETUP.md

Percorra cada item do `SETUP.md` em ordem. Para cada placeholder, faça **uma pergunta por vez** ao usuário, aguarde a resposta e substitua em todos os arquivos onde ele aparece.

### Sequência de perguntas:

1. **`{{LANGUAGE}}`** — "Qual a linguagem principal do projeto? (ex: Dart, TypeScript, Python)"
2. **`{{FRAMEWORK}}`** — "Qual o framework utilizado? (ex: Flutter, Next.js, FastAPI)"
3. **`{{PLATFORM}}`** — "Qual a plataforma alvo? (ex: Android/Web, Node, Browser)"
4. **`{{API_URL}}`** — "Qual a URL base da API principal? (ex: https://api.exemplo.com)"
5. **`{{CMD_BUILD}}`** — "Qual o comando de build? (ex: flutter build apk)"
6. **`{{CMD_TEST}}`** — "Qual o comando de testes? (ex: flutter test)"
7. **`{{CMD_LINT}}`** — "Qual o comando de lint? (ex: flutter analyze)"
8. **`{{CMD_INSTALL}}`** — "Qual o comando de instalação de dependências? (ex: flutter pub get)"
9. **`{{CMD_FORMAT}}`** — "Qual o comando de formatação de código? (ex: dart format .)"
10. **`{{COVERAGE_THRESHOLD}}`** — "Qual o threshold mínimo de coverage em %? (recomendado: 80)"
11. **`{{GITHUB_REPO_URL}}`** — "Qual a URL do repositório no GitHub? (ex: https://github.com/usuario/repo)"
12. **`{{SOURCE_DIR}}`** — "Qual a pasta principal do código-fonte? (ex: lib, src, app)"

Após cada resposta, substitua o placeholder em **todos** os arquivos onde ele aparece antes de fazer a próxima pergunta.

---

## Passo 3 — Confirmar e orientar os próximos passos

Após substituir todos os placeholders, informe o usuário:

1. Quais itens do `SETUP.md` ainda precisam de atenção manual:
   - `harness/SPEC.md` — descrever o problema e critérios de aceitação
   - `harness/TASKS.md` — quebrar a feature em micro-tarefas
   - `harness/tech-tracker.md` — definir packages aprovados e proibidos
   - `ci.yml` — adicionar step de setup do ambiente e configurar sensores 4 e 6
   - `cd.yml` — configurar step de deploy
   - Criar e proteger as branches `main` e `develop` no GitHub

2. Que o harness está pronto para uso assim que esses itens forem concluídos.

3. Que o fluxo de trabalho começa sempre pelo `CLAUDE.md` — leia o PEV Loop antes de iniciar qualquer task.
