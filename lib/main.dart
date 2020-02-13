import 'package:flutter/material.dart';
import 'package:krude_digital/LogIn.dart';
import 'package:krude_digital/SignUp.dart';
import 'package:krude_digital/Views/Dashboard.dart';
import 'package:krude_digital/Views/PurchaseFuel.dart';
import 'package:krude_digital/Views/PurchaseInternational.dart';
import 'package:krude_digital/Views/RedeemFuel.dart';
import 'package:krude_digital/Views/SwapFuel.dart';
import 'package:krude_digital/Views/SwapFuelInternational.dart';
import 'package:krude_digital/Views/TransferFuel.dart';
import 'package:krude_digital/Views/components/scanqr.dart';
import 'package:krude_digital/repository/AccountRepository.dart';
import 'package:krude_digital/repository/ClientProductRepository.dart';
import 'package:krude_digital/repository/ClientRepository.dart';
import 'package:krude_digital/repository/CountryRepository.dart';
import 'package:krude_digital/repository/CouponsRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:krude_digital/repository/ProductPricesRepository.dart';
import 'package:krude_digital/repository/ProductsRepository.dart';
import 'package:krude_digital/repository/TransactionsRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() => runApp(
    Injector(
      inject: [
        Inject<AccountRepository>(() => AccountRepository()),
        Inject<ClientProductRepository>(() => ClientProductRepository()),
        Inject<ClientRepository>(() => ClientRepository()),
        Inject<CountryRepository>(() => CountryRepository()),
        Inject<CouponsRepository>(() => CouponsRepository()),
        Inject<ProductPricesRepository>(() => ProductPricesRepository()),
        Inject<ProductsRepository>(() => ProductsRepository()),
        Inject<LoggedInUserRepository>(() => LoggedInUserRepository()),
        Inject<TransactionsRepository>(() => TransactionsRepository())
      ],
      builder: (_) {
        return MaterialApp(
          title: 'Krude Digital',
          initialRoute: '/',
          routes: {
            '/': (context) => LogIn(),
            '/login': (context) => LogIn(),
            '/signup': (context) => Signup(),
            '/home': (context) => Dashboard(),
            '/wallet': (context) => Dashboard(),
            '/purchaseLocally': (context) => PurchaseFuelLocal(),
            '/purchaseRegionally': (context) => PurchaseInternational(),
            '/transferfuel': (context) => TransferFuel(),
            '/swapfuel': (context) => SwapFuel(),
            '/swapinternational': (context) => SwapFuelInternational(),
            '/reddem': (context) => RedeemFuel(),
            '/qr_scan': (context) => ScanScreen()
          },
        );
      },
    ));
