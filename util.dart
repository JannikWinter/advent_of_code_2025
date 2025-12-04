extension StringChars on String {
  Iterable<String> get chars => [
    for (int i = 0; i < length; i++) substring(i, i + 1),
  ];
}
