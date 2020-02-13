import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/repository/CountryRepository.dart';

class CountriesState {
  CountryRepository _countryRepository = new CountryRepository();
  List<Country> countries = new List<Country>();

  CountriesState() {
    _countryRepository.getActiveCountries();
    countries = _countryRepository.countries;
  }


  Country searchCountryByName(String cName) {
    Country country =
        this.countries.firstWhere((country) => country.countryName == cName);
    return country;
  }
}
