import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/details/person_detalis/person_model.dart';

class PersonService {

  Future<FullPersonModel?> fetchPersonDetails(int personId) async {
  try {
    final detailResponse = await http.get(
      Uri.parse('$kbaseurl/person/$personId?api_key=$kapikey&language=en-US'),
    );

    final creditsResponse = await http.get(
      Uri.parse('$kbaseurl/person/$personId/combined_credits?api_key=$kapikey&language=en-US'),
    );

    if (detailResponse.statusCode == 200 && creditsResponse.statusCode == 200) {
      final detailsJson = jsonDecode(detailResponse.body);
      final creditsJson = jsonDecode(creditsResponse.body);
      return FullPersonModel.fromJson(detailsJson, creditsJson);
    } else {
      return null;
    }
  } catch (e) {
    log('Error fetching person details: $e');
    return null;
  }
}


}
