import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/widgets/linear_loader.dart';
import 'package:jugaad_junction/features/address/services/address_service.dart';
import 'package:jugaad_junction/features/home/widgets/address_box.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/payment_config.dart';
import '../../../common/utils.dart';
import '../../../initials/widgets/custom_textfield.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-screen';
  const AddressScreen({super.key, required this.totalsum});
  final String totalsum;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _townController = TextEditingController();

  final List<PaymentItem> _paymentItems = [];
  String addressToBeUsed = "";
  final AddressService addressService = AddressService();

  // final Future<PaymentConfiguration> _googlePayConfigFuture =
  //     PaymentConfiguration.fromAsset('default_payment_profile_google_pay.json');

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressService.saveUserAddress(
          context: context, address: addressToBeUsed);
    }

    addressService.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalsum),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = _flatController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _townController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${_flatController.text}, ${_areaController.text}, ${_townController.text} - ${_pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  void initState() {
    super.initState();
    _paymentItems.add(
      PaymentItem(
        amount: widget.totalsum,
        label: "Total Amount",
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    _flatController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _townController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty) ...[
                const AddressBox(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _flatController,
                      labelText: 'Flat, House no. Building',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: _areaController,
                      labelText: 'Area, Street',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: _pincodeController,
                      labelText: 'Pincode',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: _townController,
                      labelText: 'Town/City',
                    ),
                  ],
                ),
              ),
              /*
              // Implement for real use case: you have to add real visa/master card to proceed
              FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? GooglePayButton(
                        height: 100,
                        width: 250,
                        onPressed: () => payPressed(address),
                        paymentConfiguration: snapshot.data!,
                        paymentItems: _paymentItems,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: LinearLoader(),
                        ),
                      )
                    : const SizedBox.shrink()
              ),
              */
              //Gpay documentation->test with sample credit cards->join test card suite group by google : for testing purpose
              Platform.isIOS
                  ? ApplePayButton(
                      onPressed: () => payPressed(address),
                      paymentConfiguration:
                          PaymentConfiguration.fromJsonString(defaultApplePay),
                      paymentItems: _paymentItems,
                      style: ApplePayButtonStyle.black,
                      width: double.infinity,
                      height: 50,
                      type: ApplePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (result) =>
                          debugPrint('Payment Result $result'),
                      loadingIndicator: const Center(
                        child: LinearLoader(),
                      ),
                    )
                  : GooglePayButton(
                      onPressed: () => payPressed(address),
                      paymentConfiguration:
                          PaymentConfiguration.fromJsonString(defaultGooglePay),
                      paymentItems: _paymentItems,
                      type: GooglePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: onGooglePayResult,
                      loadingIndicator: const Center(
                        child: LinearLoader(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
