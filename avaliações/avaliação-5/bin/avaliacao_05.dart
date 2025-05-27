import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer = gmail('arthur.santos08@aluno.ifce.edu.br', 'upmt pwmv elje smdd');

  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address('arthur.santos08@aluno.ifce.edu.br', 'Arthur')
    ..recipients.add('caua.rodrigues08@aluno.ifce.edu.br')
    ..subject = 'Avaliação 5'
    ..text = 'Chamando OLivier';

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    final sendReport = await send(message, smtpServer);

    // Exibe o resultado do envio do e-mail
    print('E-mail enviado');
    // Mostra os detalhes do e-mail enviado
    print('\n--- Detalhes do e-mail enviado ---');
    print('De: ${message.from}');
    print('Para: ${message.recipients.join(", ")}');
    print('Assunto: ${message.subject}');
    print('Corpo: ${message.text}');
    print('Enviado em: ${DateTime.now()}');

  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}
