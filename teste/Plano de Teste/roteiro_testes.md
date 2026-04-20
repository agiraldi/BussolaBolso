# Roteiro de Testes e Cenários de Aceite - Bússola do Bolso

**Versão:** 1.0  
**Data:** 20 de Abril de 2026  
**Objetivo:** Validar as funcionalidades de Autenticação e Navegação Inicial (Landing Page).

---

## 1. Landing Page (Página Inicial)

| ID | Cenário | Passos para Reproduzir | Resultado Esperado |
|:---|:---|:---|:---|
| TP-01 | Carregamento da Página | Acessar a URL base da aplicação. | A Landing Page deve carregar com o gradiente, título "Algo novo vem aí" e botões visíveis. |
| TP-02 | Navegação para Registro | Clicar no botão "Começar Agora" ou "Cadastre-se". | O usuário deve ser redirecionado para a tela de Cadastro. |
| TP-03 | Navegação para Login | Clicar no botão "Acesse o sistema" ou "Entrar". | O usuário deve ser redirecionado para a tela de Login. |
| TP-04 | Responsividade | Redimensionar a tela para o tamanho de um dispositivo móvel. | O layout deve se ajustar, ocultando elementos secundários e centralizando o texto. |

---

## 2. Cadastro de Usuário (Register)

| ID | Cenário | Passos para Reproduzir | Resultado Esperado |
|:---|:---|:---|:---|
| REG-01 | Validação de Campos Vazios | Tentar salvar o formulário com todos os campos vazios. | Devem aparecer mensagens de erro informando que os campos são obrigatórios. |
| REG-02 | Validação de E-mail Inválido | Inserir um e-mail sem "@" ou domínio. | O sistema deve exibir "E-mail inválido". |
| REG-03 | Política de Senha Forte | Inserir uma senha simples (ex: "123"). | O sistema deve exigir: +8 caracteres, maiúscula, número e caractere especial. |
| REG-04 | Confirmação de Senha | Inserir senhas diferentes nos campos "Senha" e "Confirmar Senha". | O sistema deve exibir "As senhas não conferem". |
| REG-05 | Registro com Sucesso | Preencher todos os campos corretamente e clicar em "Salvar". | Exibir mensagem de sucesso e redirecionar para a tela de Login. |

---

## 3. Login e Autenticação

| ID | Cenário | Passos para Reproduzir | Resultado Esperado |
|:---|:---|:---|:---|
| LOG-01 | Login com Dados Inválidos | Inserir e-mail ou senha incorretos. | Exibir mensagem: "Erro. E-mail não cadastrado ou senha inválida". |
| LOG-02 | Login com Sucesso | Inserir credenciais válidas. | O usuário deve ser redirecionado para a Home (Dashboard) e o token JWT deve ser salvo localmente. |
| LOG-03 | Persistência de Sessão | Fazer login, fechar a aba e abrir novamente. | O usuário deve cair direto na Home (se o token não estiver expirado). |

---

## 4. Recuperação de Senha (PIN)

| ID | Cenário | Passos para Reproduzir | Resultado Esperado |
|:---|:---|:---|:---|
| REC-01 | Solicitação de PIN | Inserir e-mail/CPF na tela "Esqueci minha senha". | O sistema deve informar que o PIN foi enviado (via log ou console em ambiente de teste). |
| REC-02 | Verificação de PIN Inválido | Inserir um PIN incorreto ou expirado. | Exibir erro: "Código de recuperação inválido ou expirado". |
| REC-03 | Redefinição de Senha | Inserir PIN válido e nova senha forte. | Senha deve ser atualizada e o usuário redirecionado para Login. |

---

## 5. Critérios de Aceite Globais
- [ ] Todas as chamadas de API devem exibir um "Loading" (CircularProgressIndicator).
- [ ] Erros de rede devem ser tratados com SnackBar amigável.
- [ ] O layout deve seguir estritamente o Design System (Cores: #1F4E5F, #F4A261).
