# quality-score.md

> Checklist verificado pelo agente antes de marcar qualquer task como concluída.

## Gate de task (obrigatório para marcar [x] no TASKS.md)

- [ ] Agente **executor** implementou o escopo da task
- [ ] Agente **verifier** retornou APROVADO — se BLOQUEADO, executor corrige e verifier reavalia até aprovação
- [ ] `flutter analyze`: 0 warnings, 0 errors
- [ ] `flutter test`: todos os testes passando
- [ ] Coverage >= 80% no escopo da task
- [ ] Nenhuma violação de `core-beliefs.md`
- [ ] Nenhuma tecnologia proibida em `tech-tracker.md`

## Gate de PR (obrigatório para converter draft → review e fazer merge)

- [ ] CI verde (analyze + test + coverage >= 80%)
- [ ] `/security-review` executado:
  - Sem achados → avisar usuário que está pronto para teste + descrever como testar → aguardar confirmação explícita → merge
  - Com achados → reportar ao usuário (severidade + descrição + recomendação) → aguardar decisão → achados aceitos vão para `DECISIONS.md`
- [ ] Usuário confirmou que testou e aprovou a feature
- [ ] `PROGRESS.md` atualizado com o que foi feito
- [ ] `TASKS.md` com itens marcados [x]

## Scoring de qualidade (referência, não bloqueante)

| Score | Critério |
| --- | --- |
| 5/5 | Todos os gates + código limpo + testes bem nomeados |
| 4/5 | Gates passando + pequenos ajustes de estilo |
| 3/5 | Gates passando, coverage raspando no limite de 80% |
| 2/5 | Algum gate falhando |
| 1/5 | CI vermelho |
