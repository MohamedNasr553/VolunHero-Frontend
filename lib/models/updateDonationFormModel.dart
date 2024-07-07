class UpdateDonationFormDetails {
  String id;
  String title;
  DateTime endDate;
  String description;
  String donationLink;
  String createdBy;
  DateTime announceDate;
  int v;

  UpdateDonationFormDetails({
    required this.id,
    required this.title,
    required this.endDate,
    required this.description,
    required this.donationLink,
    required this.createdBy,
    required this.announceDate,
    required this.v,
  });

  factory UpdateDonationFormDetails.fromJson(Map<String, dynamic> json) {
    return UpdateDonationFormDetails(
      id: json['_id'],
      title: json['title'],
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      donationLink: json['donationLink'],
      createdBy: json['createdBy'],
      announceDate: DateTime.parse(json['announceDate']),
      v: json['__v'],
    );
  }
}
