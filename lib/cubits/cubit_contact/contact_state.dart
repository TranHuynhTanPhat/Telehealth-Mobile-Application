part of 'contact_cubit.dart';

sealed class ContactState {
  const ContactState({required this.phone, required this.email});
  final String? phone;
  final String? email;
}

final class ContactInitial extends ContactState {
  ContactInitial({required super.phone, required super.email});
}

final class ContactLoading extends ContactState {
  ContactLoading({required super.phone, required super.email});
}

final class ContactLoaded extends ContactState {
  ContactLoaded({required super.phone, required super.email});
}

final class ContactError extends ContactState {
  ContactError(this.message, {required super.phone, required super.email});
  final String message;
}

final class ContactUpdate extends ContactState {
  final DataResponse response;
  ContactUpdate(
      {required super.phone, required super.email, required this.response});
}
