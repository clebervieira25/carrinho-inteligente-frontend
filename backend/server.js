// Importar dependências
const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
require('dotenv').config();

// Criar aplicação Express
const app = express();

// Middlewares
app.use(cors());              // Permite conexão do Flutter
app.use(express.json());      // Permite receber JSON

// Verificar se a URL do banco foi carregada
if (!process.env.DATABASE_URL) {
    console.error('❌ ERRO: DATABASE_URL não definida no arquivo .env');
    process.exit(1);
}

// Configurar conexão com PostgreSQL
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
});

// Testar conexão com o banco
pool.connect((err, client, release) => {
    if (err) {
        console.error('❌ Erro ao conectar no PostgreSQL:');
        console.error(err.message);
    } else {
        console.log('✅ Conectado ao PostgreSQL com sucesso!');
        release();
    }
});

// Rota de teste
app.get('/', (req, res) => {
    res.json({ 
        message: 'API do Carrinho Inteligente funcionando! 🚀',
        status: 'online',
        timestamp: new Date().toISOString()
    });
});

// Rota para listar todos os produtos
app.get('/api/produtos', async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT * FROM produtos 
            ORDER BY nome
        `);
        res.json(result.rows);
    } catch (error) {
        console.error('Erro ao buscar produtos:', error);
        res.status(500).json({ 
            error: 'Erro ao buscar produtos',
            detalhe: error.message 
        });
    }
});

// Rota para buscar produto por código de barras
app.get('/api/produto/:codigo', async (req, res) => {
    const { codigo } = req.params;
    
    try {
        const result = await pool.query(
            'SELECT * FROM produtos WHERE codigo_barras = $1',
            [codigo]
        );
        
        if (result.rows.length > 0) {
            res.json(result.rows[0]);
        } else {
            res.status(404).json({ 
                error: 'Produto não encontrado',
                codigo: codigo 
            });
        }
    } catch (error) {
        console.error('Erro ao buscar produto:', error);
        res.status(500).json({ 
            error: 'Erro ao buscar produto',
            detalhe: error.message 
        });
    }
});

// Rota para cadastrar novo produto
app.post('/api/produto', async (req, res) => {
    const { codigo_barras, nome, preco, categoria } = req.body;
    
    // Validar dados obrigatórios
    if (!codigo_barras || !nome || !preco) {
        return res.status(400).json({ 
            error: 'Dados incompletos. Necessário: codigo_barras, nome, preco' 
        });
    }
    
    try {
        const result = await pool.query(
            `INSERT INTO produtos (codigo_barras, nome, preco, categoria) 
             VALUES ($1, $2, $3, $4) 
             RETURNING *`,
            [codigo_barras, nome, preco, categoria || 'Outros']
        );
        
        res.status(201).json({
            message: 'Produto cadastrado com sucesso!',
            produto: result.rows[0]
        });
    } catch (error) {
        console.error('Erro ao cadastrar produto:', error);
        
        // Erro de código de barras duplicado
        if (error.code === '23505') {
            return res.status(409).json({ 
                error: 'Código de barras já cadastrado' 
            });
        }
        
        res.status(500).json({ 
            error: 'Erro ao cadastrar produto',
            detalhe: error.message 
        });
    }
});

// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor rodando em http://localhost:${PORT}`);
    console.log(`📌 Teste a API: http://localhost:${PORT}/`);
    console.log(`📦 Listar produtos: http://localhost:${PORT}/api/produtos`);
});