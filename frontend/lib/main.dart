import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/carrinho_provider.dart';
import 'screens/leitor_screen.dart';
import 'screens/carrinho_screen.dart';
import 'screens/cadastro_screen.dart';
import 'screens/digitar_screen.dart';
import 'widgets/escolha_leitor_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarrinhoProvider()),
      ],
      child: MaterialApp(
        title: 'Carrinho Inteligente',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/', // Rota inicial
        routes: {
          '/': (context) => const HomeScreen(),
          '/leitor': (context) => const LeitorScreen(),
          '/carrinho': (context) => const CarrinhoScreen(),
          '/cadastro': (context) => const CadastroScreen(),
          '/digitar': (context) => const DigitarScreen(), // NOVA ROTA
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _mostrarOpcoesLeitor(BuildContext context) async {
    final escolha = await showDialog<String>(
      context: context,
      builder: (context) => const EscolhaLeitorDialog(),
    );

    if (escolha == 'camera') {
      Navigator.pushNamed(context, '/leitor');
    } else if (escolha == 'digitar') {
      Navigator.pushNamed(context, '/digitar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho Inteligente'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 100,
              color: Colors.blue[300],
            ),
            const SizedBox(height: 32),
            const Text(
              'Bem-vindo ao Carrinho Inteligente',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Leia os códigos de barras e acompanhe suas compras em tempo real!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () => _mostrarOpcoesLeitor(context),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Adicionar Produto'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/carrinho');
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Ver Carrinho'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}