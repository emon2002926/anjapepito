class SignUpRequestModel {
  final String? fullName;
  final String email;
  final String password;
  final String re_type_password;


  SignUpRequestModel({required this.email, required this.password,
    required this.re_type_password, this.fullName});
  Map<String, dynamic> toJson() => {
    'full_name': "fullName",
    'email': email,
    'password': password,
    're_type_password': re_type_password,
  };


}