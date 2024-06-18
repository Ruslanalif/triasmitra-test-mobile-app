import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:triasmitra_mobile_app/common/styles/spacing_styles.dart';
import 'package:triasmitra_mobile_app/features/masters/msresident/controllers/msresident_controller.dart';
import 'package:triasmitra_mobile_app/features/masters/msresident/models/user_model.dart';
import 'package:triasmitra_mobile_app/utils/constants/colors.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';
import 'package:triasmitra_mobile_app/utils/device/device_utility.dart';
import 'package:triasmitra_mobile_app/utils/formatters/formatters.dart';
import 'package:triasmitra_mobile_app/utils/helpers/session_service.dart';
import 'package:triasmitra_mobile_app/utils/http/http_client.dart';
import 'package:triasmitra_mobile_app/utils/validators/validators.dart';

class MsresidentForm extends StatefulWidget {
  const MsresidentForm({super.key});

  @override
  State<MsresidentForm> createState() => _MsresidentFormState();
}

class _MsresidentFormState extends State<MsresidentForm> {
  String _formTitle = 'Add New Data';
  final controller = Get.put(MsResidentController());
  final SessionService _sessionService = SessionService();
  String _token = 'Loading...';
  String _id = 'Loading...';

  File? _image;
  final ImagePicker _picker = ImagePicker();

  String? selectedProvince;
  String? selectedRegency;
  String? selectedDistrict;
  String? selectedVillage;
  String? selectedProvinceName;
  String? selectedRegencyName;
  String? selectedDistrictName;
  String? selectedVillageName;
  String?  selectedGender = 'L';


  List<dynamic> provinces = [];
  List<dynamic> regencies = [];
  List<dynamic> districts = [];
  List<dynamic> villages = [];


