class LoginModel{
  final String id;
  String firstName;
  String lastName;
  final String username;
  String password;
  String email;
  String phone;

  LoginModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.email,
    required this.phone
  });

  String get fullName => '$firstName $lastName';

  List<String> namePart(fullName) => fullName.split(" ");

  static LoginModel empty() => LoginModel(id: '', firstName: '', lastName: '', username: '', password: '', email: '', phone: '');
  
}
