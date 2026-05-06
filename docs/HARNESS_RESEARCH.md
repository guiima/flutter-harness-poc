# Harness Engineering — Pesquisa Comparativa

> 12 fontes pesquisadas. Análise conceito a conceito contra o projeto atual.
> Gerado em: 2026-05-04

---

## Fonte 1 — OpenAI (fonte original do conceito)

**URL:** https://openai.com/index/harness-engineering/

**Resumo:** Ryan Lopopolo da equipe Frontier da OpenAI descreve um paradigma onde engenheiros nunca escrevem código — apenas guiam agentes. Em cinco meses, uma equipe de 3 a 7 pessoas construiu mais de 1 milhão de linhas de código via Codex com média de 3,5 PRs por engenheiro por dia. O lema central é "humans steer, agents execute." O harness é tudo que não é o modelo: documentação, skills, linters, review agents, testes — tratados como "oportunidades de injeção de prompt just-in-time."

**Tem lá, não aqui:**
- Sistema de **Skills** como primitivos reutilizáveis (aprox. 6 skills core)
- **Symphony**: orquestrador multi-agente em Elixir que gerencia daemon processes por task
- **Dark Factory Model**: agentes rodando continuamente sem supervisão humana
- Review pré-merge feito por agente automático (não por humano), com critérios P0/P1/P2
- **Ghost Libraries**: especificações de alto nível que o agente usa para reconstruir código
- Observabilidade completa (Victoria Metrics, Jaeger, Grafana)
- **Autonomous merging**: agente faz o merge após CI verde, sem aprovação humana
- Arquitetura hiper-modular (500 pacotes NPM para escalar sem colisões entre agentes)

**Tem aqui, não lá:**
- Arquivos de contexto hierárquicos distintos por responsabilidade (SPEC, TASKS, tech-tracker, quality-score separados)
- `/security-review` como gate explícito de PR
- Sistema de scoring 1-5 com critérios descritivos por nível
- Restrição de tecnologias proibidas documentada em `tech-tracker.md`

---

## Fonte 2 — Latent Space Podcast (Extreme Harness Engineering)

**URL:** https://www.latent.space/p/harness-eng

**Resumo:** Versão mais extrema do conceito, chamada de "Dark Factory Engineering." Zero linhas de código escrito por humano, zero review humano pré-merge, 1M LOC em 5 meses. O breakthrough foi tratar qualidade (lint rules, testes, docs) como contexto máquina-legível. Cada erro que o agente cometia gerava uma nova regra permanente no harness — o que Addy Osmani depois chamou de "The Ratchet."

**Tem lá, não aqui:**
- **Build loop discipline**: build máximo de 1 minuto — se ultrapassar, decompõe a arquitetura
- **CLI-First Design**: todas as ferramentas otimizadas para consumo de tokens (logs verbose suprimidos, só erros aparecem)
- **Rework state**: se o PR falhar em review, deleta a work tree inteira e regenera do zero
- **Batch decision-making**: humanos revisam o sistema 2x por dia, não em tempo real
- Produção sem review humano pré-merge (confiança total nos sensores automáticos)
- **Code Disposability**: código é descartável — não é precioso

**Tem aqui, não lá:**
- Critérios de aceitação formais em `SPEC.md` separado
- Security review como gate explícito
- `DECISIONS.md` como log de decisões arquiteturais
- Scoring de qualidade numerado

---

## Fonte 3 — Martin Fowler (Harness Engineering for Coding Agent Users)

**URL:** https://martinfowler.com/articles/harness-engineering.html

**Resumo:** Birgitta Böckeler define o harness como "Agent = Model + Harness" e divide os controles em dois tipos: **Guides** (controles feedforward — agem antes da ação do agente, como documentos de convenção e regras de arquitetura) e **Sensors** (controles feedback — agem depois, como linters e testes). A contribuição central é que sensores devem ser otimizados para consumo por LLM — mensagens de erro que guiam autocorreção, não apenas reportam violações.

