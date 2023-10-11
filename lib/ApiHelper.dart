
import 'package:http/http.dart' as http;
import 'package:random_jok_app/JokeModal.dart';


class ApiHelper{
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<RandomjokeModal?> getData()async{
    http.Response response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    if(response.statusCode==200){
      RandomjokeModal randomJokeModal = randomjokeModalFromJson(response.body);
      return randomJokeModal;
    }
    return null;
  }

}