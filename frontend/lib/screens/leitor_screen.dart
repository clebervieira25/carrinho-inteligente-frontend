import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../providers/carrinho_provider.dart';
import '../services/api_service.dart';

class LeitorScreen extends StatefulWidget {
  const LeitorScreen({super.key});

  @override
  State<LeitorScreen> createState() => _LeitorScreenState();
}

class _LeitorScreenState extends State<LeitorScreen> {
  bool _processando = false;
  final MobileScannerController _controller = MobileScannerController();

  Future<void> _processarCodigo(String codigo) async {
    if (_processando) return;

    setState(() => _processando = true);

    try {
      final produto = await ApiService.buscarPorCodigo(codigo);

      if (produto != null) {
        if (mounted) {
          context.read<CarrinhoProvider>().adicionarProduto(produto);
          _mostrarSnackBar(
            '✅ ${produto.nome} adicionado!',
            cor: Colors.green,
          );
        }
      } else {
        if (mounted) {
          _mostrarDialogoNovoProduto(codigo);
        }
      }
    } catch (e) {
      if (mounted) {
        _mostrarSnackBar(
          '❌ Erro de conexão com o servidor',
          cor: Colors.red,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processando = false);
      }
    }
  }

  void _mostrarDialogoNovoProduto(String codigo) {
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
              _irParaCadastro(codigo);
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  void _irParaCadastro(String codigo) {
    // Por enquanto apenas mostra mensagem
    _mostrarSnackBar('Função de cadastro em breve!', cor: Colors.orange);
  }

  void _mostrarSnackBar(String mensagem, {Color cor = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor de Códigos'),
        actions: [
          // Botão do carrinho com contador
          Consumer<CarrinhoProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, '/carrinho');
                    },
                  ),
                  if (provider.carrinho.totalItens > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${provider.carrinho.totalItens}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              if (barcode.rawValue != null) {
                _processarCodigo(barcode.rawValue!);
              }
            },
          ),
          if (_processando)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Processando...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          // Overlay com instruções
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Aponte a câmera para o código de barras do produto',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
}