**Tem lá, não aqui:**
- **Inferential sensors**: revisores de código baseados em LLM como sensores (separados dos sensores computacionais)
- Três categorias de harness: Maintainability, Architecture Fitness, Behaviour
- Mensagens de lint com **instruções de autocorreção** (não só relato de violação)
- Desativar `inline-disable` rules para impedir que o agente silencie violações
- Framework teórico formal guides/sensors como terminologia

**Tem aqui, não lá:**
- `tech-tracker.md` como artefato dedicado de guardrails tecnológicos
- `quality-score.md` com scoring numérico
- `DECISIONS.md` como artefato de governança arquitetural

---

## Fonte 4 — Anthropic Engineering (Effective Harnesses for Long-Running Agents)

**URL:** https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents

**Resumo:** A Anthropic foca no problema de continuidade entre sessões. A solução é o **Initializer Agent** — um agente dedicado que, na primeira sessão, cria toda a infraestrutura de progresso: arquivo de progresso, script de init, feature list JSON com 200+ requisitos detalhados. Sessões subsequentes são conduzidas pelo **Coding Agent**, que lê o progresso, trabalha em um único feature, testa, commita e atualiza o progresso. O princípio é "incremental progress over comprehensive attempts."

**Tem lá, não aqui:**
- **Initializer Agent** como agente especializado dedicado ao setup inicial
- Feature list em formato JSON com 200+ requisitos detalhados (vs. markdown)
- **Browser automation** (Puppeteer) para verificação funcional ponta-a-ponta pelo agente
- Cada feature permanece marcada como "failing" até verificação rigorosa end-to-end
- O harness como "work shifts" — cada sessão é um turno com handoff deliberado

**Tem aqui, não lá:**
- `quality-score.md` com scoring numérico
- `tech-tracker.md` com lista de tecnologias proibidas
- `core-beliefs.md` como princípios inegociáveis
- PEV Loop como denominação formal do fluxo

---

## Fonte 5 — Anthropic Engineering (Harness Design for Long-Running Application Development)

**URL:** https://www.anthropic.com/engineering/harness-design-long-running-apps

**Resumo:** Prithvi Rajasekaran apresenta uma arquitetura de três agentes inspirada em GANs: **Planner** (transforma brief em spec detalhado), **Generator** (implementa features incrementalmente), e **Evaluator** (testa e fornece feedback estruturado). O princípio-chave é a separação de quem faz de quem julga — o mesmo agente que gerou o código não pode avaliar o próprio trabalho. Apresenta **Sprint Contracts**: antes da implementação, Generator e Evaluator negociam o que "done" significa.

**Tem lá, não aqui:**
- **Sprint Contracts**: negociação pré-implementação entre executor e verifier sobre o que "done" significa
- **Planner Agent** dedicado a transformar brief em spec (nosso `SPEC.md` é escrito por humano)
- Grading criteria formais para qualidade subjetiva (design, originalidade, funcionalidade)
- Avaliação por browser automation (Playwright)
- Múltiplos passes de QA (iterative refinement com N rodadas)

**Tem aqui, não lá:**
- `tech-tracker.md` / tecnologias proibidas
- `DECISIONS.md`
- PEV Loop como denominação
- CI/CD com GitHub Actions

---

## Fonte 6 — Addy Osmani (Agent Harness Engineering)

**URL:** https://addyosmani.com/blog/agent-harness-engineering/

**Resumo:** Osmani sintetiza o estado da arte com o princípio "A decent model with a great harness beats a great model with a bad harness." Introduz formalmente **The Ratchet**: cada erro do agente se torna uma regra permanente rastreável a falhas específicas. O design parte do comportamento desejado para trás — não de ferramentas.

**Tem lá, não aqui:**
- **The Ratchet** como prática formal: rastrear de onde cada regra veio (cada restrição ligada ao erro que a originou)
- **Silent Success, Verbose Failure**: sensores retornam saída só quando há problemas
- **Behavior-First Design**: derivar componentes do harness de comportamentos desejados, não começar pelas ferramentas
- Hooks orientados a eventos em pontos específicos do ciclo de vida
- Context compaction e tool-call offloading como gestão ativa de contexto

