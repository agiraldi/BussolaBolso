import { Router } from 'express';
import { AuthController } from '../controllers/auth.controller';

const authRoutes = Router();
const authController = new AuthController();

// Use .bind(authController) or arrow function so 'this' remains correct 
// inside the class methods if needed, though here we don't rely on 'this'.
authRoutes.post('/register', authController.register);
authRoutes.post('/login', authController.login);
authRoutes.post('/forgot-password', authController.forgotPassword);
authRoutes.post('/reset-password', authController.resetPassword);

export { authRoutes };
