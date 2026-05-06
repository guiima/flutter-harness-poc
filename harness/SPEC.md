# SPEC.md
> Critérios de aceitação da feature. Imutável durante o desenvolvimento — mudanças requerem nova decisão em DECISIONS.md.

## Problema
Consumir a PokéAPI e exibir os dados de um Pokémon no formato visual fiel a uma carta do TCG oficial.

## Critérios de aceitação
- [ ] Busca dados de "ditto" em `https://pokeapi.co/api/v2/pokemon/ditto`
- [ ] Exibe carta com: nome, HP, tipo, imagem oficial, 2 ataques, fraqueza, custo de recuo, número
- [ ] Cor/gradiente da carta corresponde ao tipo do Pokémon
- [ ] Loading state exibido enquanto busca os dados
- [ ] Error state exibido com mensagem se a API falhar
- [ ] `flutter analyze` sem warnings ou errors
- [ ] `flutter test --coverage` com todos os testes passando
- [ ] Coverage total >= 80%

## Fora do escopo (v1)
- Busca por outros Pokémons
- Efeito holográfico / animações
- Múltiplos Pokémons / lista
- Cache local / offline mode

## Dados da PokéAPI utilizados
| Campo da API | Exibido na carta |
|---|---|
| `name` | Nome do Pokémon |
| `id` | Número da carta |
| `sprites.other.official-artwork.front_default` | Imagem principal |
| `types[0].type.name` | Tipo (define cor da carta) |
| `stats[0].base_stat` (hp) | HP |
| `moves[0..1]` | 2 ataques |
| `height` / `weight` | Altura / Peso |
