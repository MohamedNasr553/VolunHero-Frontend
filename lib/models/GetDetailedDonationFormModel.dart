class DetailedDonationFormResponse {
  String message;
  DetailedDonationFormDetails donationForm;

  DetailedDonationFormResponse({
    required this.message,
    required this.donationForm,
  });

  factory DetailedDonationFormResponse.fromJson(Map<String, dynamic> json) {
    return DetailedDonationFormResponse(
      message: json['message'],
      donationForm: DetailedDonationFormDetails.fromJson(json['donationForm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'donationForm': donationForm.toJson(),
    };
  }
}

class DetailedDonationFormDetails {
  String id;
  String title;
  DateTime endDate;
  String description;
  String donationLink;
  String createdBy;
  DateTime announceDate;

  DetailedDonationFormDetails({
    required this.id,
    required this.title,
    required this.endDate,
    required this.description,
    required this.donationLink,
    required this.createdBy,
    required this.announceDate,
  });

  factory DetailedDonationFormDetails.fromJson(Map<String, dynamic> json) {
    return DetailedDonationFormDetails(
      id: json['_id'],
      title: json['title'],
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      donationLink: json['donationLink'],
      createdBy: json['createdBy'],
      announceDate: DateTime.parse(json['announceDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'endDate': endDate.toIso8601String(),
      'description': description,
      'donationLink': donationLink,
      'createdBy': createdBy,
      'announceDate': announceDate.toIso8601String(),
    };
  }
}
