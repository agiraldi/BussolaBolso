"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const auth_service_1 = require("../services/auth.service");
const zod_1 = require("zod");
const authService = new auth_service_1.AuthService();
class AuthController {
    async register(req, res) {
        try {
            const data = auth_service_1.registerSchema.parse(req.body);
            const user = await authService.register(data);
            res.status(201).json({
                message: 'Usuário cadastrado com sucesso!',
                user
            });
        }
        catch (error) {
            if (error instanceof zod_1.z.ZodError) {
                res.status(400).json({
                    error: 'Dados de entrada inválidos',
                    details: error.errors.map((err) => ({ field: err.path.join('.'), message: err.message }))
                });
                return;
            }
            if (error.message === 'E-mail já está em uso' || error.message === 'CPF já cadastrado') {
                res.status(409).json({ error: error.message });
                return;
            }
            console.error('Registration Error:', error);
            res.status(500).json({ error: 'Erro interno no servidor' });
        }
    }
    async login(req, res) {
        try {
            // 1. Zod validation
            const data = auth_service_1.loginSchema.parse(req.body);
            // 2. Call the service
            const result = await authService.login(data);
            res.status(200).json({
                message: 'Login realizado com sucesso!',
                ...result
            });
        }
        catch (error) {
            if (error instanceof zod_1.z.ZodError) {
                res.status(400).json({
                    error: 'Dados de entrada inválidos',
                    details: error.errors.map((err) => ({ field: err.path.join('.'), message: err.message }))
                });
                return;
            }
            if (error.message === 'Erro. E-mail não cadastrado ou senha inválida') {
                res.status(401).json({ error: error.message }); // 401 Unauthorized
                return;
            }
            if (error.message === 'Acesso negado. Sua conta está bloqueada.') {
                res.status(403).json({ error: error.message }); // 403 Forbidden
                return;
            }
            console.error('Login Error:', error);
            res.status(500).json({ error: 'Erro interno no servidor' });
        }
    }
    async forgotPassword(req, res) {
        try {
            const data = auth_service_1.forgotPasswordSchema.parse(req.body);
            const result = await authService.forgotPassword(data);
            res.status(200).json(result);
        }
        catch (error) {
            if (error instanceof zod_1.z.ZodError) {
                res.status(400).json({
                    error: 'Dados de entrada inválidos',
                    details: error.errors.map((err) => ({ field: err.path.join('.'), message: err.message }))
                });
                return;
            }
            if (error.message === 'Cadastro não encontrado para este E-mail ou CPF.') {
                res.status(404).json({ error: error.message });
                return;
            }
            if (error.message === 'Acesso negado. Sua conta está bloqueada.') {
                res.status(403).json({ error: error.message });
                return;
            }
            console.error('ForgotPassword Error:', error);
            res.status(500).json({ error: 'Erro interno no servidor' });
        }
    }
    async resetPassword(req, res) {
        try {
            const data = auth_service_1.resetPasswordSchema.parse(req.body);
            const result = await authService.resetPassword(data);
            res.status(200).json(result);
        }
        catch (error) {
            if (error instanceof zod_1.z.ZodError) {
                res.status(400).json({
                    error: 'Dados de entrada inválidos',
                    details: error.errors.map((err) => ({ field: err.path.join('.'), message: err.message }))
                });
                return;
            }
            if (error.message === 'Cadastro não encontrado para este E-mail ou CPF.') {
                res.status(404).json({ error: error.message });
                return;
            }
            if (error.message === 'Código de recuperação inválido ou expirado.') {
                res.status(401).json({ error: error.message });
                return;
            }
            console.error('ResetPassword Error:', error);
            res.status(500).json({ error: 'Erro interno no servidor' });
        }
    }
}
exports.AuthController = AuthController;
