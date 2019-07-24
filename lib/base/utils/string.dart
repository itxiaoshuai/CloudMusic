String stringFilter(String str) {
  return str.replaceAll(new RegExp(r'\n'), '');
}
