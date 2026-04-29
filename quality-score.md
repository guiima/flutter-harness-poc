# quality-score.md
> Checklist verificado pelo agente antes de marcar qualquer task como concluída.

## Gate de task — Sensores Computacionais (determinísticos)
> Obrigatório para marcar [x] no TASKS.md

- [ ] `flutter analyze`: 0 warnings, 0 errors
- [ ] `flutter test --coverage`: todos os testes passando
- [ ] Coverage >= 80% no escopo da task
- [ ] Nenhuma violação de `core-beliefs.md`
- [ ] Nenhuma tecnologia proibida em `tech-tracker.md`
- [ ] Architecture fitness: widgets não importam services
- [ ] Architecture fitness: models não têm setters

## Gate de PR — Sensores Inferencial + CI (antes do merge)
> Obrigatório para converter draft → review e fazer merge

- [ ] CI verde (todos os 5 sensores passando)
- [ ] `/security-review` executado — sem bloqueadores críticos
- [ ] `/review` executado — sem bloqueadores de qualidade
- [ ] `PROGRESS.md` atualizado com o que foi feito
- [ ] `TASKS.md` com itens marcados [x]
- [ ] `/impact-map` rodado antes da implementação (registro no PR)

## Sensores do CI (referência)
| # | Sensor | Tipo | O que verifica |
|---|---|---|---|
| 1 | `flutter analyze` | Computacional | Lint e erros de tipo |
| 2 | `flutter test --coverage` | Computacional | Testes + coverage >= 80% |
| 3 | TruffleHog | Computacional | Secrets hardcoded |
| 4 | Dependency check | Computacional | Packages não autorizados |
| 5 | Architecture fitness | Computacional | Separação de responsabilidades |
| 6 | `/security-review` | Inferencial (LLM) | Análise semântica de segurança |
| 7 | `/review` | Inferencial (LLM) | Revisão de qualidade |

## Scoring de qualidade (referência, não bloqueante)
| Score | Critério |
|---|---|
| 5/5 | Todos os gates + código limpo + testes bem nomeados + golden files |
| 4/5 | Gates passando + pequenos ajustes de estilo |
| 3/5 | Gates passando, coverage raspando no limite de 80% |
| 2/5 | Algum gate falhando |
| 1/5 | CI vermelho |
