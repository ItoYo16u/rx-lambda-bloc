import 'dart:async';

import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validation/validation.dart';
import 'package:functional_rx_bloc/view/components/partial/form/address.dart';

class SmartAddressFormViewModel extends ChangeNotifier {
  SmartAddressFormViewModel(
      {this.initialAddress,
      this.shouldFetchAddress = false,
      this.postalCodeResolver}) {
    postalCodeController.text = initialAddress?.postalCode ?? '';
    prefController.text = initialAddress?.prefecture ?? '';
    cityController.text = initialAddress?.city ?? '';
    areaController.text = initialAddress?.area ?? '';
    residenceController.text = initialAddress?.residence ?? '';
    postalCodeController.addListener(() {
      if (postalCodeController.text.isPostalCode().isValid) {
        isValidPostalCode = true;
      } else {
        isValidPostalCode = false;
      }
      notifyListeners();
    });
  }

  bool isValidPostalCode = false;
  final Address initialAddress;
  final bool shouldFetchAddress;
  final Future<Address> Function(String postalCode) postalCodeResolver;

  final TextEditingController postalCodeController = TextEditingController();

  String get postalCode => postalCodeController.text;

  /// 都道府県
  final TextEditingController prefController = TextEditingController();

  /// 市区町村
  final TextEditingController cityController = TextEditingController();

  /// 町域
  final TextEditingController areaController = TextEditingController();

  /// 建物名/部屋番号
  final TextEditingController residenceController = TextEditingController();

  bool isFetchingAddress = false;

  void updateIsFetchingAddress({@required bool isFetching}) {
    isFetchingAddress = isFetching;
    notifyListeners();
  }

  Future<void> fetchAddressByPostalCode(String postalCode) async {
    if (!shouldFetchAddress) {
      return;
    }
    if (!postalCode.isPostalCode().isValid) {
      return;
    }
    if (postalCodeResolver == null) {
      updateIsFetchingAddress(isFetching: true);
      final address = await _mockResolver(postalCode);
      prefController.text = address.prefecture;
      cityController.text = address.city;
      areaController.text = address.area;
      updateIsFetchingAddress(isFetching: false);
      return;
    }
    final address = await postalCodeResolver(postalCode);
    prefController.text = address.prefecture;
    cityController.text = address.city;
    areaController.text = address.area;
  }

  Future<Address> _mockResolver(String postalCode) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return Address(
      postalCode: postalCode,
      prefecture: '京都府',
      city: '京都市 左京区 吉田二本松町',
      area: '2-10-1',
    );
  }

  @override
  void dispose() {
    postalCodeController.dispose();
    prefController.dispose();
    cityController.dispose();
    areaController.dispose();
    super.dispose();
  }
}
