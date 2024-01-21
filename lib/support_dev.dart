import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
import 'package:flutter_pay_upi/model/upi_response.dart';
import 'package:flutter_pay_upi/utils/widget/upi_app_list.dart';

import 'package:url_launcher/url_launcher.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage>
    with WidgetsBindingObserver {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? paymentApp;
  String payeeVpa = "7034694252@okbizaxis";
  String payeeName = "Market360";
  String payeeMerchantCode = "5137";
  String transactionId = "36487564312786546754367876510947645";
  String description = "quran app";
  String amount = "1";
  String currency = "INR";

  // "7034694252@okbizaxis",
  // "SAKEENA .",
  // "36487564312786546754367876510947645",
  // "1",
  // txnRefId: '8536084680724697572',
  // refUrl: 'https://najad.dev',
  // txnNotes: "quran app",
  // merchantChannel: );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration containerDecoration = BoxDecoration(
      // color: Colors.white,
      border: Border.all(
        width: 1,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(2, 2),
          blurRadius: 6,
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        title: const Text('Support Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // // buildTextField("Payment App", (value) => paymentApp = value),
                  // buildTextField("Payee VPA", (value) => payeeVpa),
                  // SizedBox(height: 8),
                  // buildTextField("Payee Name", (value) => payeeName),
                  // SizedBox(height: 8),
                  // buildTextField("Payee Merchant Code",
                  //     (value) => payeeMerchantCode = value),
                  // SizedBox(height: 8),
                  // buildTextField(
                  //     "Transaction ID", (value) => transactionId = value),
                  // SizedBox(height: 8),
                  // buildTextField(
                  //     "Description", (value) => description = value),
                  // SizedBox(height: 8),
                  // buildTextField("Amount", (value) => amount = value,
                  //     keyboardType: TextInputType.number),
                  // SizedBox(height: 8),
                  // buildCurrencyDropdown(),
                  SizedBox(height: 20),
                  Expanded(
                    child: UPIAppList(onClick: (upiApp) async {
                      FlutterPayUpiManager.startPayment(
                          paymentApp: upiApp!,
                          payeeVpa: payeeVpa,
                          payeeName: payeeName,
                          transactionId: transactionId,
                          transactionRefId: "BCR2DN4T3G27PGJZ",
                          payeeMerchantCode: payeeMerchantCode,
                          description: description,
                          amount: "2",
                          //currency: currency,
                          response: (UpiResponse response, String amount) {
                            _showTransactionDetailsDialog(response, amount);
                          },
                          error: (e) {
                            _showRoundedDialog(context, e.toString());
                          });
                    }), // UPIAppList takes the available height
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Support the developer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text(
                    'Empower Islamic app development without ads! Contribute as low as 1 INR to ensure a seamless and ad-free experience. Your support fosters a dedicated space for spiritual growth. Let\'s build together. Donate now!'),
                ManualUPISection(containerDecoration: containerDecoration),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 150,
                  decoration: containerDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Paypal',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const Divider(),
                      const Text('PayPal ID: onajad@gmail.com'),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: payPalLauncher,
                        child: Image.asset(
                          'assets/paypal_donate_button.png',
                          width: 180,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> payPalLauncher() async {
    Uri url = Uri.parse('https://www.paypal.com/paypalme/najadt');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget buildTextField(String labelText, void Function(String?) onChanged,
      {TextInputType? keyboardType}) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      ),
    );
  }

  // Widget buildCurrencyDropdown() {
  //   return DropdownButtonFormField<String>(
  //     value: currency,
  //     onChanged: (String? value) {
  //       setState(() {
  //         currency = value;
  //       });
  //     },
  //     items: ['INR'].map((String currency) {
  //       return DropdownMenuItem<String>(
  //         value: currency,
  //         child: Text(currency),
  //       );
  //     }).toList(),
  //     decoration: InputDecoration(
  //       labelText: 'Currency',
  //       border: OutlineInputBorder(),
  //     ),
  //   );
  // }

  void _showRoundedDialog(BuildContext context, String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text('$message'),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTransactionDetailsDialog(
      UpiResponse upiRequestParams, String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Transaction Details'),
          children: [
            _buildDetailRow('Txn ID', upiRequestParams.transactionID ?? "N/A"),
            _buildDetailRow(
                'Response Code', upiRequestParams.responseCode ?? "N/A"),
            _buildDetailRow('Approval Reference No',
                upiRequestParams.approvalReferenceNo ?? "N/A"),
            _buildDetailRow(
                'Txn Ref Id', upiRequestParams.transactionReferenceId ?? "N/A"),
            _buildDetailRow('Status', upiRequestParams.status ?? "N/A"),
            _buildDetailRow('Amount', amount),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          Text('$key:', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(width: 8.0),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // isLoading
      if (Platform.isIOS) {
        ///Develop a method to verify transactions, as iOS does not provide an
        ///immediate response upon successful payment. The verification process
        ///involves checking the method when the application regains focus to
        ///determine whether the transaction was successful.
      }
    }
  }
}

class ManualUPISection extends StatelessWidget {
  const ManualUPISection({
    super.key,
    required this.containerDecoration,
  });

  final BoxDecoration containerDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      height: 180,
      decoration: containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('UPI Payment',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('UPI ID: 9633645334@sbi'),
              SizedBox(
                height: 20,
                child:
                    CopyToClipBoardElevatedButton(copytext: '9633645334@sbi'),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GooglePay/PhonePay: 9633645334'),
              SizedBox(
                height: 20,
                child: CopyToClipBoardElevatedButton(copytext: '9633645334'),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Image.asset('assets/upi_payments.png')
        ],
      ),
    );
  }
}

class CopyToClipBoardElevatedButton extends StatelessWidget {
  final String copytext;
  const CopyToClipBoardElevatedButton({
    Key? key,
    required this.copytext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.green))),
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: copytext)).then(
            (value) {
              const snackBar = SnackBar(
                content: Text('Copied to Clipboard'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        },
        child: Text(
          'copy',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.green),
        ));
  }
}
