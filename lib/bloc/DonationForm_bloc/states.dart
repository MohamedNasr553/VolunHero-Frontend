abstract class DonationFormStates {}

class DonationFormInitialState extends DonationFormStates {}

/// Create Donation Form
class AddDonationFormLoadingState extends DonationFormStates{}

class AddDonationFormSuccessState extends DonationFormStates{}

class AddDonationFormErrorState extends DonationFormStates{}

/// Get All Donation Forms
class GetAllDonationFormLoadingState extends DonationFormStates{}

class GetAllDonationFormSuccessState extends DonationFormStates{}

class GetAllDonationFormErrorState extends DonationFormStates{}

/// Get Specific Organization Donation Forms
class GetOrgDonationFormLoadingState extends DonationFormStates{}

class GetOrgDonationFormSuccessState extends DonationFormStates{}

class GetOrgDonationFormErrorState extends DonationFormStates{}

/// Update Donation Forms
class UpdateDonationFormLoadingState extends DonationFormStates{}

class UpdateDonationFormSuccessState extends DonationFormStates{}

class UpdateDonationFormErrorState extends DonationFormStates{}

/// Update Donation Forms
class DeleteDonationFormLoadingState extends DonationFormStates{}

class DeleteDonationFormSuccessState extends DonationFormStates{}

class DeleteDonationFormErrorState extends DonationFormStates{}
