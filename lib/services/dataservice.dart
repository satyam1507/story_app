import 'package:http/http.dart' as http;
import 'package:story_app/models/dataModel.dart';

class DataService {
  var client = http.Client();

  Future<List<Product>> getProducts() async {
    var response =
        await client.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var productList = productListFromJson(jsonString);
      return productList.products;
    } else {
      return [];
    }
  }
}
