class GetAllDonationFormsResponse {
  final String message;
  final List<DonationFormDetails> donationForms;

  GetAllDonationFormsResponse({
    required this.message,
    required this.donationForms,
  });

  factory GetAllDonationFormsResponse.fromJson(Map<String, dynamic> json) {
    var donationFormsJson = json['donationForms'] as List;
    List<DonationFormDetails> donationFormsList =
        donationFormsJson.map((i) => DonationFormDetails.fromJson(i)).toList();

    return GetAllDonationFormsResponse(
      message: json['message'],
      donationForms: donationFormsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'donationForms': donationForms.map((form) => form.toJson()).toList(),
    };
  }
}

class DonationFormDetails {
  late final String id;
  late final String title;
  late final DateTime endDate;
  late final String description;
  late final String donationLink;
  late final String createdBy;
  late final DateTime announceDate;
  late final int v;

  DonationFormDetails({
    required this.id,
    required this.title,
    required this.endDate,
    required this.description,
    required this.donationLink,
    required this.createdBy,
    required this.announceDate,
    required this.v,
  });
  DonationFormDetails.empty()
      : id = '',
        title = '',
        endDate = DateTime.now(),
        description = '',
        donationLink = '',
        createdBy = '',
        announceDate = DateTime.now(),
        v = 0;

  // Factory method example
  factory DonationFormDetails.emptyForm() {
    return DonationFormDetails(
      id: '',
      title: '',
      endDate: DateTime.now(),
      description: '',
      donationLink: '',
      createdBy: '',
      announceDate: DateTime.now(),
      v: 0,
    );
  }
  factory DonationFormDetails.fromJson(Map<String, dynamic> json) {
    return DonationFormDetails(
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

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'endDate': endDate.toIso8601String(),
      'description': description,
      'donationLink': donationLink,
      'createdBy': createdBy,
      'announceDate': announceDate.toIso8601String(),
      '__v': v,
    };
  }
}