**Tem aqui, não lá:**
- `tech-tracker.md`
- `DECISIONS.md`
- `quality-score.md` com scoring numérico
- Agentes com modelos diferentes (executor = Sonnet, verifier = Opus)

---

## Fonte 7 — HumanLayer (Skill Issue: Harness Engineering for Coding Agents)

**URL:** https://www.humanlayer.dev/blog/skill-issue-harness-engineering-for-coding-agents

**Resumo:** O título "Skill Issue" é intencional: a maioria das falhas de agentes é problema de configuração, não de capacidade do modelo. Detalha o sistema de **Skills** como bundles de conhecimento reutilizável que permitem progressive disclosure — o agente acessa instruções específicas só quando precisa. Sub-agentes são usados como "context firewall": cada sub-tarefa roda em contexto isolado.

**Tem lá, não aqui:**
- **Progressive disclosure** via Skills: agente não recebe todo o contexto de uma vez — busca o skill relevante no momento certo
- **Sub-agents as context firewall**: sub-tarefas em sessões isoladas para não poluir o contexto principal
- **Back-pressure mechanisms**: testes + type-checks + coverage como mecanismos de back-pressure
- Início simples e configuração reativa: adicionar configuração apenas após falhas — não front-load

**Tem aqui, não lá:**
- `quality-score.md` com scoring numérico
- `tech-tracker.md` com listas aprovado/proibido
- `DECISIONS.md`
- Fluxo de PR com draft → review → merge

---

## Fonte 8 — Adnan Masood / Medium (Agent Harness Engineering — The Rise of the AI Control Plane)

**URL:** https://medium.com/@adnanmasood/agent-harness-engineering-the-rise-of-the-ai-control-plane-938ead884b1d

**Resumo:** Posiciona o harness como o **Agentic Operating System** emergente — o plano de controle de AI que vai ocupar o lugar de CI/CD, IAM e observability platforms. 88% dos projetos de agentes de IA enterprise não chegam a produção, e 65% dessas falhas são defeitos de harness, não do modelo.

**Tem lá, não aqui:**
- **Semantic caching**: servir respostas pré-computadas para evitar chamadas LLM redundantes
- **Ralph Loop**: mecanismo de recuperação que reinjecta intent original em contexto limpo quando o agente entra em "context anxiety"
- **Environment Engineering**: redesenhar APIs e databases para serem intrinsecamente legíveis por agentes
- Métricas operacionais: Task Resolution Rate, Code Churn Rate, Verification Tax, Defect Escape Rate
- Observabilidade + trilhas de auditoria como requisitos de governança enterprise

**Tem aqui, não lá:**
- Arquivos de contexto distintos por responsabilidade
- `tech-tracker.md`
- `DECISIONS.md`
- `/security-review` como gate de PR

---

## Fonte 9 — Augment Code (Harness Engineering: Constraints That Ship Reliable Code)

**URL:** https://www.augmentcode.com/guides/harness-engineering-ai-coding-agents

**Resumo:** Foca em **constraint harnesses** como primeiro princípio de confiabilidade. Três camadas: (1) Constraint Harnesses feedforward — lint rules e type systems que reduzem o espaço de soluções antes da geração; (2) Feedback Loops corretivos — sinais de erro estruturados para autocorreção autônoma; (3) Quality Gates de enforcement — verificação pré-merge que bloqueia código não-conforme.

**Tem lá, não aqui:**
- **Coordinator + multiple Implementors + Verifier**: arquitetura multi-agente paralela (nosso setup é serial: executor → verifier)
- **Pre-execution gates**: validação de tool calls antes de executar
- Métricas de negócio: Task Resolution Rate, Code Churn Rate, Verification Tax, Defect Escape Rate
- Mensagens de lint com instruções de remediação embutidas
- **Staleness gates**: CI específico para detectar dependências desatualizadas

**Tem aqui, não lá:**
- `DECISIONS.md`
- `tech-tracker.md`
- `PROGRESS.md` como mecanismo de handoff entre sessões
- `quality-score.md` com scoring numérico

