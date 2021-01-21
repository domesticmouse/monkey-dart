import 'package:monkey_lang/token/token.dart';

class Lexer {
  String input;

  /// current position in input (points to current char)
  int position = 0;

  /// current reading position in input (after current char)
  int readPosition = 0;

  /// current char under examination
  String? ch;

  Lexer(this.input) {
    readChar();
  }

  void readChar() {
    if (readPosition >= input.length) {
      ch = null;
    } else {
      ch = input[readPosition];
    }
    position = readPosition;
    readPosition += 1;
  }

  Token nextToken() {
    skipWhitespace();

    Token token;
    if (ch == null) {
      token = Token(Token.EOF, '');
    } else {
      switch (ch) {
        case '=':
          if (peekChar() == '=') {
            var temp = ch!;
            readChar();
            token = Token(Token.EQ, temp + ch!);
          } else {
            token = Token(Token.ASSIGN, ch);
          }
          break;
        case ';':
          token = Token(Token.SEMICOLON, ch);
          break;
        case '(':
          token = Token(Token.LPAREN, ch);
          break;
        case ')':
          token = Token(Token.RPAREN, ch);
          break;
        case ',':
          token = Token(Token.COMMA, ch);
          break;
        case '+':
          token = Token(Token.PLUS, ch);
          break;
        case '-':
          token = Token(Token.MINUS, ch);
          break;
        case '!':
          if (peekChar() == '=') {
            var temp = ch!;
            readChar();
            token = Token(Token.NOT_EQ, temp + ch!);
          } else {
            token = Token(Token.BANG, ch);
          }
          break;
        case '/':
          token = Token(Token.SLASH, ch);
          break;
        case '*':
          token = Token(Token.ASTERISK, ch);
          break;
        case '<':
          token = Token(Token.LT, ch);
          break;
        case '>':
          token = Token(Token.GT, ch);
          break;
        case '{':
          token = Token(Token.LBRACE, ch);
          break;
        case '}':
          token = Token(Token.RBRACE, ch);
          break;
        case '"':
          token = Token(Token.STRING, readString());
          break;
        case '[':
          token = Token(Token.LBRACKET, ch);
          break;
        case ']':
          token = Token(Token.RBRACKET, ch);
          break;
        case ':':
          token = Token(Token.COLON, ch);
          break;
        default:
          if (isLetter(ch)) {
            var ident = readIdentifier();
            return Token(Token.lookupIdent(ident), ident);
          } else if (isDigit(ch)) {
            return Token(Token.INT, readNumber());
          } else {
            token = Token(Token.ILLEGAL, ch);
          }
          break;
      }
    }

    readChar();
    return token;
  }

  void skipWhitespace() {
    while (isWhitespace(ch)) {
      readChar();
    }
  }

  static int code(String ch) {
    return ch.codeUnitAt(0);
  }

  static final int a = code('a');
  static final int z = code('z');
  static final int A = code('A');
  static final int Z = code('Z');
  static final int _ = code('_');
  static final int space = code(' ');
  static final int tab = code('\t');
  static final int newline = code('\n');
  static final int carriage = code('\r');
  static final int zero = code('0');
  static final int nine = code('9');

  bool isDigit(String? ch) {
    if (ch == null) {
      return false;
    }
    var c = ch.codeUnitAt(0);
    return c >= zero && c <= nine;
  }

  bool isWhitespace(String? ch) {
    if (ch == null) {
      return false;
    }
    var c = ch.codeUnitAt(0);
    return c == space || c == tab || c == newline || c == carriage;
  }

  static bool isLetter(String? ch) {
    if (ch == null) {
      return false;
    }
    var c = ch.codeUnitAt(0);
    return a <= c && c <= z || A <= c && c <= Z || c == _;
  }

  String readIdentifier() {
    var firstPosition = position;
    while (isLetter(ch)) {
      readChar();
    }
    return input.substring(firstPosition, position);
  }

  String readNumber() {
    var firstPosition = position;
    while (isDigit(ch)) {
      readChar();
    }
    return input.substring(firstPosition, position);
  }

  String readString() {
    var firstPosition = position + 1;
    while (true) {
      readChar();
      if (ch == '"') {
        break;
      }
    }
    return input.substring(firstPosition, position);
  }

  String? peekChar() {
    if (readPosition >= input.length) {
      return null;
    } else {
      return input[readPosition];
    }
  }
}
