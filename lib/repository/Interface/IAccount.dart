abstract class IAccount {
  getAccountById();
  assignBeneficiary();
  getSubAccounts(int accountId, int countryId, String userId);
  saveAccount();
  createMasterAccount();
  searchForAccount();
  searchAccounts();
  getAccountsSummary();
  getCountryAccountsSummary();
  getCompanyAccountsInfo();
  getIndividualAccountsInfo();
  getSubAccountsInfo();
  getAccountsInfo();
  getVendorAccountsInfo();
}