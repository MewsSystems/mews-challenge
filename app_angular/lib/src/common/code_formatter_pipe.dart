import 'package:angular/angular.dart';

@Pipe('formatCode')
class CodeFormatterPipe extends PipeTransform {
  String transform(String value) =>
      value?.replaceAll('\\n', '\n')?.replaceAll('\\-n', '\\n');
}
