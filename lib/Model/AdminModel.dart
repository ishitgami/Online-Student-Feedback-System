class AdminData {
  var uid;
  var institudeName;
  var orgCode;
  var acYear;
  var department;
  var subject;

  AdminData(
      {this.institudeName,
      this.uid,
      this.orgCode,
      this.acYear,
      this.department,
      this.subject});

  AdminData.fromMap(Map snapshot)
      : uid = snapshot['UId'] ?? '',
        institudeName = snapshot['InstituteName'] ?? '',
        orgCode = snapshot['orgCode'] ?? '',
        acYear = snapshot['AcYear'] ?? '',
        department = snapshot['Department'] ?? '',
        subject = snapshot['Subject'] ?? '';

}