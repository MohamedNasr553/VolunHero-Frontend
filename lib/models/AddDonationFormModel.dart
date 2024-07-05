class AddDonationFormModel {
  final String message;
  final AddDonationForm donationForm;

  AddDonationFormModel({
    required this.message,
    required this.donationForm,
  });

  factory AddDonationFormModel.fromJson(Map<String, dynamic> json) {
    return AddDonationFormModel(
      message: json['message'],
      donationForm: AddDonationForm.fromJson(json['donationForm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'donationForm': donationForm.toJson(),
    };
  }
}

class AddDonationForm {
  final String title;
  final DateTime endDate;
  final String description;
  final String donationLink;
  final String createdBy;
  final String id;
  final DateTime announceDate;
  final int version;

  AddDonationForm({
    required this.title,
    required this.endDate,
    required this.description,
    required this.donationLink,
    required this.createdBy,
    required this.id,
    required this.announceDate,
    required this.version,
  });

  factory AddDonationForm.fromJson(Map<String, dynamic> json) {
    return AddDonationForm(
      title: json['title'],
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      donationLink: json['donationLink'],
      createdBy: json['createdBy'],
      id: json['_id'],
      announceDate: DateTime.parse(json['announceDate']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'endDate': endDate.toIso8601String(),
      'description': description,
      'donationLink': donationLink,
      'createdBy': createdBy,
      '_id': id,
      'announceDate': announceDate.toIso8601String(),
      '__v': version,
    };
  }
}
