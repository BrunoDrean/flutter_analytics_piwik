// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_piwikpro/model/ecommerce_transaction_item.dart';
import 'package:flutter_piwikpro/flutter_piwikpro.dart';

void main() {
  final _ecommerceTransactionItems = [
    EcommerceTransactionItem(category: 'cat1', sku: 'sku1', name: 'name1', price: 20, quantity: 1),
    EcommerceTransactionItem(category: 'cat2', sku: 'sku2', name: 'name2', price: 10, quantity: 1),
    EcommerceTransactionItem(category: 'cat3', sku: 'sku3', name: 'name3', price: 30, quantity: 2),
  ];
  //Replace with your Tracking Server's values
  const String _siteId = '0c0a8661-8c10-4f59-b8fc-1c926cbac184';
  const String _baseUrl = 'https://astralprojection.promilci.com';
  final _flutterPiwik = FlutterPiwikPro.sharedInstance;

  runApp(MyApp(
    ecommerceTransactionItems: _ecommerceTransactionItems,
    siteId: _siteId,
    baseUrl: _baseUrl,
    flutterPiwik: _flutterPiwik,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {required this.ecommerceTransactionItems,
      required this.siteId,
      required this.baseUrl,
      required this.flutterPiwik,
      Key? key})
      : super(key: key);

  final List<EcommerceTransactionItem> ecommerceTransactionItems;
  final String siteId;
  final String baseUrl;
  final FlutterPiwikPro flutterPiwik;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextWidget('Configure Tracker', () async {
                    try {
                      final result =
                          await flutterPiwik.configureTracker(baseURL: baseUrl, siteId: siteId);
                      print(result);
                    } catch (exception) {
                      print(exception);
                    }
                  }),
                  _buildTextWidget('Set Anonymization State True', () async {
                    final result = await flutterPiwik.setAnonymizationState(true);
                    print(result);
                  }),
                  _buildTextWidget(
                    'Track Screen',
                    () async {
                      try {
                        final result =
                            await flutterPiwik.trackScreen(screenName: "test", title: "test title");
                        print(result);
                      } catch (exception) {
                        print(exception);
                      }
                    },
                  ),
                  _buildTextWidget('Track Custom Event', () async {
                    try {
                      final result = await flutterPiwik.trackCustomEvent(
                          action: 'test action',
                          category: 'test category',
                          name: 'test name',
                          path: 'test path',
                          value: 120);
                      print(result);
                    } catch (exception) {
                      print(exception);
                    }
                  }),
                  _buildTextWidget('Track Exception', () async {
                    try {
                      final result = await flutterPiwik.trackException(
                          description: "description of an exception", isFatal: false);
                      print(result);
                    } catch (exception) {
                      print(exception);
                    }
                  }),
                  _buildTextWidget('Track Download', () async {
                    try {
                      final result =
                          await flutterPiwik.trackDownload('http://your.server.com/bonusmap2.zip');
                      print(result);
                    } catch (exception) {
                      print(exception);
                    }
                  }),
                  _buildTextWidget('Track Ecommerce Transaction', () async {
                    final result = await flutterPiwik.trackEcommerceTransaction(
                      identifier: "testId",
                      grandTotal: 100,
                      subTotal: 10,
                      tax: 5,
                      shippingCost: 100,
                      discount: 6,
                      transactionItems: ecommerceTransactionItems,
                    );
                    print(result);
                  }),
                  _buildTextWidget('Track Social Interaction', () async {
                    final result = await flutterPiwik.trackSocialInteraction(
                      network: "facebook",
                      interaction: "like",
                      target: 'Target'
                    );
                    print(result);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextWidget(String title, VoidCallback? onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
      ),
    );
  }
}
