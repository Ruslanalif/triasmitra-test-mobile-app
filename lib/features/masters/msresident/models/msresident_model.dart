class MsResident {
  final int id;
  final String idCardNumber;
  final String name;
  final String birthPlace;
  final String birthDay;
  final String strBirthDay;
  final String gender;
  final String strGender;
  final String provinceName;
  final String regencyName;
  final String districtName;
  final String villageName;
  final String address;
  final String religion;
  final String maritalStatus;
  final String employment;
  final String citizenship;
  final String fileURL;
  final String fgActive;
  final String strFgActive;
  final String createdBy;
  final String createdDate;
  final String? modifiedBy;
  final String? modifiedDate;

  MsResident({
    required this.id,
    required this.idCardNumber,
    required this.name,
    required this.birthPlace,
    required this.birthDay,
    required this.strBirthDay,
    required this.gender,
    required this.strGender,
    required this.provinceName,
    required this.regencyName,
    required this.districtName,
    required this.villageName,
    required this.address,
    required this.religion,
    required this.maritalStatus,
    required this.employment,
    required this.citizenship,
    required this.fileURL,
    required this.fgActive,
    required this.strFgActive,
    required this.createdBy,
    required this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  factory MsResident.fromJson(Map<String, dynamic> json) {
    return MsResident(
      id: json['ID'],
      idCardNumber: json['IDCardNumber'],
      name: json['Name'],
      birthPlace: json['BirthPlace'],
      birthDay: json['BirthDay'],
      strBirthDay: json['StrBirthDay'],
      gender: json['Gender'],
      strGender: json['StrGender'],
      provinceName: json['ProvinceName'],
      regencyName: json['RegencyName'],
      districtName: json['DistrictName'],
      villageName: json['VillageName'],
      address: json['Address'],
      religion: json['Religion'],
      maritalStatus: json['MaritalStatus'],
      employment: json['Employment'],
      citizenship: json['Citizenship'],
      fileURL: json['FileURL'] ?? '',
      fgActive: json['FgActive'],
      strFgActive: json['StrFgActive'],
      createdBy: json['CreatedBy'],
      createdDate: json['CreatedDate'],
      modifiedBy: json['ModifiedBy'],
      modifiedDate: json['ModifiedDate'],
    );
  }
}
