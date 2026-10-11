class Produto {
  final int? id;
  final String codigoBarras;
  final String nome;
  final double preco;
  final String? categoria;
  int quantidade;

  Produto({
    this.id,
    required this.codigoBarras,
    required this.nome,
    required this.preco,
    this.categoria,
    this.quantidade = 1,
  });

  // Converter JSON para Produto (ignorando campos extras)
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] ?? 0,
      codigoBarras: json['codigo_barras'] ?? '',
      nome: json['nome'] ?? 'Produto sem nome',
      preco: double.parse(json['preco']?.toString() ?? '0'),
      categoria: json['categoria'] ?? 'Outros',
    );
  }

  // Converter Produto para JSON
  Map<String, dynamic> toJson() {
    return {
      'codigo_barras': codigoBarras,
      'nome': nome,
      'preco': preco,
      'categoria': categoria,
    };
  }

  // Calcular subtotal do item
  double get subtotal => preco * quantidade;

  @override
  String toString() {
    return '$nome - R\$ ${preco.toStringAsFixed(2)} (x$quantidade)';
  }
}