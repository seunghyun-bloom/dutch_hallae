import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var thousandSeparateFormat = MaskTextInputFormatter(
  mask: '###,###,###,###',
  filter: {'#': RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var phoneNumberFormat = MaskTextInputFormatter(
  mask: '###-####-####',
  filter: {'#': RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
