import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/view/components/animation/fade_in.dart';
import 'package:functional_rx_bloc/view/components/partial/form/address.dart';
import 'package:functional_rx_bloc/view/components/partial/form/smart_address_form_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validation/validation.dart';

class SmartAddressForm extends StatelessWidget {
  SmartAddressForm({
    this.initialAddress,
    this.postalCodeResolver,
    this.shouldFetchAddress = false,
  });

  /// postalCode -> api -> address -> (viewModelにwrite):void
  final Future<Address> Function(String postalCode) postalCodeResolver;

  /// 有効なpostalCode を入力したら自動で住所をfetchするかどうか
  final bool shouldFetchAddress;
  final Address initialAddress;
  void Function(String) onPostalCodeChange,
      onPrefectureChange,
      onCityChange,
      onAreaChange,
      onResidenceChange;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SmartAddressFormViewModel>(
      create: (_) => SmartAddressFormViewModel(
          shouldFetchAddress: shouldFetchAddress,
          postalCodeResolver: postalCodeResolver),
      child: Column(
        children: [
          Consumer<SmartAddressFormViewModel>(
              builder: (context, viewModel, __) => FadeIn(
                direction: SlideInDirection.y,
                child: _PostalCodeForm(
                      viewModel: viewModel,
                      postalCodeResolver: postalCodeResolver,
                    ),
                  )),
          Selector<SmartAddressFormViewModel, bool>(
            selector: (_, vm) => vm.isFetchingAddress,
            builder: (_, isFetching, __) => Stack(
              children: [
                if (isFetching)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                Column(
                  children: const [
                    FadeIn(
                      delay: 0.1,
                      direction: SlideInDirection.y,
                      child: _PrefectureForm(),
                    ),
                    FadeIn(
                      delay: 0.2,
                      direction: SlideInDirection.y,
                      child: _CityForm(),
                    ),
                    FadeIn(
                      delay: 0.3,
                      direction: SlideInDirection.y,
                      child: _AreaForm(),
                    ),
                    FadeIn(
                      delay: 0.5,
                        direction: SlideInDirection.y,
                        child: _ResidenceForm()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostalCodeForm extends StatelessWidget {
  final Future<Address> Function(String) postalCodeResolver;

  const _PostalCodeForm({this.viewModel, this.postalCodeResolver});

  final SmartAddressFormViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<SmartAddressFormViewModel>(context, listen: false)
            .postalCodeController;
    return _FormPadding(
      child: TextField(
        textInputAction: TextInputAction.next,
        onChanged: (postalCode) {
          if (postalCode.isPostalCode().isValid) {
            Provider.of<SmartAddressFormViewModel>(context, listen: false)
                .fetchAddressByPostalCode(postalCode);
          }
        },
        controller: controller,
        maxLength: 7,
        autofocus: false,
        decoration: InputDecoration(
            labelText: ' postal code',
            hintText: '',
            errorText: controller.text.isPostalCode().validate(),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      final vm = Provider.of<SmartAddressFormViewModel>(context,
                          listen: false);
                      vm.prefController.clear();
                      vm.cityController.clear();
                      vm.areaController.clear();
                      vm.residenceController.clear();
                      controller.clear();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.cancel,
                        color: Color.fromRGBO(61, 61, 61, 1),
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}

class _PrefectureForm extends StatelessWidget {
  const _PrefectureForm();

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<SmartAddressFormViewModel>(context, listen: false)
            .prefController;
    return _FormPadding(
      child: TextField(
        textInputAction: TextInputAction.next,
        autofocus: false,
        enabled:
            !Provider.of<SmartAddressFormViewModel>(context).isFetchingAddress,
        controller: controller,
        decoration: InputDecoration(
            labelText: 'prefecture',
            hintText: '',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _FormClear(controller),
              ],
            )),
      ),
    );
  }
}

class _CityForm extends StatelessWidget {
  const _CityForm();

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<SmartAddressFormViewModel>(context, listen: false)
            .cityController;
    return _FormPadding(
      child: TextField(
        textInputAction: TextInputAction.next,
        autofocus: false,
        enabled:
            !Provider.of<SmartAddressFormViewModel>(context).isFetchingAddress,
        controller: controller,
        decoration: InputDecoration(
            labelText: 'city',
            hintText: '',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _FormClear(controller),
              ],
            )),
      ),
    );
  }
}

class _AreaForm extends StatelessWidget {
  const _AreaForm();

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<SmartAddressFormViewModel>(context, listen: false)
            .areaController;
    return _FormPadding(
      child: TextField(
        textInputAction: TextInputAction.next,
        autofocus: false,
        enabled:
            !Provider.of<SmartAddressFormViewModel>(context).isFetchingAddress,
        controller: controller,
        decoration: InputDecoration(
            labelText: 'area',
            hintText: '',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _FormClear(controller),
              ],
            )),
      ),
    );
  }
}

class _ResidenceForm extends StatelessWidget {
  const _ResidenceForm();

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<SmartAddressFormViewModel>(context, listen: false)
            .residenceController;
    return _FormPadding(
      child: TextField(
        textInputAction: TextInputAction.done,
        autofocus: false,
        enabled:
            !Provider.of<SmartAddressFormViewModel>(context).isFetchingAddress,
        controller: controller,
        decoration: InputDecoration(
            labelText: 'more',
            hintText: '',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _FormClear(controller),
              ],
            )),
      ),
    );
  }
}

class _FormPadding extends StatelessWidget {
  const _FormPadding(
      {this.child, this.padding = const EdgeInsets.fromLTRB(16, 19, 16, 0)});

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}

class _FormClear extends StatelessWidget {
  const _FormClear(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: controller.clear,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.cancel,
            color: Color.fromRGBO(61, 61, 61, 1),
          ),
        ));
  }
}
