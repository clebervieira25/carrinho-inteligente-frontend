import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produto.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  // Buscar todos os produtos
  static Future<List<Produto>> buscarTodosProdutos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/produtos'));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Produto.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar produtos');
      }
    } catch (e) {
      throw Exception('Falha na conexão: $e');
    }
  }

  // Buscar produto por código de barras
  static Future<Produto?> buscarPorCodigo(String codigoBarras) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/produto/$codigoBarras'));
      
      if (response.statusCode == 200) {
        return Produto.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Erro na resposta do servidor');
      }
    } catch (e) {
      throw Exception('Falha na conexão: $e');
    }
  }

  // Cadastrar novo produto
  static Future<Produto> cadastrarProduto(Produto produto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/produto'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(produto.toJson()),
      );
      
      if (response.statusCode == 201) {
        return Produto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Erro ao cadastrar produto');
      }
    } catch (e) {
      throw Exception('Falha na conexão: $e');
    }
  }
}