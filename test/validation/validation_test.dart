import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation_constants.dart';

void main() {
  group('validation', () {
    group('password',(){
      test('empty String', () {
        const emptyString = '';
        expect(emptyString.isPassword() is Left, true);
        expect(
            emptyString
                .isPassword()
                .leftMap((l) => l.message)
                .swap()
                .getOrElse(() => ''),
            ValidationConstants.passwordEmpty);
      });
    });
  });
}
