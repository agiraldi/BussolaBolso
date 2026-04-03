# ADR-001 — Arquitetura Modular com Frontend e Backend Desacoplados

## Status
Proposta

## Data
2026-04-02

## Contexto

O sistema Bússola do Bolso será desenvolvido inicialmente como uma aplicação web (MVP), com evolução futura para mobile.

O sistema lidará com dados financeiros e pessoais sensíveis, e futuramente poderá integrar com Open Finance.

É necessário garantir:
- baixo acoplamento
- segurança desde a base
- escalabilidade
- organização modular

---

## Decisão

Adotar arquitetura com:

- Frontend desacoplado (SPA)
- Backend centralizado com APIs REST
- Comunicação via HTTPS e tokens seguros
- Organização modular por domínio

---

## Arquitetura

### Frontend
- Responsável pela UI/UX
- Consome APIs
- Não contém regras críticas de negócio

### Backend
- Regras de negócio
- Autenticação e autorização
- Auditoria
- Integrações externas

### Banco de dados
- Acesso exclusivo pelo backend
- Suporte a auditoria e evolução

---

## Modularização

- identity
- financial
- goals
- reports
- integrations
- audit

---

## Segurança

### Autenticação
- hash de senha seguro
- controle de sessão
- possibilidade de MFA

### Autorização
- RBAC (role-based access control)
- validação no backend

### Comunicação
- HTTPS obrigatório
- proteção contra:
  - XSS
  - CSRF
  - injection

### Dados
- criptografia (quando necessário)
- logs de auditoria
- LGPD compliance

---

## Open Finance (Future-ready)

- módulo isolado de integrações
- gerenciamento de consentimento
- uso de secrets manager
- rastreabilidade de dados

---

## Alternativas

### Monolito
- simples
- baixa escalabilidade

### Desacoplado (escolhido)
- flexível
- seguro
- escalável

---

## Consequências

### Positivas
- evolução independente de front/back
- melhor segurança
- preparação para integrações

### Negativas
- maior complexidade inicial
- necessidade de gestão de APIs

---

## Princípios

- API-first
- security by design
- modularidade
- separação de responsabilidades

---

## Próximos passos

- definir contrato de APIs
- definir autenticação (JWT/OAuth)
- criar diagrama de arquitetura
- definir estratégia de logs e auditoria