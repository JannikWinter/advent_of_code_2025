extension StringChars on String {
  Iterable<String> get chars => [for (int i = 0; i < length; i++) charAt(i)];

  String charAt(int index) {
    return substring(index, index + 1);
  }
}

const int maxInteger = 0x7FFFFFFFFFFFFFFF;
