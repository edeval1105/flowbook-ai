import dotenv from 'dotenv';

dotenv.config();

export const env = {
  DB_USER: process.env.DB_USER || 'postgres',
  DB_HOST: process.env.DB_HOST || 'localhost',
  DB_NAME: process.env.DB_NAME || 'agenda_db',
  DB_PASSWORD: process.env.DB_PASSWORD || '123456',
  DB_PORT: Number(process.env.DB_PORT || 5432),
};