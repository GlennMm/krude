import 'package:krude_digital/models/RequestModels/PurchaseFuel.dart';

abstract class ITransation {
  getTransaction();
  swapFuelForInternational();
  swapFuel();
  generateCoupons();
  redeem();
  getSaleDetails();
  sell();
  retractPrintCoupon();
  purchaseFuel(PurchaseFuelRequestModel model);
  transaferFromAccounts();
  transferToAccounts();
  transafer(form);
}