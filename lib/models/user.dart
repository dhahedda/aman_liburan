class User { 
  final String uid; 
  final String fullName; 
  final String domicile; 
  final String email; 
  final int age; 
  final String profileImage; 
  final int role; 
 
  User({ 
    this.uid, 
    this.fullName, 
    this.domicile, 
    this.email, 
    this.age, 
    this.profileImage, 
    this.role 
  }); 
 
  factory User.fromMap(Map<String, dynamic> map) { 
    return User( 
      uid: map['uid'], 
      fullName: map['full_name'], 
      domicile: map['domicile'], 
      email: map['email'], 
      age: map['age'], 
      profileImage: map['profile_image'], 
      role: map['role'], 
    ); 
  } 
}