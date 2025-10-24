import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'validators.dart';
import 'input_sanitizer.dart';
import 'validation_providers.dart';

/// 🎯 Validation Widgets
/// Form validation için özel widget'lar

/// 📝 Validated Text Field
class ValidatedTextField extends ConsumerStatefulWidget {
  final String fieldName;
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? customValidator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final bool required;
  
  const ValidatedTextField({
    super.key,
    required this.fieldName,
    this.label,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.customValidator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.required = true,
  });
  
  @override
  ConsumerState<ValidatedTextField> createState() => _ValidatedTextFieldState();
}

class _ValidatedTextFieldState extends ConsumerState<ValidatedTextField> {
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final fieldState = ref.watch(fieldProvider(widget.fieldName));
    
    return TextFormField(
      controller: _controller,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: const OutlineInputBorder(),
        errorText: fieldState.error,
        errorMaxLines: 2,
      ),
      validator: widget.customValidator ?? _getValidator(),
      onChanged: (value) {
        // Giriş verilerini temizle
        final sanitizedValue = InputSanitizer.sanitizeText(value);
        if (sanitizedValue != value) {
          _controller.text = sanitizedValue;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: sanitizedValue.length),
          );
        }
        
        // State'i güncelle
        ref.read(fieldProvider(widget.fieldName).notifier).updateValue(sanitizedValue);
        ref.read(formStateProvider.notifier).updateField(widget.fieldName, sanitizedValue);
        
        widget.onChanged?.call(sanitizedValue);
      },
      onFieldSubmitted: widget.onSubmitted,
      onTap: () {
        ref.read(fieldProvider(widget.fieldName).notifier).updateFocus(true);
      },
      onTapOutside: (_) {
        ref.read(fieldProvider(widget.fieldName).notifier).updateFocus(false);
      },
    );
  }
  
  String? Function(String?) _getValidator() {
    switch (widget.fieldName) {
      case 'email':
        return EmailValidator.validate;
      case 'phone':
        return PhoneValidator.validate;
      case 'name':
        return NameValidator.validate;
      case 'message':
        return MessageValidator.validate;
      case 'password':
        return PasswordValidator.validate;
      case 'url':
        return UrlValidator.validate;
      case 'date':
        return DateValidator.validate;
      default:
        return (value) => widget.required && (value == null || value.isEmpty) 
            ? 'Bu alan zorunludur' 
            : null;
    }
  }
}

/// 📝 Validated Form
class ValidatedForm extends ConsumerWidget {
  final Widget child;
  final void Function(Map<String, String>)? onSubmit;
  final void Function()? onReset;
  final bool autoValidate;
  
  const ValidatedForm({
    super.key,
    required this.child,
    this.onSubmit,
    this.onReset,
    this.autoValidate = false,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateProvider);
    
    return Form(
      autovalidateMode: autoValidate 
          ? AutovalidateMode.onUserInteraction 
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          child,
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: formState.isValid && !formState.isSubmitting
                    ? () => _handleSubmit(ref)
                    : null,
                child: formState.isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Gönder'),
              ),
              if (onReset != null)
                OutlinedButton(
                  onPressed: () => _handleReset(ref),
                  child: const Text('Temizle'),
                ),
            ],
          ),
        ],
      ),
    );
  }
  
  void _handleSubmit(WidgetRef ref) {
    final formState = ref.read(formStateProvider);
    onSubmit?.call(formState.values);
    ref.read(formStateProvider.notifier).submitForm();
  }
  
  void _handleReset(WidgetRef ref) {
    ref.read(formStateProvider.notifier).clearForm();
    onReset?.call();
  }
}

/// 📝 Validation Error Display
class ValidationErrorDisplay extends ConsumerWidget {
  final String fieldName;
  final Widget? customErrorWidget;
  
  const ValidationErrorDisplay({
    super.key,
    required this.fieldName,
    this.customErrorWidget,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch(fieldProvider(fieldName));
    
    if (fieldState.error == null) {
      return const SizedBox.shrink();
    }
    
    if (customErrorWidget != null) {
      return customErrorWidget!;
    }
    
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 16,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              fieldState.error!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 📝 Form Progress Indicator
class FormProgressIndicator extends ConsumerWidget {
  final String? message;
  
  const FormProgressIndicator({
    super.key,
    this.message,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateProvider);
    
    if (!formState.isSubmitting) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

/// 📝 Form Status Display
class FormStatusDisplay extends ConsumerWidget {
  final Widget? successWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  
  const FormStatusDisplay({
    super.key,
    this.successWidget,
    this.errorWidget,
    this.loadingWidget,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateProvider);
    
    if (formState.isSubmitting) {
      return loadingWidget ?? const FormProgressIndicator();
    }
    
    if (formState.isValid && formState.isDirty) {
      return successWidget ?? const _SuccessMessage();
    }
    
    if (formState.errors.isNotEmpty) {
      return errorWidget ?? const _ErrorMessage();
    }
    
    return const SizedBox.shrink();
  }
}

/// 📝 Success Message
class _SuccessMessage extends StatelessWidget {
  const _SuccessMessage();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green.shade600,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Form başarıyla doğrulandı',
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 📝 Error Message
class _ErrorMessage extends ConsumerWidget {
  const _ErrorMessage();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateProvider);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Form doğrulama hatası',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (formState.errors.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...formState.errors.entries
                .where((entry) => entry.value != null)
                .map((entry) => Padding(
                      padding: const EdgeInsets.only(left: 28, bottom: 4),
                      child: Text(
                        '• ${entry.value}',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 12,
                        ),
                      ),
                    )),
          ],
        ],
      ),
    );
  }
}

/// 📝 Form Field Wrapper
class FormFieldWrapper extends ConsumerWidget {
  final String fieldName;
  final Widget child;
  final String? label;
  final bool required;
  
  const FormFieldWrapper({
    super.key,
    required this.fieldName,
    required this.child,
    this.label,
    this.required = false,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (required)
            Text(
              ' *',
              style: TextStyle(
                color: Colors.red.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 8),
        ],
        child,
        ValidationErrorDisplay(fieldName: fieldName),
      ],
    );
  }
}
