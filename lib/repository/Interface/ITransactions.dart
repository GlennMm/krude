// import 'package:krude_digital/models/RequestModels/PurchaseFuel.dart';
import 'package:krude_digital/models/RequestModels/tranfers_to_subaccount.dart';

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
  transaferFromAccounts(TransaferRequestModel data);
  transferToAccounts(TransaferRequestModel data);
  transafer(form);
}

class PurchaseFuelRequestModel {
}