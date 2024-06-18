import 'dart:convert';

import 'package:http/http.dart' as http;

class MainHttpClient{

  static const String _baseUrl = "http://192.168.43.32:8001/api";

  // Get Request 
  static Future<Map<String, dynamic>> get(String endpoint) async{
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> getDio(String endpoint) async{
    final response = await http.get(Uri.parse('$endpoint'));
    return _handleResponse(response);
  }

  // Post Request 

  static Future<Map<String, dynamic>> post(String endpoint, dynamic data, String token) async{
    // print("masuk sini");
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: json.encode(data),
    );
    // print(response.body.toString());
    return json.decode(response.body);
    // return _handleResponse(response); 
  }

  static Future<Map<String, dynamic>> postwImage(String endpoint, dynamic data, String token, dynamic _image) async{
    // print("masuk sini");

    // Ambil token dari session atau state management yang digunakan
    print('masuk sini');
    final uri = Uri.parse('$_baseUrl/$endpoint');
    final request = http.MultipartRequest('POST', uri);

    // Tambahkan headers
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = 'Bearer $token';

    // Tambahkan field data
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // request.fields['IDCardNumber'] = _idCardNumberController.text;
    // request.fields['Name'] = _nameController.text;
    // request.fields['BirthDay'] = _birthDayController.text;
    // request.fields['BirthPlace'] = _birthPlaceController.text;
    // request.fields['Gender'] = 'L'; // Sesuaikan dengan nilai yang valid
    // request.fields['Province'] = '32'; // Sesuaikan dengan nilai yang valid
    // request.fields['Regency'] = '3201'; // Sesuaikan dengan nilai yang valid
    // request.fields['District'] = '3201120'; // Sesuaikan dengan nilai yang valid
    // request.fields['Village'] = '3201120007'; // Sesuaikan dengan nilai yang valid
    // request.fields['Address'] = _addressController.text;
    // request.fields['Religion'] = _religionController.text;
    // request.fields['MaritalStatus'] = _maritalStatusController.text;
    // request.fields['Employment'] = _employmentController.text;
    // request.fields['Citizenship'] = _citizenshipController.text;
    // request.fields['FgActive'] = 'Y'; // Sesuaikan dengan nilai yang valid
    // request.fields['UserID'] = '1'; // Sesuaikan dengan nilai yang valid
    print('masuk sini 1');

    // Tambahkan file gambar jika ada
    if (_image != null) {
      final imageStream = http.ByteStream(_image!.openRead());
      final imageLength = await _image!.length();
      final multipartFile = http.MultipartFile('FileURL', imageStream, imageLength, filename: _image!.path.split('/').last);
      request.files.add(multipartFile);
    }
    print('masuk sini 2');

    final response = await request.send();
    // print(response.body.toString());
    print('masuk sini 3');

    final ressBody = await response.stream.bytesToString();
    print(ressBody);

    return json.decode(ressBody);
    // return _handleResponse(response); 
  }

  static Future<String> postStr(String endpoint, dynamic data, String token) async{
    // print("masuk sini");
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: json.encode(data),
    );
    // print(json.decode(response.body));
    return response.toString();
  }

  // Delete Request 
  static Future<Map<String, dynamic>> delete(String endpoint) async{
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Post Request 

  static Future<Map<String, dynamic>> put(String endpoint, dynamic data, String token) async{
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }


  static Map<String, dynamic> _handleResponse(http.Response response ){
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}