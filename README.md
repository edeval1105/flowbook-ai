# Agenda App - Projeto Completo (Flutter + Node.js)

Este projeto foi convertido do arquivo React/TypeScript (`Agenda.tsx`) original para um aplicativo completo utilizando **Flutter** (para Web e Mobile) no Front-end e **Node.js** com **PostgreSQL** no Back-end.

## Estrutura do Projeto

- `/backend`: API REST em Node.js (Express, TypeScript, Passport.js, PostgreSQL)
- `/frontend`: Aplicativo Flutter (Dart, suporta Web, Android e iOS)

## 1. Configurando o Back-end (Node.js)

### Pré-requisitos
- Node.js instalado (v18+)
- PostgreSQL instalado e rodando

### Passos
1. Abra a pasta `backend` no VSCode.
2. Crie um banco de dados no PostgreSQL chamado `agenda_db` (ou o nome que preferir).
3. Abra o arquivo `.env` na raiz da pasta `backend` e configure suas variáveis:

```env
PORT=3000
DB_USER=postgres
DB_HOST=localhost
DB_NAME=agenda_db
DB_PASSWORD=123456
DB_PORT=5432

# CREDENCIAIS OAUTH (INSERIR MANUALMENTE)
# Google (Crie em: https://console.cloud.google.com/)
GOOGLE_CLIENT_ID=seu_google_client_id
GOOGLE_CLIENT_SECRET=seu_google_client_secret

# Apple (Crie no Apple Developer Portal)
APPLE_CLIENT_ID=seu_apple_client_id
APPLE_TEAM_ID=seu_apple_team_id
APPLE_KEY_ID=seu_apple_key_id
APPLE_PRIVATE_KEY_PATH=caminho_para_sua_chave_privada_apple

# Facebook (Crie em: https://developers.facebook.com/)
FACEBOOK_APP_ID=seu_facebook_app_id
FACEBOOK_APP_SECRET=seu_facebook_app_secret
```

4. Execute o script SQL localizado em `backend/schema.sql` no seu banco de dados para criar as tabelas.
5. Instale as dependências:
   ```bash
   npm install
   ```
6. Inicie o servidor:
   ```bash
   npm run dev
   ```
   *(Opcional: adicione `"dev": "nodemon src/index.ts"` no `package.json`)*

---

## 2. Configurando o Front-end (Flutter)

### Pré-requisitos
- Flutter SDK instalado
- Emulador Android / iOS ou navegador Chrome

### Passos
1. Abra a pasta `frontend` no VSCode.
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. **Configuração de Deep Links (Para o OAuth funcionar no Mobile)**:
   - **Android**: Adicione o `intent-filter` no arquivo `android/app/src/main/AndroidManifest.xml` para capturar o esquema `myapp://`.
   - **iOS**: Adicione o `CFBundleURLTypes` no `ios/Runner/Info.plist`.
   *(Como o código Flutter atual usa `app_links`, ele espera capturar a URL de retorno do backend)*.

4. **Configuração da API**:
   Abra o arquivo `lib/services/api_service.dart` e altere a variável `baseUrl` dependendo de onde está testando:
   - Para Web / iOS Simulator: `http://localhost:3000/api`
   - Para Emulador Android: `http://10.0.2.2:3000/api`
   - Para dispositivo físico: Use o IP da sua máquina na rede local (ex: `http://192.168.1.10:3000/api`).

5. Rode o aplicativo:
   ```bash
   flutter run
   ```

## Funcionalidades Implementadas
- **Back-end**: CRUD completo de agendamentos, profissionais e serviços.
- **Autenticação**: Rotas OAuth para Google, Apple e Facebook configuradas via Passport.js.
- **Front-end**: Tela de Login, Tela Principal com visualização por Dia, Semana e Mês (convertido da lógica original do `date-fns` para lógica nativa do Dart/Flutter).

## Comentários no Código
Todo o código foi comentado em **Português** conforme solicitado. Onde você precisa introduzir dados manualmente (como chaves de API), há comentários destacados com `// INSTRUÇÃO PARA O USUÁRIO:`.
