import 'dart:io';

import 'package:monkey_lang/evaluator/evaluator.dart';
import 'package:monkey_lang/lexer/lexer.dart';
import 'package:monkey_lang/monkey/monkey.dart';
import 'package:monkey_lang/object/environment.dart';
import 'package:monkey_lang/parser/parser.dart';

void start() {
  const prompt = '>> ';
  final env = Environment.freshEnvironment();

  while (true) {
    stdout.write(prompt);

    var inputText = stdin.readLineSync();
    if (inputText == null) {
      return;
    }

    var parser = Parser(Lexer(inputText));
    var program = parser.parseProgram();
    if (parser.hasErrors()) {
      print(parser.getErrorsAsString());
      continue;
    }

    try {
      var evaluated = eval(program, env);
      if (evaluated != null) {
        print(evaluated.inspect());
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

void main() {
  print(Monkey.WELCOME);
  start();
}
