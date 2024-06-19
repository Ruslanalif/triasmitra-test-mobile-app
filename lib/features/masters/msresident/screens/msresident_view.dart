
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triasmitra_mobile_app/utils/constants/colors.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';
import 'package:triasmitra_mobile_app/utils/helpers/session_service.dart';
import 'package:triasmitra_mobile_app/utils/http/http_client.dart';

class MsresidentView extends StatefulWidget {
  const MsresidentView({super.key});

  @override
  State<MsresidentView> createState() => _MsresidentViewState();
}

class _MsresidentViewState extends State<MsresidentView> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _textEditingController = TextEditingController();
  final idCardNumber = TextEditingController();
  final name = TextEditingController();
  final birthPlace = TextEditingController();
  final birthDay = TextEditingController();
  final gender = TextEditingController();
  final province = TextEditingController();
  final regency = TextEditingController();
  final district = TextEditingController();
  final village = TextEditingController();
  final address = TextEditingController();
  final religion = TextEditingController();
  final maritalStatus = TextEditingController();
  final employment = TextEditingController();
  final citizenship = TextEditingController();

  final arguments = Get.arguments as Map<String, dynamic>;
  final SessionService _sessionService = SessionService();
  String _formTitle = 'View Data';
  String _token = 'Loading...';
  String _id = 'Loading...';
  dynamic resData = '';
  
  @override
  void initState() {
    super.initState();
    _loadSession();
    
  }

  Future<void> _loadSession() async {
    final session = await _sessionService.getSession();
    setState(() {
      _token = session['token'] ?? 'No token found';
      _id = session['id'] ?? 'No id found';
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    // MainDeviceUtils.hideKeyboard(context);
    final Map<String, String> data = {
      'prmType': "1",
    };
    final String token = _token;
    final getId = arguments['id'];
    final response = await MainHttpClient.post('msresidents/get-data/$getId', data, token);
    if (response['xStatus'] == '1') {
      setState(() {
        resData = response['data'][0];
        // print(resData['FileURL'].toString().length);
        idCardNumber.text = resData['IDCardNumber'];
        name.text = resData['Name'];
        birthPlace.text = resData['BirthPlace'];
        birthDay.text = resData['StrBirthDay'];
        gender.text = resData['StrGender'];
        province.text = resData['ProvinceName'];
        regency.text = resData['RegencyName'];
        district.text = resData['DistrictName'];
        village.text = resData['VillageName'];
        address.text = resData['Address'];
        religion.text = resData['Religion'];
        maritalStatus.text = resData['MaritalStatus'];
        employment.text = resData['Employment'];
        citizenship.text = resData['Citizenship'];
        // MainDeviceUtils.hideKeyboard(context);
      });
      print(resData);
      // print(provinces);
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(MainSize.defaultSpace),
            child: Column(
              children: [
                Text(_formTitle, style: Theme.of(context).textTheme.headlineMedium,),
                const SizedBox(height: MainSize.spaceBtwItems * 1.5,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ((resData).isNotEmpty && resData['FileURL'].toString().length > 0)
                      ? CachedNetworkImage(
                          imageUrl: resData['FileURL'],
                          width: MainHelperFunction.screenWidth() * 0.8,
                          height: MainHelperFunction.screenWidth() * 0.8 * 0.7,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Image.asset(
                          'assets/images/unselected-image.png',
                          width: MainHelperFunction.screenWidth() * 0.8,
                          height: MainHelperFunction.screenWidth() * 0.8 * 0.7,
                          fit: BoxFit.cover,
                        ),
                ), 
                const SizedBox(height: MainSize.spaceBtwItems * 1.7,),
                TextFormField(
                  controller: idCardNumber,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "NIK",
                    prefixIcon: Icon(Iconsax.card)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: name,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Nama Lengkap",
                    prefixIcon: Icon(Iconsax.user)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: gender,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Gender",
                    prefixIcon: Icon(Iconsax.user)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: birthPlace,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Tempat Lahir",
                          prefixIcon: Icon(Iconsax.location)
                        ),
                      ),
                    ),
                    const SizedBox(width: MainSize.spaceBtwItems * 0.5,),
                    Expanded(
                      child: TextFormField(
                        controller: birthDay,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Tanggal Lahir",
                          prefixIcon: Icon(Iconsax.calendar)
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: religion,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Agama",
                          prefixIcon: Icon(Iconsax.safe_home)
                        ),
                      ),
                    ),
                    const SizedBox(width: MainSize.spaceBtwItems * 0.5,),
                    Expanded(
                      child: TextFormField(
                        controller: maritalStatus,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Status Perkawinan",
                          prefixIcon: Icon(Iconsax.airpod)
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: employment,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Pekerjaan",
                          prefixIcon: Icon(Iconsax.money)
                        ),
                      ),
                    ),
                    const SizedBox(width: MainSize.spaceBtwItems * 0.5,),
                    Expanded(
                      child: TextFormField(
                        controller: citizenship,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Kewarganegaraan",
                          prefixIcon: Icon(Iconsax.flag)
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField( 
                  controller: province,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Provinsi",
                    prefixIcon: Icon(Iconsax.location)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: regency,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Kota/Kabupaten",
                    prefixIcon: Icon(Iconsax.location)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: district,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Kecamatan",
                    prefixIcon: Icon(Iconsax.location)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: village,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Desa/Kelurahan",
                    prefixIcon: Icon(Iconsax.location)
                  ),
                ),
                
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: address,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 3,
                  readOnly: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Alamat Lengkap. ",
                    // prefixIcon: Icon(Iconsax.location)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                Container(
                  width: MainHelperFunction.screenWidth(),
                  child: Text((resData).isNotEmpty ? "Aktive : ${resData['StrFgActive']}" : "Aktive : Loading...", style: Theme.of(context).textTheme.bodyLarge, )
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                
                const SizedBox(height: MainSize.spaceBtwItems * 1.7,),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.back(), child: const Text("Kembali")),),
                const SizedBox(height: MainSize.spaceBtwItems * 3.7,),
              ]
            ),
              ),
        )));
  }
}
class User {
  const User(this.id,this.name);

  final String name;
  final int id;
}