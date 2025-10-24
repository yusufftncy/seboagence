/// 📧 Contact Providers - İletişim provider'ları
///
/// Bu dosya, iletişim ile ilgili Riverpod provider'larını içerir.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/send_contact_message.dart';
import '../../data/repositories/contact_repository_impl.dart';

// Repository provider'ı
final contactRepositoryProvider = Provider((ref) => ContactRepositoryImpl());

// Use case provider'ı
final sendContactMessageUseCaseProvider = Provider((ref) {
  final repository = ref.watch(contactRepositoryProvider);
  return SendContactMessageUseCase(repository);
});

// İletişim formu durumu
class ContactFormState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
  final String? company;
  final String? budget;
  final String? timeline;
  final String? preferredContactMethod;

  const ContactFormState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.subject = '',
    this.message = '',
    this.company,
    this.budget,
    this.timeline,
    this.preferredContactMethod,
  });

  ContactFormState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? name,
    String? email,
    String? phone,
    String? subject,
    String? message,
    String? company,
    String? budget,
    String? timeline,
    String? preferredContactMethod,
  }) {
    return ContactFormState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      company: company ?? this.company,
      budget: budget ?? this.budget,
      timeline: timeline ?? this.timeline,
      preferredContactMethod:
          preferredContactMethod ?? this.preferredContactMethod,
    );
  }
}

// İletişim formu notifier'ı
class ContactFormNotifier extends StateNotifier<ContactFormState> {
  ContactFormNotifier() : super(const ContactFormState());

  /// Form alanlarını güncelle
  void updateField({
    String? name,
    String? email,
    String? phone,
    String? subject,
    String? message,
    String? company,
    String? budget,
    String? timeline,
    String? preferredContactMethod,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      phone: phone,
      subject: subject,
      message: message,
      company: company,
      budget: budget,
      timeline: timeline,
      preferredContactMethod: preferredContactMethod,
    );
  }

  /// Form gönder
  Future<void> submitForm() async {
    if (!_isFormValid()) {
      state = state.copyWith(
        errorMessage: 'Lütfen tüm gerekli alanları doldurun',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Mock olarak başarılı kabul et
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Form geçerliliğini kontrol et
  bool _isFormValid() {
    return state.name.isNotEmpty &&
        state.email.isNotEmpty &&
        state.phone.isNotEmpty &&
        state.subject.isNotEmpty &&
        state.message.isNotEmpty;
  }

  /// Formu sıfırla
  void resetForm() {
    state = const ContactFormState();
  }

  /// Hata mesajını temizle
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// İletişim formu durumu provider'ı
final contactFormStateProvider =
    StateNotifierProvider<ContactFormNotifier, ContactFormState>((ref) {
      return ContactFormNotifier();
    });
