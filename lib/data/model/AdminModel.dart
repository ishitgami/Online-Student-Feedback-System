class AdminData {
  String uid;
  String institudeName;
  String orgCode;
  List acYear;
  List department;
  Map subject;

  AdminData(
      {this.institudeName,
      this.uid,
      this.orgCode,
      this.acYear,
      this.department,
      this.subject});

  AdminData.fromMap(Map snapshot)
      : 
      uid = snapshot['UId'] ?? '',
        institudeName = snapshot['InstituteName'] ?? '',
        orgCode = snapshot['orgCode'] ?? '',
        acYear = snapshot['AcYear'] ?? '',
        department = snapshot['Department'] ?? '',
        subject = snapshot['Subject'] ?? '';

  toJson() {
    return {
      "uid": uid,
      "institudeName": institudeName,
      "orgCode": orgCode,
      "acYear": acYear,
      "department": department,
      "subject": subject,
    };
  }
}
