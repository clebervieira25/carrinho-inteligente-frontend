import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carrinho_provider.dart';
import '../services/api_service.dart';
// ignore: unused_import
import '../models/produto.dart';

class DigitarScreen extends StatefulWidget {
  const DigitarScreen({super.key});

  @override
  State<DigitarScreen> createState() => _DigitarScreenState();
}

class _DigitarScreenState extends State<DigitarScreen> {
  final _codigoController = TextEditingController();
  bool _processando = false;

  @override
  void dispose() {
    _codigoController.dispose();
    super.dispose();
  }

  Future<void> _buscarProduto() async {
    final codigo = _codigoController.text.trim();
    
    if (codigo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite um código de barras'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _processando = true);

    try {
      final produto = await ApiService.buscarPorCodigo(codigo);
      
      if (produto != null) {
        if (mounted) {
          context.read<CarrinhoProvider>().adicionarProduto(produto);
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ ${produto.nome} adicionado!'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Limpar campo após adicionar
          _codigoController.clear();
        }
      } else {
        _mostrarDialogoProdutoNaoEncontrado(codigo);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Erro: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processando = false);
      }
    }
  }

  void _mostrarDialogoProdutoNaoEncontrado(String codigo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Produto não encontrado'),
        content: Text('Código: $codigo\n\nDeseja cadastrar este produto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                '/cadastro',
                arguments: codigo,
              );
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digitar Código'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.keyboard,
                      size: 64,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Digite o código de barras manualmente',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _codigoController,
              decoration: InputDecoration(
                labelText: 'Código de Barras',
                hintText: 'Ex: 7891000315506',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.qr_code),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _codigoController.clear(),
                ),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _buscarProduto(),
              enabled: !_processando,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _processando ? null : _buscarProduto,
                icon: _processando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.search),
                label: Text(_processando ? 'Buscando...' : 'Buscar Produto'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '💡 Dicas:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('• Digite apenas números'),
                    const Text('• Confira se digitou corretamente'),
                    Text(
                      '• Códigos de teste: 7891000315506 (Leite)',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/leitor');
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Usar Câmera'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/carrinho');
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Ver Carrinho'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}