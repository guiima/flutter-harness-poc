<!-- PAPEL: Contrato de "pronto" — define os gates obrigatórios para marcar uma task como concluída e para fazer merge de um PR. -->

# quality-score.md

> Checklist verificado pelo agente antes de marcar qualquer task como concluída.

## Gate de task (obrigatório para marcar [x] no TASKS.md)

- [ ] Agente **executor** implementou o escopo da task
- [ ] Agente **verifier** retornou APROVADO — se BLOQUEADO, executor corrige e verifier reavalia até aprovação

> **Importante:** o verifier deve ser um agente distinto do executor — a independência é o que dá valor à verificação. Se ambos forem o mesmo agente, este gate não tem validade.

- [ ] `{{CMD_LINT}}`: 0 warnings, 0 errors
- [ ] `{{CMD_TEST}}`: todos os testes passando
- [ ] Coverage >= threshold definido em `CLAUDE.md` no escopo da task
- [ ] Nenhuma violação de `core-beliefs.md`
- [ ] Nenhuma tecnologia proibida em `tech-tracker.md`

## Gate de PR (obrigatório para converter draft → review e fazer merge)

- [ ] CI verde (lint + test + coverage >= threshold definido em `CLAUDE.md`)
- [ ] `/security-review` executado:
  - **Security OK** → avisar usuário que está pronto para teste + descrever como testar → aguardar confirmação explícita → merge
  - **Security Alerta** → reportar ao usuário (severidade + descrição + recomendação) → aguardar decisão → achados aceitos vão para `DECISIONS.md`
- [ ] Usuário confirmou que testou e aprovou a feature
- [ ] `PROGRESS.md` atualizado com o que foi feito
- [ ] `TASKS.md` com itens marcados [x]