  User selectedUser = new User(3, 'name');
  List<User> users = <User>[const User(1,'Foo'), const User(2,'Bar')];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        controller.birthDay.text = MainFormatter.formatDate(_selectedDate!);
      });
  }

  @override
  void initState() {
    super.initState();
    _loadSession();
    // _fetchProvinces();
    selectedUser = users[0];
    
  }

  Future<void> _loadSession() async {
    final session = await _sessionService.getSession();
    setState(() {
      _token = session['token'] ?? 'No token found';
      _id = session['id'] ?? 'No id found';
      _fetchProvinces();
    });
  }

  Future<void> _fetchProvinces() async {
    // MainDeviceUtils.hideKeyboard(context);
    final Map<String, String> data = {
      'prmType': "1",
      'prmKey': "",
      'prmUserID': _id,
    };
    final String token = _token;
    final response = await MainHttpClient.post('list-area', data, token);
    if (response['xStatus'] == '1') {
      setState(() {
        provinces = response['data'];
        // MainDeviceUtils.hideKeyboard(context);
      });
      print(provinces);
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<void> _fetchRegencies(String provinceId) async {
    final Map<String, String> data = {
      'prmType': "2",
      'prmKey': provinceId,
      'prmUserID': _id,
    };
    final String token = _token;
    final response = await MainHttpClient.post('list-area', data, token);
    if (response['xStatus'] == '1') {
      setState(() {
        regencies = response['data'];
        selectedRegency = null;
        selectedDistrict = null;
        selectedVillage = null;
        districts = [];
        villages = [];
      });
    } else {
      throw Exception('Failed to load regencies');
    }
  }

  Future<void> _fetchDistricts(String regencyId) async {
    final Map<String, String> data = {
      'prmType': "3",
      'prmKey': regencyId,
      'prmUserID': _id,
    };
    final String token = _token;
    final response = await MainHttpClient.post('list-area', data, token);
    if (response['xStatus'] == '1') {
      setState(() {
        districts = response['data'];
        selectedDistrict = null;
        selectedVillage = null;
        villages = [];
      });
    } else {
      throw Exception('Failed to load districts');
    }
  }

  Future<void> _fetchVillages(String districtId) async {
    final Map<String, String> data = {
      'prmType': "4",
      'prmKey': districtId,
      'prmUserID': _id,
    };
    final String token = _token;
    final response = await MainHttpClient.post('list-area', data, token);
    if (response['xStatus'] == '1') {
      setState(() {
        villages = response['data'];
        selectedVillage = null;
      });
    } else {
      throw Exception('Failed to load villages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MainSize.defaultSpace),
          child: Column(
            children: [
              Text(_formTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: MainSize.spaceBtwItems * 1.5,),
              Form(
                key: controller.msResidentFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.idCardNumber,
                      validator: (value) => MainValidator.isRequired(value, 'NIK'),
                      decoration: const InputDecoration(
                        labelText: "16 Digit NIK",
                        prefixIcon: Icon(Iconsax.card)
                      ),
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    TextFormField(
                      controller: controller.name,
                      validator: (value) => MainValidator.isRequired(value, 'Nama'),
                      
                      decoration: const InputDecoration(
                        labelText: "Nama Lengkap",
                        prefixIcon: Icon(Iconsax.user)
                      ),
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gender", style: Theme.of(context).textTheme.labelLarge,),
                              SizedBox(width: MainSize.spaceBtwItems *0.7,),
                              // Expanded(child: child)
                              Wrap(
                                spacing: 10.0, // Space between radio buttons
                                  children: <Widget>[
                                    ChoiceChip(
                                      label: Text('Laki-laki'),
                                      selected: selectedGender == 'L',
                                      onSelected: (selected) {
                                        setState(() {
                                          selectedGender = 'L';
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      label: Text('Perempuan'),
                                      selected: selectedGender == 'P',
                                      onSelected: (selected) {
                                        setState(() {
                                          selectedGender = 'P';
                                        });
                                      },  
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.birthPlace, 
                            validator: (value) => MainValidator.isRequired(value, 'Tempat Lahir'),
                            decoration: const InputDecoration(
                              labelText: "Tempat Lahir",
                              prefixIcon: Icon(Iconsax.location)
                            ),
                          ),
                        ),
                        const SizedBox(width: MainSize.spaceBtwItems * 0.5,),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            controller: controller.birthDay, 
                            validator: (value) => MainValidator.isRequired(value, 'Tanggal Lahir'),
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
                            controller: controller.religion,
                            validator: (value) => MainValidator.isRequired(value, 'Agama'),
                            decoration: const InputDecoration(
                              labelText: "Agama",
                              prefixIcon: Icon(Iconsax.safe_home)
                            ),
                          ),
                        ),
                        const SizedBox(width: MainSize.spaceBtwItems * 0.5,),
                        Expanded(
                          child: TextFormField(
                            controller: controller.maritalStatus,
                            validator: (value) => MainValidator.isRequired(value, 'Status Perkawinan'),
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
                            controller: controller.employment,
                            validator: (value) => MainValidator.isRequired(value, 'Pekerjaan'),
                            decoration: const InputDecoration(
                              labelText: "Pekerjaan",
                              prefixIcon: Icon(Iconsax.money)
                            ),
                          ),
                        ),
                        const SizedBox(width: MainSize.spaceBtwItems * 0.5,),
                        Expanded(
                          child: TextFormField(
                            controller: controller.citizenship,
                            validator: (value) => MainValidator.isRequired(value, 'Kewarganegaraan'),
                            decoration: const InputDecoration(
                              labelText: "Kewarganegaraan",
                              prefixIcon: Icon(Iconsax.flag)
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    // TextFormField(
                    //   controller: controller.gender,
                    //   validator: (value) => MainValidator.isRequired(value, 'Gender'),
                    //   decoration: const InputDecoration(
                    //     labelText: "Gender",
                    //     prefixIcon: Icon(Iconsax.man)
                    //   ),
                    // ),
                    
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    DropdownSearch<String>(                  
                      selectedItem: selectedProvinceName,
                      items: provinces.map((province) => province['Name'].toString()).toList(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            labelText: "Provinsi",
                            hintText: "Province.",
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedProvinceName = value;
                          selectedProvince = provinces.firstWhere((province) => province['Name'] == value)['ID'].toString();
                          selectedRegency = null;
                          selectedDistrict = null;
                          selectedVillage = null;
                          selectedRegencyName = null;
                          selectedDistrictName = null;
                          selectedVillageName = null;
                          regencies = [];
                          districts = [];
                          villages = [];
                        });
                        _fetchRegencies(selectedProvince!);
                      },
                      validator: (value) => value == null ? 'Please select a province' : null,
                  ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    DropdownSearch<String>(
                      selectedItem: selectedRegencyName,
                      items: regencies.map((regency) => regency['Name'].toString()).toList(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            labelText: "Kota/Kabupaten",
                            hintText: "Regency.",
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedRegencyName = value;
                          selectedRegency = regencies.firstWhere((regency) => regency['Name'] == value)['ID'].toString();
                          selectedDistrict = null;
                          selectedVillage = null;
                          selectedDistrictName = null;
                          selectedVillageName = null;
                          districts = [];
                          villages = [];
                        });
                        _fetchDistricts(selectedRegency!);
                      },
                      validator: (value) => value == null ? 'Please select a regency' : null,
                      enabled: selectedProvince != null,
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),

                    DropdownSearch<String>(
                      selectedItem: selectedDistrictName,
                      items: districts.map((district) => district['Name'].toString()).toList(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            labelText: "Kecamatan",
                            hintText: "District.",
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDistrictName = value;
                          selectedDistrict = districts.firstWhere((district) => district['Name'] == value)['ID'].toString();
                          selectedVillage = null;
                          selectedVillageName = null;
                          villages = [];
                        });
                        _fetchVillages(selectedDistrict!);
                      },
                      validator: (value) => value == null ? 'Please select a district' : null,
                      enabled: selectedRegency != null,
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    DropdownSearch<String>(
                      selectedItem: selectedVillageName,
                      items: villages.map((village) => village['Name'].toString()).toList(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            labelText: "Desa/Kelurahan",
                            hintText: "Village.",
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedVillageName = value;
                          selectedVillage = villages.firstWhere((village) => village['Name'] == value)['ID'].toString();
                        });
                      },
                      validator: (value) => value == null ? 'Please select a village' : null,
                      enabled: selectedDistrict != null,
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    TextFormField(
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      
                      maxLines: 3,
                      controller: controller.address,
                      validator: (value) => MainValidator.isRequired(value, 'Alamat'),
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Alamat Lengkap. ",
                        // prefixIcon: Icon(Iconsax.location)
                      ),
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    _image != null
                        ? Image.file(_image!, height: 200)
                        : Text('No image selected'),
                    const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          child: Text('Select Gallery', style: Theme.of(context).textTheme.labelSmall,),
                        ),
                        const SizedBox(width: MainSize.spaceBtwItems * 0.7,),
                        OutlinedButton(
                          onPressed: () => _pickImage(ImageSource.camera),
                          child: Text('Take a Photo', style: Theme.of(context).textTheme.labelSmall,),
                        ),
                      ],
                    ),
                    const SizedBox(height: MainSize.spaceBtwItems * 1.7,),
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.store(true, '',_token, _id, _image, selectedProvince, selectedRegency, selectedDistrict, selectedVillage, selectedGender, DateFormat("yyyy-MM-dd").format(_selectedDate!)), child: const Text("Submit")),),
                    const SizedBox(height: MainSize.spaceBtwItems * 3.7,),
                  ],
                ),
              ),
            ]
          ),
    )));
  }
}
class User {
  const User(this.id,this.name);

  final String name;
  final int id;
}