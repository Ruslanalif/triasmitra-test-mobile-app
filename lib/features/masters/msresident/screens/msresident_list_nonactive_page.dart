
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triasmitra_mobile_app/common/styles/spacing_styles.dart';
import 'package:triasmitra_mobile_app/features/masters/msresident/models/msresident_model.dart';
import 'package:triasmitra_mobile_app/features/masters/msresident/screens/msresident_form.dart';
import 'package:triasmitra_mobile_app/features/masters/msresident/screens/msresident_form_edit.dart';
import 'package:triasmitra_mobile_app/features/masters/msresident/screens/msresident_view.dart';
import 'package:triasmitra_mobile_app/utils/constants/colors.dart';
import 'package:triasmitra_mobile_app/utils/constants/image_strings.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';
import 'package:triasmitra_mobile_app/utils/helpers/session_service.dart';
import 'package:triasmitra_mobile_app/utils/http/http_client.dart';


class MsResidentListNonActivePage extends StatefulWidget {
  @override
  _MsResidentListNonActivePageState createState() => _MsResidentListNonActivePageState();
}

class _MsResidentListNonActivePageState extends State<MsResidentListNonActivePage> {
  List<MsResident> residents = [];
  final SessionService _sessionService = SessionService();
  String _token = 'Loading...';
  String _id = 'Loading...';
  bool firstLoad = true;
  bool emptyLyst = false;
  // String _username = 'Loading...';
  // String _name = 'Loading...';
  // String _email = 'Loading...';
  // String _phone = 'Loading...';


  List<int> selectedItems = [];
  bool isSelectionMode = false;

  void _onLongPress(int id) {
    setState(() {
      isSelectionMode = true;
      if (selectedItems.contains(id)) {
        selectedItems.remove(id);
      } else {
        selectedItems.add(id);
      }
    });
  }


