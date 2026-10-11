# \# 🛒 Carrinho Inteligente

# 

# Aplicação Full Stack desenvolvida para auxiliar no registro, na consulta e no gerenciamento de produtos durante as compras.

# 

# O projeto integra uma interface desenvolvida em \*\*Flutter\*\*, uma \*\*API REST em Node.js com Express\*\* e um banco de dados \*\*PostgreSQL\*\*, permitindo a comunicação entre o aplicativo e o servidor.

# 

# \## 🚀 Funcionalidades

# 

# \- Consulta de produtos cadastrados no banco de dados.

# \- Busca de produtos por código de barras.

# \- Cadastro de novos produtos.

# \- Leitura de códigos de barras pela câmera, quando disponível e autorizada.

# \- Adição de produtos ao carrinho.

# \- Visualização e gerenciamento dos itens do carrinho.

# 

# \## 🛠️ Tecnologias utilizadas

# 

# \*\*Front-end\*\*

# \- Flutter

# \- Dart

# \- Provider

# \- HTTP

# \- Mobile Scanner

# 

# \*\*Back-end\*\*

# \- Node.js

# \- Express

# \- API REST

# \- PostgreSQL

# \- Biblioteca `pg`

# \- Dotenv

# \- CORS

# 

# \*\*Ferramentas\*\*

# \- Git e GitHub

# \- Visual Studio Code ou outra IDE compatível

# \- Chrome para execução do Flutter Web

# 

# \## 📁 Estrutura do projeto

# 

# ```text

# carrinho-inteligente-frontend/

# ├── frontend/

# │   ├── lib/

# │   │   ├── models/

# │   │   ├── providers/

# │   │   ├── screens/

# │   │   ├── services/

# │   │   └── widgets/

# │   ├── android/

# │   ├── ios/

# │   ├── web/

# │   └── pubspec.yaml

# │

# ├── backend/

# │   ├── server.js

# │   ├── package.json

# │   └── package-lock.json

# │

# ├── .gitignore

# └── README.md

# ```

# 

# \## ⚙️ Como executar o projeto

# 

# \### Pré-requisitos

# 

# \- Flutter SDK

# \- Node.js e npm

# \- Acesso a uma instância PostgreSQL

# \- Google Chrome para execução Web

# 

# \### 1. Clonar o repositório

# 

# ```bash

# git clone https://github.com/clebervieira25/carrinho-inteligente-frontend.git

# cd carrinho-inteligente-frontend

# ```

# 

# \### 2. Configurar o Back-end

# 

# Entre na pasta:

# 

# ```bash

# cd backend

# ```

# 

# Instale as dependências:

# 

# ```bash

# npm ci

# ```

# 

# Crie um arquivo `.env` na pasta `backend/` e configure a variável de conexão com seu banco de dados:

# 

# ```env

# DATABASE\_URL=coloque\_sua\_url\_de\_conexao\_aqui

# ```

# 

# Inicie a API:

# 

# ```bash

# node server.js

# ```

# 

# A API ficará disponível em:

# 

# `http://localhost:3000`

# 

# \### 3. Executar o Front-end

# 

# Abra outro terminal e entre na pasta `frontend/`:

# 

# ```bash

# cd frontend

# ```

# 

# Instale as dependências:

# 

# ```bash

# flutter pub get

# ```

# 

# Execute no Chrome:

# 

# ```bash

# flutter run -d chrome

# ```

# 

# \### 4. Testar a API

# 

# Com o servidor em execução, acesse:

# 

# `http://localhost:3000/api/produtos`

# 

# Esse endpoint consulta a lista de produtos disponíveis no banco de dados.

# 

# \## 🔗 Integração entre as tecnologias

# 

# O Flutter realiza requisições HTTP para a API REST desenvolvida em Node.js.

# 

# A API recebe as requisições, consulta ou atualiza as informações no PostgreSQL e devolve as respostas para o aplicativo.

# 

# \*\*Fluxo de comunicação:\*\*

# 

# Flutter → API Node.js/Express → PostgreSQL

# 

# O endereço `localhost` utilizado na configuração atual do Flutter funciona para testes no navegador do mesmo computador. Em dispositivos móveis, é necessário ajustar o endereço da API.

# 

# \## 🔐 Segurança e configuração

# 

# O arquivo `.env` contém configurações privadas e não deve ser enviado ao GitHub.

# 

# O repositório utiliza regras no `.gitignore` para impedir o versionamento desse arquivo e de dependências locais, como `node\_modules/`.

# 

# \## 📌 Status do projeto

# 

# \*\*Versão funcional em desenvolvimento.\*\*

# 

# A aplicação foi executada localmente com Flutter Web, Node.js e PostgreSQL.

# 

# O projeto poderá receber melhorias de interface, testes automatizados, documentação de endpoints e novos recursos.

# 

# \## 👨‍💻 Desenvolvedor

# 

# \*\*Cleber Vieira\*\*

# 

# Projeto desenvolvido para prática e aprimoramento de conhecimentos em desenvolvimento Full Stack, integração de APIs e gerenciamento de dados.

# 

# \*\*GitHub:\*\* https://github.com/clebervieira25