---

## Fonte 10 — Red Hat Developer (Harness Engineering: Structured Workflows for AI-Assisted Development)

**URL:** https://developers.redhat.com/articles/2026/04/07/harness-engineering-structured-workflows-ai-assisted-development

**Resumo:** Marco Rizzi apresenta a abordagem prática enterprise: o problema central é contexto insuficiente — um ticket vago deixa o agente sem âncora real no codebase. A solução é o **Repository Impact Map** — o agente varre o codebase via LSP + MCP para identificar exatamente quais arquivos precisam mudar antes de implementar.

**Tem lá, não aqui:**
- **Repository Impact Map com LSP+MCP**: análise automática do codebase via Language Server Protocol antes de qualquer implementação (nosso impact-map skill é manual/conceitual)
- Templates de task estruturados com file paths reais e referências a padrões existentes do codebase
- Rastrear erros até os input constraints que os causaram (fechamento de loop de causalidade)

**Tem aqui, não lá:**
- `tech-tracker.md`
- `DECISIONS.md`
- `quality-score.md` com scoring
- `/security-review` como gate

---

## Fonte 11 — Parallel AI (What Is an Agent Harness?)

**URL:** https://parallel.ai/articles/what-is-an-agent-harness

**Resumo:** Define o harness como "the complete architectural system surrounding an LLM that manages the lifecycle of context." Apresenta cinco estágios operacionais: Intent Capture, Tool Execution, Context Management, Verification, e Handoff. O ponto central é empírico: "the harness makes or breaks an AI product" — modelos idênticos com harnesses diferentes entregam resultados radicalmente diferentes.

**Tem lá, não aqui:**
- **Context compaction**: sumarização de histórico de interações para comprimir o contexto progressivamente
- **Intent Capture** como estágio formal antes da execução
- Memory systems explicitamente projetados para curto e longo prazo
- Tool integration layer com controle de rate limits e retry de tool calls falhos

**Tem aqui, não lá:**
- `tech-tracker.md`
- `DECISIONS.md`
- `quality-score.md` com scoring
- `core-beliefs.md` como documento separado de princípios inegociáveis

---

## Fonte 12 — arxiv (Natural-Language Agent Harnesses — Academic Survey)

**URL:** https://arxiv.org/html/2603.25723v1

**Resumo:** Tratamento acadêmico mais formal. Define harnesses como artefatos de texto executáveis que externalizam lógica de controle de agentes. Formaliza três dimensões de governança: **(i) control** — como o trabalho é decomposto e agendado; **(ii) contracts** — quais artefatos devem ser produzidos e quando parar; **(iii) state** — o que deve persistir entre steps. Define sete elementos mandatórios: Contracts, Roles, Stage Structure, Adapters/Scripts, State Semantics, Failure Taxonomy e File-Backed State.

**Tem lá, não aqui:**
- **Failure Taxonomy**: taxonomia formal de modos de falha que guia a lógica de recuperação
- **Runtime Charter**: definição formal do contrato semântico do runtime e políticas de lifecycle de agentes filhos
- **Contracts formais** por task com entrada/saída requerida, gates de validação, regras de retry
- **Reopening mechanisms**: mecanismo formal para reabrir tasks que falharam
- Separação entre harness task-specific (lógica) e runtime policy (compartilhada)

**Tem aqui, não lá:**
- `tech-tracker.md`
- `DECISIONS.md`
- `quality-score.md` com scoring numérico
- `/security-review` como gate de PR

---

## Fluxo Canônico: Do Zero ao Primeiro Merge

Consolidado das 12 fontes:

### Fase 0 — Fundação do Harness (uma vez só)

