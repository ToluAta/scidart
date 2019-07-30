import 'package:scidart/numdart/arrays_base/arrays_base.dart';
import 'package:scidart/numdart/linalg/matrix_operations/matrix_rank.dart';
import 'package:test/test.dart';

void main() {
  test('rank3x3', () {
    var a = Array2d([
      Array([0, 1, 2]),
      Array([1, 2, 1]),
      Array([2, 7, 8]),
    ]);

    var rankA = matrixRank(a);

    var rankAExpect = 2;

    expect(rankA, rankAExpect);
  });
}
