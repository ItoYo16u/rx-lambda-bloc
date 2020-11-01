import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation_constants.dart';

final RegExp _emailRegExp = RegExp(ValidationConstants.emailRegExp);
final RegExp _capitalRegExp = RegExp('[A-Z]');
final RegExp _lowerRegExp = RegExp('[a-z]');
final RegExp _numberRegExp = RegExp('[0-9]');
final RegExp _urlRegExp = RegExp(ValidationConstants.urlRegExp);
final RegExp _internationalPhoneNumber =
    RegExp(ValidationConstants.internationalPhoneNumberRegExp);

extension ValidationString on String {
  Either<FormatException, String> _toValidatable() => Right(this);

  Either<FormatException, String> isPassword() => _toValidatable()
      ._isNotEmpty(errorMessage: ValidationConstants.passwordEmpty)
      ._isInRange(
          from: 4,
          upTo: 16,
          errorMessageBuilder: ValidationConstants.passwordLengthError)
      ._hasCapital(errorMessage: ValidationConstants.atLeastOneCapitalRequired)
      ._hasLower(errorMessage: ValidationConstants.atLeastOneLowerRequired)
      ._hasNumber(errorMessage: ValidationConstants.atLeastOneNumberRequired);

  Either<FormatException, String> isEmail() => _toValidatable()
      ._isNotEmpty(errorMessage: ValidationConstants.passwordEmpty)
      ._matchRgx(_emailRegExp,
          errorMessage: ValidationConstants.emailInvalidFormat);

  Either<FormatException, String> isSimplePhoneNumber() => _toValidatable()
      ._isNotEmpty(errorMessage: ValidationConstants.mustNotBeEmpty)
      ._isNumber(errorMessage: ValidationConstants.mustBeNumber);

  Either<FormatException, String> isUrl() => _toValidatable()
      ._isNotEmpty(errorMessage: ValidationConstants.mustNotBeEmpty)
      ._matchRgx(_urlRegExp,
          errorMessage: ValidationConstants.invalidUrlFormat);
}

extension ValidationEitherExt on Either<FormatException, String> {
  Either<FormatException, String> _isNotEmpty({@required String errorMessage}) {
    try {
      return map((r) {
        if (r.isEmpty) throw FormatException(errorMessage);
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _isLength(int n,
      {@required String Function(int _) errorMessageBuilder}) {
    try {
      return map((r) {
        if (r.length != n) throw FormatException(errorMessageBuilder(n));
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _isEqOrMoreThan(int n,
      {@required String Function(int _) errorMessageBuilder}) {
    try {
      return map((r) {
        if (r.length < n) throw FormatException(errorMessageBuilder(n));
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _isLessThan(int n,
      {@required String Function(int _) errorMessageBuilder}) {
    try {
      return map((r) {
        if (r.length >= n) throw FormatException(errorMessageBuilder(n));
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _isEqOrLessThan(int n,
      {@required String Function(int _) errorMessageBuilder}) {
    try {
      return map((r) {
        if (r.length > n) throw FormatException(errorMessageBuilder(n));
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  /// from: inclusive, upTo: inclusive
  Either<FormatException, String> _isInRange(
      {@required int from,
      @required int upTo,
      @required String Function(int _, int __) errorMessageBuilder}) {
    try {
      return map((r) {
        if (r.length < from || r.length > upTo) {
          throw FormatException(errorMessageBuilder(from, upTo));
        }
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _hasCapital({@required String errorMessage}) {
    try {
      return map((r) {
        if (!r.contains(_capitalRegExp)) {
          throw FormatException(errorMessage);
        }
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _hasLower({@required String errorMessage}) {
    try {
      return map((r) {
        if (!r.contains(_lowerRegExp)) {
          throw FormatException(errorMessage);
        }
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _hasNumber({@required String errorMessage}) {
    try {
      return map((r) {
        if (!r.contains(_numberRegExp)) {
          throw FormatException(errorMessage);
        }
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _isNumber({@required String errorMessage}) {
    try {
      return map((r) {
        if (!RegExp(r'^\d+$').hasMatch(r)) {
          throw FormatException(errorMessage);
        }
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }

  Either<FormatException, String> _matchRgx(RegExp rgx,
      {@required String errorMessage}) {
    try {
      return map((r) {
        if (!rgx.hasMatch(r)) {
          throw FormatException(errorMessage);
        }
        return r;
      });
    } on FormatException catch (ex) {
      return Left(ex);
    }
  }
}
