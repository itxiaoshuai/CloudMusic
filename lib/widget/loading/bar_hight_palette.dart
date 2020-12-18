
class HightPalette {
  static final HightPalette primary = HightPalette(<double>[10.0,30,50,70,100]);

  HightPalette(List<double> colors) : _Hights = colors {
    // bool isNotEmpty：如果此集合中至少有一个元素，则返回true
    assert(colors.isNotEmpty);
  }

  final List<double> _Hights;

  double operator [](int index) => _Hights[index];

  // 返回集合中的元素数量
//  double get length => _Hights.length;

  double random(int index) => this[index];
}
