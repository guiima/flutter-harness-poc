<!-- PAPEL: Instrução principal do harness — lido automaticamente em toda sessão. Define o PEV Loop, stack, comandos e regras de comportamento do agente. -->

# CLAUDE.md

> Lido automaticamente em toda sessão. Mantenha abaixo de 60 linhas.
> Ao ler este arquivo, confirme ao usuário: "✓ CLAUDE.md lido — harness ativo."

## Fluxo de trabalho (PEV Loop)

1. Ler `harness/PROGRESS.md` → saber onde estamos
2. Ler `harness/SPEC.md` → confirmar critérios de aceitação
3. Ler `harness/core-beliefs.md` → não violar princípios
4. Criar branch da task a partir de `develop` → agente **executor** implementa
5. Agente **verifier** avalia — se BLOQUEADO, passar o relatório do verifier ao executor → executor corrige os itens apontados → verifier reavalia; repetir até APROVADO
6. Verifier APROVADO → push → CI verde → /security-review → aguarda aprovação do usuário
7. Usuário testa a feature → aprova ("pode mergear") ou rejeita com feedback → executor corrige e volta ao passo 5
8. Aprovado → merge para `develop`
9. Atualizar `harness/PROGRESS.md` ao finalizar
10. Quando `develop` estiver estável → PR manual de `develop` → `main`

## Stack

- Linguagem: {{LANGUAGE}} (ex: Dart, TypeScript, Python)
- Framework: {{FRAMEWORK}} (ex: Flutter, Next.js, FastAPI)
- Plataforma alvo: {{PLATFORM}} (ex: Android/Web, Node, Browser)
- API principal: {{API_URL}}

## Comandos

- Build: {{CMD_BUILD}}
- Test: {{CMD_TEST}}
- Lint: {{CMD_LINT}}
- Dependências: {{CMD_INSTALL}}
- Coverage mínima: {{COVERAGE_THRESHOLD}}% (ex: 80)

## Segurança e merge

- Rodar `/security-review` em todo PR após CI verde
- **Security OK** → avisar o usuário que a feature está pronta para teste; descrever o que foi implementado e como testar
- **Security Alerta** (qualquer severidade) → reportar ao usuário: severidade + descrição + recomendação; aguardar decisão antes de qualquer coisa
- Alertas aceitos pelo usuário → registrar em `harness/DECISIONS.md`
- Nunca mergear sem confirmação explícita do usuário

## Antes de implementar

- Se houver ambiguidade, apresente interpretações — não escolha silenciosamente
- Se existir abordagem mais simples, diga. Questione quando fizer sentido
- Se algo estiver confuso, pare e pergunte antes de assumir
- Nunca classifique algo como "melhoria futura" ou "fora do escopo" por conta própria — se identificar algo não coberto pela SPEC.md, pare e pergunte ao usuário antes de continuar

## Ignorar durante desenvolvimento

- `docs/` — referência histórica, não instrução
- `harness/DECISIONS.md` — log de decisões, não instrução
