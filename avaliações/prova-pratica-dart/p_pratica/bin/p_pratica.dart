import 'dart:convert';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

//Criação da classe Cliente
class Cliente {
  int codigo;
  String nome;
  int tipoCliente;

  Cliente(this.codigo, this.nome, this.tipoCliente);

  //Transformando em Json
  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nome': nome,
        'tipoCliente': tipoCliente,
      };
}

//Criação da classe Vendedor
class Vendedor {
  int codigo;
  String nome;
  double comissao;

  Vendedor(this.codigo, this.nome, this.comissao);

  //Transformando em Json
  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nome': nome,
        'comissao': comissao,
      };
}
  //Criação da classe Veiculo
class Veiculo {
  int codigo;
  String descricao;
  double valor;

  Veiculo(this.codigo, this.descricao, this.valor);

  //Transformando em Json
  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'descricao': descricao,
        'valor': valor,
      };
}

//Criação da classe ItemPedido
class ItemPedido {
  int sequencial;
  String descricao;
  int quantidade;
  double valor;

  ItemPedido(this.sequencial, this.descricao, this.quantidade, this.valor);

  //Transformando em Json
  Map<String, dynamic> toJson() => {
        'sequencial': sequencial,
        'descricao': descricao,
        'quantidade': quantidade,
        'valor': valor,
      };
}

  //Criação da classe PedidoVenda
class PedidoVenda {
  String codigo;
  DateTime data;
  double valorPedido;
  Cliente cliente;
  Vendedor vendedor;
  Veiculo veiculo;
  List<ItemPedido> items;

  PedidoVenda(this.codigo, this.data, this.valorPedido, this.cliente,
      this.vendedor, this.veiculo, this.items);

  double calcularPedido() {
    valorPedido = items.fold(0, (sum, item) => sum + (item.valor * item.quantidade));
    return valorPedido;
  }

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'data': data.toIso8601String(),
        'valorPedido': valorPedido,
        'cliente': cliente.toJson(),
        'vendedor': vendedor.toJson(),
        'veiculo': veiculo.toJson(),
        'items': items.map((item) => item.toJson()).toList(),
      };
}

void main() async {
  var cliente = Cliente(35, "Arthur Lima", 0);
  var vendedor = Vendedor(13, "Seu Frederico", 3000.00);
  var veiculo = Veiculo(2000, "Opala 2010", 9000.00);

  var itens = [
    ItemPedido(1, "Entrada", 1, 2000.00),
    ItemPedido(2, "Parcelas mensais", 7, 1000.00),
  ];

  var pedido = PedidoVenda("P001", DateTime.now(), 0.0, cliente, vendedor, veiculo, itens);
  pedido.calcularPedido();

  var encoder = JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(pedido.toJson());

  final smtpServer = gmail('arthur.santos08@aluno.ifce.edu.br', 'iuey dspz zerm mucx');

  final message = Message()
    ..from = Address('arthur.santos08@aluno.ifce.edu.br', 'Arthur Lima dos Santos')
    ..recipients.add('taveira@ifce.edu.br')
    ..subject = ' PROVA PRATICA-DART.'
    ..text = jsonString;

  try {
    final sendReport = await send(message, smtpServer);
    print('Mensagem enviada: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Erro ao enviar email: $e');
  }
}