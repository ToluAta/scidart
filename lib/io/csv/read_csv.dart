import 'dart:convert';
import 'dart:core';

import 'package:scidart/io/txt/read_lines_txt.dart';
import 'package:scidart/numdart/numdart.dart';

///  Read a CSV file and return a List where each element is a row of the file
///  [fileName] : file name
///  [baseDir] : optional, base directory to the file, if not informed, get current script path.
///  [delimiter] : optional, string used to separate values, by default is ";"
///  [skipHeader] : optional, the number of lines to skip at the beginning of the file, default is 0
///  [skipFooter] : optional, the number of lines to skip at the end of the file, default is 0
///  [tryConvertToArray2d] : optional, try convert the dynamic list to a Array2d list, if don't have success, return
///     the dynamic list itself, default is false
///  [encoding] : optional, the encoding of the file, default is utf8
///  Return a List<List> container the CSV data with all the numbers parsed.
///  https://github.com/numpy/numpy/blob/v1.16.1/numpy/lib/npyio.py#L1536-L2219
///  https://flutterframework.com/read-csv-file-by-dart/
///  https://stackoverflow.com/questions/20815913/how-to-stream-a-file-line-by-line-in-dart
///  https://api.dartlang.org/stable/2.4.0/dart-io/File-class.html
Future<dynamic> readCSV(String fileName,
    {String baseDir,
    String delimiter = ";",
    int skipHeader = 0,
    int skipFooter = 0,
    bool tryConvertToArray2d = false,
    Encoding encoding = utf8}) async {
  final lines =
      await readLinesTxt(fileName, baseDir: baseDir, encoding: encoding);
  List<List> data = List();

  for (var l = skipHeader; l < lines.length - skipFooter; l++) {
    // Process results.
    List rows = lines[l].split(delimiter); // split by delimiter
    List rows2 = List();
    for (var row in rows) {
      var aux = num.tryParse(row);
      rows2.add(aux != null ? aux : row);
    }
    data.add(rows2);
  }

  if (tryConvertToArray2d) {
    try {
      var dataArray2d = Array2d.empty();

      for (var row in data) {
        var arrayRow = Array.empty();
        row.forEach((i) => arrayRow.add(i));
        dataArray2d.add(arrayRow);
      }

      return dataArray2d;
    } catch (e) {
      return data;
    }
  } else {
    return data;
  }
}
