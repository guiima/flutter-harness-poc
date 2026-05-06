<!-- PAPEL: Checklist de inicialização — leia este arquivo antes de qualquer task. Lista tudo que precisa ser configurado para que o harness esteja operacional. -->

# SETUP.md

> Conclua todos os itens abaixo antes de iniciar qualquer task.
> Um harness com placeholders em aberto não é um harness — é um template.

## 1. CLAUDE.md — placeholders obrigatórios

- [ ] `{{LANGUAGE}}` — linguagem principal do projeto (ex: Dart, TypeScript, Python)
- [ ] `{{FRAMEWORK}}` — framework utilizado (ex: Flutter, Next.js, FastAPI)
- [ ] `{{PLATFORM}}` — plataforma alvo (ex: Android/Web, Node, Browser)
- [ ] `{{API_URL}}` — URL base da API principal
- [ ] `{{CMD_BUILD}}` — comando de build (ex: flutter build apk)
- [ ] `{{CMD_TEST}}` — comando de testes (ex: flutter test)
- [ ] `{{CMD_LINT}}` — comando de lint (ex: flutter analyze)
- [ ] `{{CMD_INSTALL}}` — comando de instalação de dependências (ex: flutter pub get)
- [ ] `{{COVERAGE_THRESHOLD}}` — threshold mínimo de coverage em % (ex: 80)

## 2. harness/ — arquivos que precisam de conteúdo

- [ ] `harness/SPEC.md` — descreva o problema e liste os critérios de aceitação da primeira feature
- [ ] `harness/TASKS.md` — quebre a feature em micro-tarefas atômicas
- [ ] `harness/tech-tracker.md` — liste packages aprovados e proibidos para este projeto
- [ ] `harness/PROGRESS.md` — preencha `{{GITHUB_REPO_URL}}` com a URL do repositório

## 3. .claude/agents/ — placeholders dos agentes

- [ ] `executor/agent.md` — substitua `{{CMD_INSTALL}}`, `{{CMD_LINT}}`, `{{CMD_TEST}}`, `{{CMD_FORMAT}}`
- [ ] `verifier/agent.md` — substitua `{{CMD_LINT}}`, `{{CMD_TEST}}`

## 4. .github/workflows/ — configuração do CI/CD

- [ ] `ci.yml` — adicione o step de setup do ambiente (ex: flutter-action, setup-node)
- [ ] `ci.yml` — substitua `{{CMD_INSTALL}}`, `{{CMD_LINT}}`, `{{CMD_TEST}}`, `{{SOURCE_DIR}}`, `{{COVERAGE_THRESHOLD}}`
- [ ] `ci.yml` — configure o Sensor 4 (staleness) para o gerenciador de dependências do projeto
- [ ] `ci.yml` — configure o Sensor 6 (inline-disable) para o padrão de supressão da linguagem
- [ ] `cd.yml` — adicione o step de setup do ambiente
- [ ] `cd.yml` — substitua `{{CMD_INSTALL}}`, `{{CMD_BUILD}}`, `{{PLATFORM}}`
- [ ] `cd.yml` — configure o step de deploy para o ambiente alvo

## 5. Repositório e proteção de branches

- [ ] Repositório criado no GitHub
- [ ] Branch `develop` criada a partir de `main`
- [ ] Branch `main` protegida — somente `develop` pode abrir PR para `main`; CI obrigatório; merge manual
- [ ] Branch `develop` protegida — features abrem PR para `develop`; CI obrigatório
- [ ] Push direto bloqueado em ambas as branches — tudo via PR
