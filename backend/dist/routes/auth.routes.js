"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.authRoutes = void 0;
const express_1 = require("express");
const auth_controller_1 = require("../controllers/auth.controller");
const authRoutes = (0, express_1.Router)();
exports.authRoutes = authRoutes;
const authController = new auth_controller_1.AuthController();
// Use .bind(authController) or arrow function so 'this' remains correct 
// inside the class methods if needed, though here we don't rely on 'this'.
authRoutes.post('/register', authController.register);
authRoutes.post('/login', authController.login);
authRoutes.post('/forgot-password', authController.forgotPassword);
authRoutes.post('/reset-password', authController.resetPassword);
