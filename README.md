<p align="center">
  <img src="https://img.icons8.com/color/144/000000/compass--v1.png" alt="Bússola Bolso Logo"/>
  <h1 align="center">Bússola Bolso</h1>
  <p align="center">
    <strong>Sua direção segura para a liberdade financeira.</strong>
    <br/>
    Um aplicativo financeiro completo, desenhado arquiteturalmente sob o padrão Mobile-First.
  </p>
</p>

<p align="center">
  <img alt="GitHub code size" src="https://img.shields.io/github/languages/code-size/agiraldi/BussolaBolso">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-blue.svg">
  <img alt="Plataformas" src="https://img.shields.io/badge/Plataformas-Web%20%7C%20iOS%20%7C%20Android-green.svg">
</p>

## 🧭 Sobre o Projeto

O **Bússola Bolso** nasceu da necessidade de se ter um controle financeiro que não seja apenas eficiente, mas também responsivo, intuitivo e moderno. O projeto não é um simples MVP; ele é estruturado em uma arquitetura robusta **Desacoplada**, permitindo escalabilidade paralela rápida entre o motor de dados e a interface gráfica do consumidor final. O produto final visa auxiliar os usuários a documentar lançamentos, mapear limites orçamentários, e possuir visibilidade gráfica precisa da sua carteira.

---

## 🚀 Tecnologias e Arquitetura

O sistema é dividido e operado em um modelo de dois grandes mundos (Monorepo estrutural base):

### 1. Motor Visual (Frontend - Multiplataforma)
Construído para brilhar tanto em Navegadores como nativamente nos Smartphones.
- **Ecossistema:** [Flutter](https://flutter.dev/) (Linguagem: Dart)
- **Design System:** Material UI Componentes Personalizados (Identidade Visual Ouro, Cores Ricas e Botões Reativos)
- **Sessão:** `shared_preferences` garantindo que os usuários permaneçam logados persistindo o histórico.
- **Roteamento Dinâmico:** Single Page System + BottomNavigationBar

### 2. Cérebro de Processamento (Backend - API)
Fornece segurança bancária à base de dados, lidando com autenticações de nível altíssimo de complexidade.
- **Ambiente:** [Node.js](https://nodejs.org/) & [Express](https://expressjs.com/) (Linguagem: TypeScript)
- **Modelagem SQL:** [MySQL](https://www.mysql.com/) acoplado ao [Prisma ORM](https://www.prisma.io/)
- **Criptografia e Crivo:** Zod (Parse Validations), Hash Bcrypt (10 Rounds) e JsonWebTokens (JWT)
- **Mensageria Mock:** Nodemailer configurado em plataforma `Ethereal`.

---

## 🔐 Módulos de Segurança Premium Implementados

A barreira de segurança inicial de autenticidade foi construída seguindo ditames exigentes:
- Senhas requerem ao mínimo 8 caracteres mesclando de caixa-alta, caixa-baixa, números e símbolos especiais.
- Login com suporte a interceptadores de e-mail mal formalizado e contagem de tempo de token (Session ID).
- **[Novo!] Redefinição de Senha via Código/PIN** - Abandono prático do antiquado envio do Web Link; Sistema utiliza geração e leitura de Códigos de Segurança Locais (6 Dígitos) temporários, validados localmente pela UI do App para máxima segurança em celulares (Prevenção contra Sniffing Links).

---

## 🛠️ Como Iniciar o Projeto (Deploy Local)

Você precisará de ter o [Node.js](https://nodejs.org/), [Flutter SDK](https://flutter.dev/docs/get-started/install), e um servidor MySQL rodando localmente na porta 3306.

### > Configurando a Máquina (Backend)
1. Navegue para o Back-end: `cd backend`
2. Instale as dependências: `npm install`
3. Crie um arquivo `.env` na raiz desse backend baseando-se no que for necessário (Use o `mysql://root:SUA_SENHA@localhost:3306/bussola_bolso`)
4. Reflita a estrutura de tabelas: `npx prisma db push`
5. Ative o canhão de dados: `npm run dev`

### > Pintando o Telão (Frontend)
1. Em um terminal simultâneo, caia para o App: `cd app`
2. Instale os pacotes visuais e bibliotecas: `flutter pub get`
3. Suba na web visual usando o Google Chrome: `flutter run -d chrome`

---

## 🧪 Estrutura de Testes Manuais (QA)

Nós prezamos por código à prova de balas. O ambiente central do projeto hospeda nativamente Manuais de Teste cobrindo caminhos Felizes e Escuros de UX. 
Eles podem ser lidos centralizados em `/teste/Cenários de testes/`.

---

## 📦 Regras de Fluxo de Versões (Git-Flow)
Para que os branches não fiquem bagunçados e tenhamos um nível corporativo de projeto, usamos o *Git Flow*:
*   `main`: O Produto que o Cliente enxerga na Praça (Intocável por Junior).
*   `develop`: O Grande caldeirão de Misturas; Todas as features nascem e morrem aqui antes de subir pra Main.
*   `feature/X`: Cada botão, tela, ou API novo; Sai da Develop, ganha a letra nova, e funde nela de volta.
*   `hotfix/X`: O código pegando fogo na Praça (produção). Deriva velozmente da Main para consertar urgências.

<br>
<p align="center">
   <i>Feito com estratégia avançada pela inteligência Antigravity + Você! Miremos aos céus financeiros! 🚀</i>
</p>