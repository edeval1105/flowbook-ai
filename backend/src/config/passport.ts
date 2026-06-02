import passport from 'passport';
import { Strategy as GoogleStrategy } from 'passport-google-oauth20';
import { Strategy as FacebookStrategy } from 'passport-facebook';
// O passport-apple requer configuração de chaves privadas que o usuário precisará inserir
import AppleStrategy from 'passport-apple';
import pool from './db';
import dotenv from 'dotenv';

dotenv.config();

// INSTRUÇÃO PARA O USUÁRIO:
// Você precisará configurar as credenciais do OAuth no arquivo .env

// Configuração Google
if (process.env.GOOGLE_CLIENT_ID && process.env.GOOGLE_CLIENT_SECRET) {
  passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: "/api/auth/google/callback"
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      const email = profile.emails?.[0].value;
      if (!email) return done(new Error("Email não fornecido pelo Google"));

      // Verifica se o usuário já existe
      const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
      
      if (result.rows.length > 0) {
        return done(null, result.rows[0]);
      }

      // Cria novo usuário
      const newUser = await pool.query(
        'INSERT INTO users (name, email, provider, provider_id) VALUES ($1, $2, $3, $4) RETURNING *',
        [profile.displayName, email, 'google', profile.id]
      );
      
      return done(null, newUser.rows[0]);
    } catch (error) {
      return done(error as Error);
    }
  }));
}

// Configuração Facebook
if (process.env.FACEBOOK_APP_ID && process.env.FACEBOOK_APP_SECRET) {
  passport.use(new FacebookStrategy({
    clientID: process.env.FACEBOOK_APP_ID,
    clientSecret: process.env.FACEBOOK_APP_SECRET,
    callbackURL: "/api/auth/facebook/callback",
    profileFields: ['id', 'displayName', 'emails']
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      const email = profile.emails?.[0].value;
      if (!email) return done(new Error("Email não fornecido pelo Facebook"));

      const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
      
      if (result.rows.length > 0) {
        return done(null, result.rows[0]);
      }

      const newUser = await pool.query(
        'INSERT INTO users (name, email, provider, provider_id) VALUES ($1, $2, $3, $4) RETURNING *',
        [profile.displayName, email, 'facebook', profile.id]
      );
      
      return done(null, newUser.rows[0]);
    } catch (error) {
      return done(error as Error);
    }
  }));
}

// Configuração Apple (Requer chaves específicas no ambiente Apple Developer)
if (process.env.APPLE_CLIENT_ID && process.env.APPLE_TEAM_ID && process.env.APPLE_KEY_ID && process.env.APPLE_PRIVATE_KEY_PATH) {
  passport.use(new AppleStrategy({
    clientID: process.env.APPLE_CLIENT_ID,
    teamID: process.env.APPLE_TEAM_ID,
    keyID: process.env.APPLE_KEY_ID,
    privateKeyLocation: process.env.APPLE_PRIVATE_KEY_PATH,
    callbackURL: "/api/auth/apple/callback"
  },
  async (req, accessToken, refreshToken, idToken, profile, done) => {
    try {
      // A Apple envia o email apenas no primeiro login, depois precisamos pegar do token decodificado
      const email = profile?.email || "apple_user_" + idToken.sub + "@apple.com"; // Fallback se não houver email
      
      const result = await pool.query('SELECT * FROM users WHERE provider_id = $1', [idToken.sub]);
      
      if (result.rows.length > 0) {
        return done(null, result.rows[0]);
      }

      const newUser = await pool.query(
        'INSERT INTO users (name, email, provider, provider_id) VALUES ($1, $2, $3, $4) RETURNING *',
        [profile?.name ? `${profile.name.firstName} ${profile.name.lastName}` : 'Usuário Apple', email, 'apple', idToken.sub]
      );
      
      return done(null, newUser.rows[0]);
    } catch (error) {
      return done(error as Error);
    }
  }));
}

export default passport;
