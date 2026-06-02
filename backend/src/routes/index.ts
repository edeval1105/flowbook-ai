import { Router } from 'express';
import passport from 'passport';
import jwt from 'jsonwebtoken';
import pool from '../config/db';


const router = Router();
const JWT_SECRET = process.env.JWT_SECRET || 'supersecretjwtkey';

// Função auxiliar para gerar token JWT
const generateToken = (user: any) => {
  return jwt.sign({ id: user.id, role: user.role }, JWT_SECRET, { expiresIn: '7d' });
};

// ==========================================
// ROTAS DE AUTENTICAÇÃO (OAUTH)
// ==========================================

// Google Auth
router.get('/auth/google', passport.authenticate('google', { scope: ['profile', 'email'] }));
router.get('/auth/google/callback', passport.authenticate('google', { session: false }), (req, res) => {
  const token = generateToken(req.user);
  // Redireciona para o app Flutter (Deep Link) ou Web passando o token
  res.redirect(`myapp://auth?token=${token}`);
});

// Facebook Auth
router.get('/auth/facebook', passport.authenticate('facebook', { scope: ['email'] }));
router.get('/auth/facebook/callback', passport.authenticate('facebook', { session: false }), (req, res) => {
  const token = generateToken(req.user);
  res.redirect(`myapp://auth?token=${token}`);
});

// Apple Auth
router.get('/auth/apple', passport.authenticate('apple'));
router.post('/auth/apple/callback', passport.authenticate('apple', { session: false }), (req, res) => {
  const token = generateToken(req.user);
  res.redirect(`myapp://auth?token=${token}`);
});

// ==========================================
// ROTAS DE AGENDAMENTO (APIs convertidas do tRPC)
// ==========================================

// Listar agendamentos (filtrando por data)
router.get('/appointments', async (req, res) => {
  try {
    const { startAt, endAt } = req.query;
    
    let query = 'SELECT * FROM appointments';
    const params: any[] = [];
    
    if (startAt && endAt) {
      query += ' WHERE start_at >= $1 AND end_at <= $2';
      params.push(startAt, endAt);
    }
    
    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar agendamentos' });
  }
});

// Criar agendamento
router.post('/appointments', async (req, res) => {
  try {
    const { professionalId, serviceId, startAt, endAt, price, customerName, customerPhone, notes } = req.body;
    
    const result = await pool.query(
      `INSERT INTO appointments 
      (professional_id, service_id, start_at, end_at, price, customer_name, customer_phone, notes) 
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [professionalId, serviceId, startAt, endAt, price, customerName, customerPhone, notes]
    );
    
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao criar agendamento' });
  }
});

// Atualizar status do agendamento
router.patch('/appointments/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    
    const result = await pool.query(
      'UPDATE appointments SET status = $1 WHERE id = $2 RETURNING *',
      [status, id]
    );
    
    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao atualizar agendamento' });
  }
});

// ==========================================
// ROTAS AUXILIARES
// ==========================================

// Listar profissionais ativos
router.get('/professionals', async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM users WHERE role = 'professional'");
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar profissionais' });
  }
});

// Listar serviços ativos
router.get('/services', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM services WHERE is_active = true');
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar serviços' });
  }
});

export default router;