  void _onTap(int id) {
    if (isSelectionMode) {
      setState(() {
        if (selectedItems.contains(id)) {
          selectedItems.remove(id);
        } else {
          selectedItems.add(id);
        }
        if (selectedItems.isEmpty) {
          isSelectionMode = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Simulasi data, Anda dapat mengganti ini dengan pemanggilan API
    // residents = [
    //   MsResident(
    //     id: 1,
    //     idCardNumber: '3201261509990003',
    //     name: 'Muhamad Ruslan',
    //     birthPlace: 'Bogor',
    //     birthDay: '1999-09-15',
    //     strBirthDay: '15 September 1999',
    //     gender: 'L',
    //     strGender: 'Laki-Laki',
    //     provinceName: 'JAWA BARAT',
    //     regencyName: 'KABUPATEN BOGOR',
    //     districtName: 'MEGAMENDUNG',
    //     villageName: 'SUKAMAHI',
    //     address: 'Jl. Pertanian',
    //     religion: 'Islam',
    //     maritalStatus: 'Menikah',
    //     employment: 'Karyawan Swasta',
    //     citizenship: 'WNI',
    //     fileURL: 'https://example.com/image.jpg',
    //     fgActive: 'Y',
    //     strFgActive: 'Yes',
    //     createdBy: 'Admin',
    //     createdDate: '2024-06-13 09:22:54',
    //     modifiedBy: 'Admin',
    //     modifiedDate: '2024-06-13 10:37:30',
    //   ),
    //   // Tambahkan pengguna lain di sini
    // ];
    _loadSession();
    
  }

  Future<void> _loadSession() async {
    final session = await _sessionService.getSession();
    setState(() {
      _token = session['token'] ?? 'No token found';
      _id = session['id'] ?? 'No token found';
      // _username = session['username'] ?? 'No token found';
      // _name = session['name'] ?? 'No token found';
      // _email = session['email'] ?? 'No token found';
      // _phone = session['phone'] ?? 'No token found';
      fetchResidents();
    });
  }

  Future<void> fetchResidents() async {
    final Map<String, String> data = {
        'prmStartData': "0",
        'prmLengthData': "100",
        'prmFIlter': "",
        'prmUserID': _id,
        'prmStatus': "NONACT",
      };
      // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

      final String token = _token;

      // Gunakan fungsi helper untuk mengirim data
      final response = await MainHttpClient.post('msresidents/get-filter', data, token);
    // final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_HERE'));
    setState(() {
      firstLoad = false;
    });
    if (response['xStatus'] == '1') {
      final data = response;
      if (data['xStatus'] == '1') {
        setState(() {
          residents = (data['data'] as List)
              .map((resident) => MsResident.fromJson(resident))
              .toList();
        });
      } else {
        setState(() {
          emptyLyst = true;
        });
        // Handle API error response
        print('Error: ${data['xMessage']}');
      }
    } else {

        setState(() {
          emptyLyst = true;
        });
      // Handle HTTP error response
      print('Error: ${response.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = MainHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Resident List Non-Active'),
      ),
      // body: ListView.builder(
      //   padding: EdgeInsets.only(bottom: 60),
      //   itemCount: residents.length,
      //   itemBuilder: (context, index) {
      //     final resident = residents[index];
          
      //   },
      // ),
      body: (residents.isEmpty || emptyLyst) 
      ?
      SingleChildScrollView(
        child: Container(
          width: MainHelperFunction.screenWidth(),
          child: Padding(
            padding: MainSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: MainSize.spaceBtwSections * 3,),
                Image(image: AssetImage(MainImages.searchGif), width: MainHelperFunction.screenWidth() * 0.6,),
                const SizedBox(height: MainSize.spaceBtwSections,),
                Text(firstLoad ? "Loading...." :"Not found Data",  style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.center,),
                const SizedBox(height: MainSize.spaceBtwItems * 0.5,),
                // Text("Anda dapat Mengelola data ID Card. Coba mulai \n dengan meng upload ID Card Anda!",  style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
                // const SizedBox(height: MainSize.spaceBtwSections,),
              ],
            ),
          ),
        ),
      )
      : ListView.builder(
        itemCount: residents.length,
        itemBuilder: (context, index) {
          final resident = residents[index];
          final isSelected = selectedItems.contains(resident.id);

          return GestureDetector(
            onLongPress: () {
              _onLongPress(resident.id);
            },

            onTap: () {
              _onTap(resident.id);
            },
            child: Card(
              color: isSelected ? dark ? Colors.blue.withOpacity(0.5) : MainColors.accentColor.withOpacity(0.4) : null,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: resident.fileURL.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: resident.fileURL,
                          width: 60,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Image.asset(
                          'assets/images/unselected-image.png',
                          width: 60,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                ), 
                // CircleAvatar(
                //   radius: 30,
                //   backgroundImage: resident.fileURL.isNotEmpty
                //       ? CachedNetworkImageProvider(resident.fileURL)
                //       : AssetImage('assets/default_avatar.png') as ImageProvider,
                // ),
                title: Text(resident.name),
                subtitle: Text(resident.idCardNumber),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        // Navigasi ke halaman edit
                        Get.to(() => MsresidentFormEdit(), arguments: {
                          'id': resident.id,
                        },);
                        break;
                      case 'view':
                        // Navigasi ke halaman view
                        Get.to(() => MsresidentView(), arguments: {
                          'id': resident.id,
                        },);
                        break;
                      case 'delete':
                        _showDeleteConfirmationDialog(resident.id);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'edit', 'view', 'delete'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice.toUpperCase()),
                      );
                    }).toList();
                  },
                ),
              ),
            )
          );
        },
      ),
      floatingActionButton: selectedItems.isNotEmpty
        ? FloatingActionButton.extended(
              onPressed: () {
                // Lakukan sesuatu dengan item yang dipilih
                print('Selected IDs: $selectedItems');
                _showCheckConfirmationDialog();
              },
              label: Row(
                children: [
                  Icon(Iconsax.check),
                  SizedBox(width: 8),
                  Text('Active'),
                ],
              ),
              backgroundColor: MainColors.primaryColor,
            )
        : null
    );
  }

  void _showCheckConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Active?'),
          content: Text('Item yang Anda pilih akan di non-aktif kan?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {

                final ids = selectedItems.join(',');
                final Map<String, String> data = {
                  'prmIDs': ids,
                  'prmStatus': "Y",
                  'prmUserID': _id,
                };
                // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

                final String token = _token;

                print(ids);
                print(data.toString());

                // Gunakan fungsi helper untuk mengirim data
                final response = await MainHttpClient.post('msresidents/list-status', data, token);
                if(response['xStatus'] == '1'){
                  setState(() {
                    selectedItems = [];
                    isSelectionMode = false;
                    // residents.removeWhere((resident) => resident.id == ids.split(',')[0]);
                    fetchResidents();
                  });
                }else{
                  MainHelperFunction.showAlert("Proses Gagal", response['xMessage']);
                }
                Navigator.of(context).pop();
              },
              child: Text('active'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int residentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this resident?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final Map<String, String> data = {
                  'prmMode': "Soft",
                  'prmStatus': "D",
                  'prmUserID': _id,
                };
                // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

                final String token = _token;

                // Gunakan fungsi helper untuk mengirim data
                final response = await MainHttpClient.post('msresidents/delete/$residentId', data, token);
                if(response['xStatus'] == '1'){
                  setState(() {
                    residents.removeWhere((resident) => resident.id == residentId);
                  });
                }else{
                  MainHelperFunction.showAlert("Delete Failed", response['xMessage']);
                }
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
