# Plano de Testes Manuais (QA) - Módulo Autenticação
**Projeto:** Bússola Bolso  
**Objetivo:** Validar fluxos felizes e de exceção das telas base  

---

## 🏗️ 1. Módulo: Cadastro (Registro)
**Objetivo:** Garantir que apenas usuários com dados de alta segurança consigam registrar.

| ID | Cenário | Passo a Passo | Resultado Esperado |
| :-- | :-- | :-- | :-- |
| **REG-01** | **Cenário Feliz: Cadastro Completo** | 1. Abra a tela de Cadastro.<br>2. Preencha Nome, Sobrenome, Telefone.<br>3. Preencha CPF e E-mail Válidos.<br>4. Digite "Senha@123" e confirme.<br>5. Clique em Casdatre-se. | Uma mensagem de sucesso e redirecionamento de volta para o Login. O banco de dados MySQL deve criar as linhas blindadas. |
| **REG-02** | **Senha Fora do Padrão** | 1. Digite a senha "12345678" ou "senhafaçil". | O formulário deve ficar vermelho avisando da obrigatoriedade de Maiúscula, Caractere Especial e Numeral. |
| **REG-03** | **Senhas Divergentes** | 1. Preencha a primeira senha.<br>2. Na aba confirmar digite algo diferente. | O campo deve soltar alerta de "As senhas não coincidem". |
| **REG-04** | **Conta Duplicada (E-mail já existe)** | 1. Preencha a tela com o exato e-mail que você acabou de criar no passo REG-01.<br>2. Clique em Cadastrar. | Um SnackBar vermelho de "Erro: E-mail já está em uso" (retornado do Node) deve aparecer na tela. |

---

## 🔑 2. Módulo: Login & Sessão
**Objetivo:** Garantir a entrada, validação sistêmica e salvamento contínuo em aparelho físico.

| ID | Cenário | Passo a Passo | Resultado Esperado |
| :-- | :-- | :-- | :-- |
| **LOG-01** | **Cenário Feliz: Entrada Genuina** | 1. Na tela de Entrada, adicione as credenciais válidas do bloco acima.<br>2. Clique em Entrar. | A animação giratória (Loading) rodará, e o app desliza até a tela "Home Page Bússola Bolso" com Menu Inferior apontando "Sessão Ativa". |
| **LOG-02** | **Credencial Negada (Senha Errada)** | 1. Coloque um e-mail correto, masERRE propositalmente a senha. | O SnackBar vermelho acusa "Credenciais inválidas.". O app não transita. |
| **LOG-03** | **Logout Sistêmico (Pular do Navio)** | 1. Com a tela da Dashboard Aberta, clique no botão (Ícone de Sair) no Topo Direito (AppBar). | O App destrói o token guardado na memória e ejeta o usuário limpo para a tela frontal de Login sem abas de voltar trás. |

---

## 🔄 3. Módulo: Recuperação PIN Limitada
**Objetivo:** Provar a efetividade da redefinição segura com Código Numérico por Ethereal Fake Mail.

| ID | Cenário | Passo a Passo | Resultado Esperado |
| :-- | :-- | :-- | :-- |
| **REC-01** | **Caminho Feliz: Código Recebido e Inserido** | 1. No Esqueci Senha, digite o e-mail real.<br>2. Botão Enviar. Mensagem Verde surge e clicamos em "Já tenho Código".<br>3. Olhe no terminal/VS Code do Node.js o link Ethereal e anote o código PIN de 6 Dígitos HTML.<br>4. Insira na tela Nova Senha o Código, a nova "NovaSenha@456" igual em ambos lugares.<br>5. Confirmar. | SnackBar Verde sinalizando finalização. App cai pro Login. |
| **REC-02** | **Teste Secundário: O E-mail não Existe** | 1. Na primeira tela digite *fulanofantasma@bol.com.br*.<br>2. Enviar. | Falha Imediata: SnackBar mostra "Cadastro não encontrado". Evita de seguir passos fantasmas. |
| **REC-03** | **Fraude no Código (PIN Errado)** | 1. Na Janela de Nova Senha, insira o PIN inventado: "000000".<br>2. Digite novas senhas e Salve. | Falha de Banco: O servidor dirá "Código de recuperação inválido ou expirado" barrando a fraude e mantendo a senha antiga intacta. |

---
*Fim do Plano de Testes Básico (Bussóla Bolso v1.0)*
