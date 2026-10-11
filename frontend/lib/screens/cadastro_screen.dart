import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/produto.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _codigoBarras;
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _categoriaController = TextEditingController();
  bool _carregando = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      _codigoBarras = args;
    } else {
      _codigoBarras = '';
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  Future<void> _cadastrarProduto() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    try {
      final produto = Produto(
        codigoBarras: _codigoBarras,
        nome: _nomeController.text,
        preco: double.parse(_precoController.text.replaceAll(',', '.')),
        categoria: _categoriaController.text.isEmpty ? null : _categoriaController.text,
      );

      await ApiService.cadastrarProduto(produto);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Produto cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Erro ao cadastrar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _carregando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _codigoBarras,
                decoration: const InputDecoration(
                  labelText: 'Código de Barras',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.qr_code),
                ),
                enabled: false,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(
                  labelText: 'Preço (R\$)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                  hintText: '0,00',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o preço';
                  }
                  try {
                    double.parse(value.replaceAll(',', '.'));
                  } catch (e) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoria (opcional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _carregando ? null : _cadastrarProduto,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _carregando
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Cadastrar Produto',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}