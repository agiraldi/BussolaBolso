import { Request, Response } from 'express';
import { AuthService, registerSchema, loginSchema } from '../services/auth.service';
import { z } from 'zod';

const authService = new AuthService();

export class AuthController {
  async register(req: Request, res: Response): Promise<void> {
    try {
      const data = registerSchema.parse(req.body);
      const user = await authService.register(data);

      res.status(201).json({
        message: 'Usuário cadastrado com sucesso!',
        user
      });
    } catch (error: any) {
      if (error instanceof z.ZodError) {
        res.status(400).json({
          error: 'Dados de entrada inválidos',
          details: (error as any).errors.map((err: any) => ({ field: err.path.join('.'), message: err.message }))
        });
        return;
      }
      
      if (error.message === 'E-mail já está em uso.') {
         res.status(409).json({ error: error.message });
         return;
      }

      console.error('Registration Error:', error);
      res.status(500).json({ error: 'Erro interno no servidor' });
    }
  }

  async login(req: Request, res: Response): Promise<void> {
    try {
      // 1. Zod validation
      const data = loginSchema.parse(req.body);

      // 2. Call the service
      const result = await authService.login(data);

      res.status(200).json({
        message: 'Login realizado com sucesso!',
        ...result
      });
    } catch (error: any) {
      if (error instanceof z.ZodError) {
        res.status(400).json({
          error: 'Dados de entrada inválidos',
          details: (error as any).errors.map((err: any) => ({ field: err.path.join('.'), message: err.message }))
        });
        return;
      }
      
      if (error.message === 'Credenciais inválidas.') {
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
}
