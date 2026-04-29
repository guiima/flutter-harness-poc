# DECISIONS.md
> Log de decisões arquiteturais tomadas durante o desenvolvimento.
> Formato: data | decisão | alternativa rejeitada | motivo

| Data | Decisão | Alternativa rejeitada | Motivo |
|---|---|---|---|
| 2026-04-28 | Usar `http` nativo para chamadas HTTP | `dio` | Suficiente para POC, menos dependências |
| 2026-04-28 | Sem state management (setState + FutureBuilder) | provider / riverpod / bloc | POC de uma tela, complexidade desnecessária |
| 2026-04-28 | Coverage mínima de 80% no CI | 70% ou sem threshold | Garantir qualidade real nos testes |
| 2026-04-28 | Repo público no GitHub | Privado | POC educacional, sem dados sensíveis |
| 2026-04-28 | Pre-merge review obrigatório (1 aprovação) | Post-merge sampling | Projeto pequeno — review pré-merge é viável |