```
1. Criar repositório com main protegida
   → push direto bloqueado
   → CI obrigatório antes do merge
   → review obrigatório

2. Criar arquivos de contexto (Guides — controles feedforward)
   CLAUDE.md / AGENTS.md  → instrução geral do agente
   SPEC.md                → critérios de aceitação
   TASKS.md               → micro-tarefas com status
   core-beliefs.md        → princípios inegociáveis
   tech-tracker.md        → guardrails tecnológicos
   quality-score.md       → critérios de qualidade
   PROGRESS.md            → bastão entre sessões
   DECISIONS.md           → log de decisões arquiteturais

3. Criar sensores automáticos (Sensors — controles feedback)
   → linters (flutter analyze)
   → testes (flutter test --coverage)
   → pre-commit hook (analyze + test)
   → analysis_options.yaml com regras rígidas

4. Criar CI/CD (GitHub Actions)
   → analyze + test + coverage >= 80% + TruffleHog

5. Criar agentes especializados
   → executor (implementa, escopo estrito)
   → verifier (avalia independentemente)
```

### Fase 1 — Plan (P do PEV Loop)

```
6. Ler PROGRESS.md → onde estamos?
7. Ler SPEC.md     → o que precisa ser feito?
8. Ler core-beliefs.md → o que não posso violar?
9. Executar Repository Impact Map → quais arquivos serão tocados?
10. Criar branch da task (1 branch = 1 feature = 1 PR)
11. Abrir PR em draft
```

### Fase 2 — Execute (E do PEV Loop)

```
12. Executor lê TASKS.md + SPEC.md + core-beliefs.md + tech-tracker.md
13. Executor implementa apenas o escopo da task — nem mais, nem menos
14. Executor roda flutter analyze + flutter test
15. Executor atualiza PROGRESS.md e marca [x] no TASKS.md
```

### Fase 3 — Verify (V do PEV Loop)

```
16. Verifier avalia independentemente:
    → SPEC.md: cada critério atendido?
    → core-beliefs.md: alguma violação?
    → flutter analyze + test + coverage >= 80%
    → tech-tracker.md: package proibido?

17. Se BLOQUEADO → executor corrige → verifier reavalia → repete até APROVADO

18. Converter PR de draft para review
19. Aguardar CI verde
20. /security-review → reportar TODOS os achados ao usuário → usuário decide
21. /review → sem bloqueadores críticos
22. Merge
23. Atualizar PROGRESS.md
```

---

## Gaps: O Que as Fontes Têm Que Não Temos

| Gap | Fonte(s) | Descrição |
| --- | --- | --- |
| Mensagens de lint com instruções de remediação | Fowler, Augment Code | Lint rules devem dizer o que fazer, não só o que está errado — aumenta taxa de autocorreção autônoma |
| Failure Taxonomy | arxiv | Taxonomia de modos de falha do agente (context overflow, spec ambiguity, tool failure, scope creep) com ação prescrita para cada um |
| The Ratchet formal | Osmani, Latent Space | Cada regra do harness rastreável ao erro específico que a originou — nosso `DECISIONS.md` cobre parcialmente |
| Sprint Contracts por task | Anthropic GAN | Executor e Verifier negociam formalmente o que "done" significa antes de cada task — nosso `SPEC.md` é global, não por task |
| Staleness gates de dependências | Augment Code | Gate de CI para detectar dependências desatualizadas |
| Métricas operacionais quantitativas | Masood, Augment Code | Task Resolution Rate, Code Churn Rate, Verification Tax, Defect Escape Rate |

---

## Diferenciais: O Que Temos Que as Fontes Não Mencionam

| Diferencial | Descrição |
| --- | --- |
| `tech-tracker.md` | Nenhuma das 12 fontes menciona artefato dedicado com listas explícitas de aprovado/proibido/sob avaliação |
| `quality-score.md` com scoring 1-5 | Fontes falam em gates binários (passa/não passa); nosso scoring gradiente é único |
| `DECISIONS.md` como ADR do harness | Prática de Architecture Decision Records trazida para dentro do harness — não encontrada nas fontes |
| Agentes com modelos diferentes por papel | Executor = Sonnet, Verifier = Opus com effort: high — nenhuma fonte prescreve isso como prática |
| `/security-review` como gate obrigatório | Nenhuma fonte menciona security review como gate formal antes do merge com reporte ao humano independente da severidade |
