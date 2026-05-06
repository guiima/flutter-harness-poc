# Harness Engineering Template

Um template de contexto estruturado para desenvolvimento guiado por IA — garante que agentes implementem com qualidade, sigam princípios arquiteturais e passem por verificação independente antes de qualquer merge.

---

## O que é Harness Engineering?

É a prática de construir um **contexto rico e estruturado** ao redor do agente de IA, de forma que ele saiba exatamente o que fazer, como fazer, o que não fazer e como verificar se fez certo — sem depender de instruções repetidas a cada sessão.

O harness é composto por arquivos de contexto + sensores automáticos (CI) + agentes especializados + um loop de trabalho bem definido (PEV Loop).

---

## Estrutura de arquivos

```
projeto/
│
├── CLAUDE.md                        # Instrução principal — lido automaticamente em toda sessão
├── SETUP.md                         # Checklist de inicialização — configure antes de qualquer task
│
├── harness/
│   ├── SPEC.md                      # O que precisa funcionar (critérios de aceitação da feature)
│   ├── TASKS.md                     # Como chegar lá (micro-tarefas atômicas)
│   ├── PROGRESS.md                  # Onde estamos (bastão entre sessões)
│   ├── DECISIONS.md                 # Por que decidimos assim (log de decisões arquiteturais)
│   ├── core-beliefs.md              # Princípios inegociáveis (nunca violados)
│   ├── quality-score.md             # Contrato de "pronto" (gates de task e de PR)
│   └── tech-tracker.md              # Guardrail de tecnologia (pode / não pode usar)
│
├── .claude/
│   └── agents/
│       ├── executor/agent.md        # Agente implementador — executa o escopo da task
│       └── verifier/agent.md        # Agente avaliador — verifica independentemente
│
└── .github/
    └── workflows/
        ├── ci.yml                   # Sensores automáticos (lint, testes, coverage, segurança, DRY)
        └── cd.yml                   # Build e deploy (configurar por projeto)
```

---

## Fluxo de trabalho (PEV Loop)

```
┌─────────────────────────────────────────────────────────────┐
│                        PEV LOOP                             │
│                                                             │
│  1. Ler PROGRESS.md ──→ 2. Ler SPEC.md ──→ 3. core-beliefs │
│                                    ↓                        │
│                            4. executor                      │
│                            implementa                       │
│                                    ↓                        │
│                            5. verifier                      │
│                               avalia                        │
│                          ↙           ↘                      │
│                    BLOQUEADO       APROVADO                  │
│                       ↓               ↓                     │
│               executor corrige    push + CI                  │
│               com o relatório         ↓                     │
│               do verifier       /security-review            │
│                    ↑                  ↓                     │
│                    └──────────  Security Alerta             │
│                                       ↓                     │
│                               Security OK                   │
│                                       ↓                     │
│                            usuário testa a feature          │
│                          ↙                   ↘              │
│                    rejeitado             aprovado            │
│                       ↓                     ↓               │
│               executor corrige        merge → develop        │
│               e volta ao passo 4                            │
└─────────────────────────────────────────────────────────────┘
```

---

## Estratégia de branches

```
main          ────────────────────────────●  (produção estável)
                                         ↑
                                    PR manual
                                         │
develop       ──────●────────●───────────●  (integração)
                    ↑        ↑
               PR + CI   PR + CI
                    │        │
feature/a    ───────●        │
feature/b            ────────●
```

- Features sempre partem de `develop`
- PRs de features vão para `develop` (CI obrigatório)
- Merge de `develop` → `main` é manual — você decide quando está pronto para produção

---

## Sensores automáticos (CI)

| # | Sensor | O que verifica |
|---|--------|---------------|
| 1 | Lint | 0 warnings, 0 errors |
| 2 | Testes + Coverage | Todos passando, coverage >= threshold |
| 3 | TruffleHog | Secrets hardcoded no código |
| 4 | Staleness | Dependências com major updates disponíveis |
| 5 | jscpd | Duplicação de código acima de 5% |
| 6 | Inline-disable | Supressões de lint proibidas |

---

## Como usar este template

1. Copie os arquivos para o seu projeto
2. Abra `SETUP.md` e siga o checklist completo
3. Substitua todos os `{{PLACEHOLDERS}}` pelos valores do seu projeto
4. Crie o repositório no GitHub e proteja as branches `main` e `develop`
5. Inicie a primeira feature pelo PEV Loop

> **Regra de ouro:** nunca inicie uma task com placeholders em aberto. Um harness incompleto é pior do que nenhum harness.
