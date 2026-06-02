import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import passport from './config/passport';
import routes from './routes';
import appointmentsRoutes from './routes/appointmentRoutes';
import authRoutes from './routes/authRoutes';


dotenv.config();

const app = express();


// Middlewares
app.use(cors());
app.use(express.json());
app.use(passport.initialize());
app.use('/appointments', appointmentsRoutes); // Rota para agendamentos
app.use('/auth', authRoutes); // Rota para autenticação

// Rotas da API
app.use('/api', routes);

// Rota raiz para teste
app.get('/', (req, res) => {
  res.json({ message: 'Bem-vindo à API da Agenda!' });
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`🚀 Servidor rodando na porta ${PORT}`);
});