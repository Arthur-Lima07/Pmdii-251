import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('alunos.db');

  // Criação da tabela
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL
    );
  ''');

  while (true) {
    print('\n=== MENU ===');
    print('1. Inserir aluno');
    print('2. Listar alunos');
    print('3. Sair');
    stdout.write('Escolha uma opção: ');
    final opcao = stdin.readLineSync();

    if (opcao == '1') {
      inserirAluno(db);
    } else if (opcao == '2') {
      listarAlunos(db);
    } else if (opcao == '3') {
      db.dispose();
      print('Encerrando...');
      break;
    } else {
      print('Opção inválida!');
    }
  }
}

void inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno: ');
  String? nome = stdin.readLineSync();

  if (nome != null && nome.trim().isNotEmpty) {
    db.execute('INSERT INTO TB_ALUNO (nome) VALUES (?)', [nome.trim()]);
    print('Aluno inserido com sucesso!');
  } else {
    print('Nome inválido!');
  }
}

void listarAlunos(Database db) {
  final ResultSet resultSet = db.select('SELECT * FROM TB_ALUNO');

  print('\n--- Lista de Alunos ---');
  for (final row in resultSet) {
    print('ID: ${row['id']}, Nome: ${row['nome']}');
  }
}