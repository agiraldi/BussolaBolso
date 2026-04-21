# System Requirements Document (SRD)
**Projeto:** Bússola Bolso  
**Versão:** 1.0 (Módulo de Autenticação e Base)  
**Data:** Abril de 2026  

---

## 1. Visão Geral do Sistema
O **Bússola Bolso** é uma plataforma focada no controle de gastos e finanças pessoais. O sistema é construído utilizando uma arquitetura moderna e rigorosamente desacoplada, contando com um Backend Escalável preparado para alta demanda e um Frontend reativo focado na melhor e mais fluída experiência do usuário final, pensado segundo a metodologia "Mobile-First".

## 2. Arquitetura de Tecnologia
A pilha (stack) principal definida e aplicada no projeto é:
- **Frontend (Interface):** Flutter Web / App (Linguagem: Dart)
- **Backend (API):** Node.js com Express (Linguagem: TypeScript)
- **Banco de Dados (Motor):** MySQL
- **ORM / Conectores:** Prisma ORM
- **Validação de Contratos:** Zod (Backend) e FormKey States (Flutter)

---

## 3. Módulos Implementados

### 3.1. Frontend - Motor de Aplicativo e Páginas
A base visual da aplicação foi completamente solidificada sob o conceito de "Temas Globais" (`app_theme.dart`), garantindo solidez de cores (Primary, Action, Backgrounds), e Componentes.

*   **Página "Cadastre-se" (`register_page.dart`):**  
    Formulário para novos clientes suportando a captura e formatação primária de: Primeiro Nome, Sobrenome, E-mail, Celular e CPF/CNPJ, além da Inserção de Senha e Confirmação de Senha.
*   **Página de "Entrar" (`login_page.dart`):**  
    Ponto de entrada de sessões ativas do cliente que exige apenas a fusão de Login e Senha. Comporta feedback visual de "loading" dinâmico.
*   **Páginas de Recuperação de Senha Segura (`forgot_password_page.dart` e `reset_password_page.dart`):**  
    O sistema intercepta esquecimentos e atua com interações passo a passo divididas em capturar o identificador alvo, gerar verificação na tela "Já tenho meu PIN", e aplicar a nova senha protegida após validação mútua.
*   **Página Principal Administrativa (`home_page.dart`):**  
    Concluída como porta de entrada logada do usuário ("Dashboard"). Ostenta atualmente o pilar dinâmico do `BottomNavigationBar` (Rodapé triplo para navegação entre Início, Lançamentos e Perfil). 

### 3.2. Persistência de Dados e Dispositivo
*   **Local Storage de Dispositivos (`local_storage_service.dart`):** 
    Utilizada a biblioteca robusta nativa `shared_preferences`. A aplicação retém localmente o pacote descritor que o servidor Node.js lança aos ares (o JWT), o aprisionando. Retona-o para ler se a conta logada está aberta (permitindo fechamento forçado de aplicativo sem perdas de login).

### 3.3. Backend - Segurança e API Base
Construção das engrenagens lógicas da aplicação sob rotas `/auth`. Todas envoltas nas amarras arquiteturais do `express`.

*   **Cadastro (`POST /auth/register`):**  
    Criptografa a senha na mesma hora via `bcrypt` (10 rounds of salt) para impedir visualizações externas no banco. Protege o banco de colisões testando duplicidades em E-mail.
*   **Entrada de Serviço (`POST /auth/login`):**  
    Valida hash reverso de proteção; checa bloqueio sistêmico `hasAccess` contra bloqueios internos ao CPF; Geração centralizada e expedição estrita de Token `JWT` com 7 dias de validade.
*   **Recuperação e Bloqueios (`POST /auth/forgot-password` e `POST /auth/reset-password`):**  
    Abandono total da lógica retrograda de propagação de links URLs. O App adota oficialmente tokens PIN gerados randomicamente com validade de curtíssimo prazo (15 Minutos) gravados estritamente na base de dados (`recoveryPin` e `recoveryPinExpires`).  
*   **Camada de E-mails (`auth.service.ts` - Nodemailer):**  
    Estrutura local preparada para envios transacionais usando ambiente de espelhamento temporal via plataforma *Ethereal Mail*, servindo para teste em caixa preta segura. 

---

## 4. Banco de Dados Prisional (Schemas)
Modelagem base configurada no MySQL refletindo a tabela central:
*   `User`: Controla identificações exclusivas (ID por UUIDV4 dinâmico numérico único), E-mail e CPF (`taxId`) obrigatórios para não haver repetições sistêmicas, e marcadores lógicos bolleanos (`isAdmin` e `hasAccess`).

## 5. Diretrizes de Regra de Negócio Implementadas
1. **Política de Senhas:**  
    Senhas da plataforma são impedidas de entrar na API ou rodar via Frontend sem passarem pelo validador: ter +8 caracteres, conter letrais maiúsculas, conter identificador numérico, conter algarismos de caráter especial.
2. **Sistema Bloqueável:** 
    Nenhum acesso de usuários "Logáveis" pode ser completado se a Tag administrativa `hasAccess == false` existir, repelindo permanentemente acessos de infratores desativados.
3. **Escudo Unificado:**
    Qualquer requisição que caia em valas escuras devolve proativos "Erros" na tela colorida do cliente em vez de crashes letais nativos (Exceções mascaradas para humanização de plataforma).

---
*(Esse documento continuará orgânico ao longo das fases II visando Lançamentos ou Perfis de Assinaturas Financeiras)*.
