"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = exports.resetPasswordSchema = exports.forgotPasswordSchema = exports.loginSchema = exports.registerSchema = void 0;
const prisma_1 = require("../config/prisma");
const bcrypt_1 = __importDefault(require("bcrypt"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const zod_1 = require("zod");
const nodemailer_1 = __importDefault(require("nodemailer"));
exports.registerSchema = zod_1.z.object({
    firstName: zod_1.z.string().min(2, 'Nome deve ter no mínimo 2 caracteres'),
    lastName: zod_1.z.string().min(2, 'Sobrenome deve ter no mínimo 2 caracteres'),
    email: zod_1.z.string().email('E-mail inválido'),
    taxId: zod_1.z.string().optional(),
    phone: zod_1.z.string().optional(),
    password: zod_1.z.string()
        .min(8, 'A senha deve ter no mínimo 8 caracteres')
        .regex(/[A-Z]/, 'A senha deve conter pelo menos uma letra maiúscula')
        .regex(/[0-9]/, 'A senha deve conter pelo menos um número')
        .regex(/[^A-Za-z0-9]/, 'A senha deve conter pelo menos um caractere especial')
});
exports.loginSchema = zod_1.z.object({
    email: zod_1.z.string().email('E-mail inválido'),
    password: zod_1.z.string().min(1, 'A senha é obrigatória')
});
exports.forgotPasswordSchema = zod_1.z.object({
    identifier: zod_1.z.string().min(1, 'E-mail ou CPF é obrigatório')
});
exports.resetPasswordSchema = zod_1.z.object({
    identifier: zod_1.z.string().min(1, 'E-mail ou CPF é obrigatório'),
    pin: zod_1.z.string().length(6, 'O Código deve conter exatamente 6 dígitos'),
    newPassword: zod_1.z.string()
        .min(8, 'A senha deve ter no mínimo 8 caracteres')
        .regex(/[A-Z]/, 'A senha deve conter pelo menos uma letra maiúscula')
        .regex(/[0-9]/, 'A senha deve conter pelo menos um número')
        .regex(/[^A-Za-z0-9]/, 'A senha deve conter pelo menos um caractere especial')
});
class AuthService {
    async register(data) {
        const existingUser = await prisma_1.prisma.user.findUnique({
            where: { email: data.email }
        });
        if (existingUser) {
            throw new Error('E-mail já está em uso');
        }
        if (data.taxId) {
            const existingUserCpf = await prisma_1.prisma.user.findUnique({
                where: { taxId: data.taxId }
            });
            if (existingUserCpf) {
                throw new Error('CPF já cadastrado');
            }
        }
        const saltRounds = 10;
        const passwordHash = await bcrypt_1.default.hash(data.password, saltRounds);
        const newUser = await prisma_1.prisma.user.create({
            data: {
                firstName: data.firstName,
                lastName: data.lastName,
                email: data.email,
                taxId: data.taxId,
                phone: data.phone,
                passwordHash,
                isAdmin: false,
                hasAccess: true,
            }
        });
        const { passwordHash: _, ...userWithoutPassword } = newUser;
        return userWithoutPassword;
    }
    async login(data) {
        // 1. Check if user exists
        const user = await prisma_1.prisma.user.findUnique({
            where: { email: data.email }
        });
        if (!user) {
            throw new Error('Erro. E-mail não cadastrado ou senha inválida');
        }
        // 2. Block if user doesn't have access
        if (!user.hasAccess) {
            throw new Error('Acesso negado. Sua conta está bloqueada.');
        }
        // 3. Verify password
        const passwordMatch = await bcrypt_1.default.compare(data.password, user.passwordHash);
        if (!passwordMatch) {
            throw new Error('Erro. E-mail não cadastrado ou senha inválida');
        }
        // 4. Generate JWT token
        const secret = process.env.JWT_SECRET || 'fallback_secret_local';
        const token = jsonwebtoken_1.default.sign({
            id: user.id,
            email: user.email,
            isAdmin: user.isAdmin
        }, secret, { expiresIn: '7d' } // Token lasts 7 days
        );
        // 5. Return user and token
        const { passwordHash: _, ...userWithoutPassword } = user;
        return {
            user: userWithoutPassword,
            token
        };
    }
    async forgotPassword(data) {
        const user = await prisma_1.prisma.user.findFirst({
            where: {
                OR: [
                    { email: data.identifier },
                    { taxId: data.identifier }
                ]
            }
        });
        if (!user) {
            throw new Error('Cadastro não encontrado para este E-mail ou CPF.');
        }
        if (!user.hasAccess) {
            throw new Error('Acesso negado. Sua conta está bloqueada.');
        }
        const generatedPin = Math.floor(100000 + Math.random() * 900000).toString();
        const pinExpires = new Date(Date.now() + 15 * 60 * 1000); // 15 minutes
        await prisma_1.prisma.user.update({
            where: { id: user.id },
            data: {
                recoveryPin: generatedPin,
                recoveryPinExpires: pinExpires
            }
        });
        const testAccount = await nodemailer_1.default.createTestAccount();
        const transporter = nodemailer_1.default.createTransport({
            host: testAccount.smtp.host,
            port: testAccount.smtp.port,
            secure: testAccount.smtp.secure,
            auth: {
                user: testAccount.user,
                pass: testAccount.pass,
            },
        });
        const info = await transporter.sendMail({
            from: '"Bússola Bolso" <suporte@bussolabolso.com>',
            to: user.email,
            subject: 'Código de Recuperação de Senha - Bússola Bolso',
            text: `Olá ${user.firstName},\n\nSeu código de redefinição de senha é: ${generatedPin}\nEste código expira em 15 minutos.\n\nSe você não solicitou isso, ignore este e-mail.`,
            html: `<b>Olá ${user.firstName},</b><br><br>Para redefinir sua senha, utilize o código abaixo no aplicativo:<br><h2 style="color: #4CAF50; letter-spacing: 5px;">${generatedPin}</h2><br><i>Este código expira em 15 minutos.</i><br><br>Se você não solicitou isso, ignore este e-mail.`
        });
        console.log("==================================================");
        console.log("✉️  E-MAIL DE RECUPERAÇÃO ENVIADO PELO ETHEREAL");
        console.log("🔗 URL PARA LER O E-MAIL: %s", nodemailer_1.default.getTestMessageUrl(info));
        console.log("==================================================");
        return { message: 'Instruções enviadas para o e-mail cadastrado.' };
    }
    async resetPassword(data) {
        const user = await prisma_1.prisma.user.findFirst({
            where: {
                OR: [
                    { email: data.identifier },
                    { taxId: data.identifier }
                ]
            }
        });
        if (!user) {
            throw new Error('Cadastro não encontrado para este E-mail ou CPF.');
        }
        if (user.recoveryPin !== data.pin || !user.recoveryPinExpires || user.recoveryPinExpires < new Date()) {
            throw new Error('Código de recuperação inválido ou expirado.');
        }
        const saltRounds = 10;
        const passwordHash = await bcrypt_1.default.hash(data.newPassword, saltRounds);
        await prisma_1.prisma.user.update({
            where: { id: user.id },
            data: {
                passwordHash,
                recoveryPin: null,
                recoveryPinExpires: null
            }
        });
        return { message: 'Senha redefinida com sucesso.' };
    }
}
exports.AuthService = AuthService;
