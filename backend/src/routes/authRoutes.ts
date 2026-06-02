import { Router } from 'express';
import pool from '../config/db';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const router = Router();

router.post('/register', async (req, res) => {
  try {
    const {
      name,
      email,
      password
    } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      `
      INSERT INTO users (
        name,
        email,
        password_hash
      )
      VALUES ($1, $2, $3)
      RETURNING id, name, email
      `,
      [
        name,
        email,
        hashedPassword
      ]
    );

    res.status(201).json(result.rows[0]);

  } catch (error) {
    console.log(error);

    res.status(500).json({
      error: 'Erro ao registrar usuário'
    });
  }
});

router.post('/login', async (req, res) => {
  try {
    const {
      email,
      password
    } = req.body;

    const result = await pool.query(
      'SELECT * FROM users WHERE email = $1',
      [email]
    );

    const user = result.rows[0];

    if (!user) {
      return res.status(401).json({
        error: 'Usuário não encontrado'
      });
    }

    const validPassword = await bcrypt.compare(
      password,
      user.password_hash
    );

    if (!validPassword) {
      return res.status(401).json({
        error: 'Senha inválida'
      });
    }

    const token = jwt.sign(
      {
        id: user.id,
        email: user.email,
        company_id: user.company_id
      },
      'segredo_super_secreto',
      {
        expiresIn: '7d'
      }
    );

    res.json({
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        
      }
    });

  } catch (error) {
    console.log(error);

    res.status(500).json({
      error: 'Erro no login'
    });
  }
});

export default router;