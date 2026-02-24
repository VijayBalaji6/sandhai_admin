import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/common/widgets/custom_text/custom_text.dart';

import '../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../common/widgets/custom_scaffold/custom_scaffold.dart';
import '../../../../common/widgets/custom_text_field/custom_text_field.dart';
import '../../../../common/widgets/custom_text_field/custom_text_form_field.dart';
import '../../../../core/network/dtos/shop_model.dart';
import '../bloc/shop_bloc.dart';
import 'selection_card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  late final ShopBloc _shopBloc;
  ShopModel? _currentShop;

  @override
  void initState() {
    super.initState();
    _shopBloc = ShopBloc()..add(const ShopFetchRequested());
  }

  @override
  void dispose() {
    _shopBloc.close();
    _shopNameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  void _syncFormFromModel(ShopModel shop) {
    _shopNameController.text = shop.shopName;
    _descriptionController.text = shop.shopDescription ?? '';
    _phoneController.text = shop.phone;
    _emailController.text = shop.email ?? '';
    _addressController.text = shop.address ?? '';
    _openingTimeController.text = shop.openingTime;
    _closingTimeController.text = shop.closingTime;
  }

  void _addPinCode() {
    final String value = _pinCodeController.text.trim();
    final ShopModel? shop = _currentShop;
    if (shop == null ||
        value.isEmpty ||
        shop.serviceablePinCodes.contains(value)) {
      return;
    }
    _shopBloc.add(ShopPinCodeAdded(value));
    _pinCodeController.clear();
  }

  void _removePinCode(String value) {
    _shopBloc.add(ShopPinCodeRemoved(value));
  }

  void _save() {
    final ShopModel? shop = _currentShop;
    if (shop == null) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final String shopName = _shopNameController.text.trim();
    final String shopDescription = _descriptionController.text.trim();
    final String phone = _phoneController.text.trim();
    final String email = _emailController.text.trim();
    final String address = _addressController.text.trim();
    final String openingTime = _openingTimeController.text.trim();
    final String closingTime = _closingTimeController.text.trim();

    _shopBloc.add(
      ShopProfileUpdated(
        shopName: shopName,
        shopDescription: shopDescription.isEmpty ? null : shopDescription,
        phone: phone,
        email: email.isEmpty ? null : email,
        address: address.isEmpty ? null : address,
      ),
    );
    _shopBloc.add(
      ShopWorkingHoursUpdated(
        openingTime: openingTime,
        closingTime: closingTime,
      ),
    );
  }

  TimeOfDay _parseTime(String value) {
    final List<String> parts = value.split(':');
    if (parts.length < 2) return const TimeOfDay(hour: 9, minute: 0);
    final int hour = int.tryParse(parts[0]) ?? 9;
    final int minute = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: hour.clamp(0, 23), minute: minute.clamp(0, 59));
  }

  String _toDbTime(TimeOfDay time) {
    final String hh = time.hour.toString().padLeft(2, '0');
    final String mm = time.minute.toString().padLeft(2, '0');
    return '$hh:$mm:00';
  }

  Future<void> _pickTime({
    required TextEditingController controller,
    required String title,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      helpText: title,
      initialTime: _parseTime(controller.text),
    );

    if (picked == null) return;
    controller.text = _toDbTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopBloc>.value(
      value: _shopBloc,
      child: BlocConsumer<ShopBloc, ShopState>(
        listener: (BuildContext context, ShopState state) {
          final ShopModel? stateShop = state.shop;
          if (stateShop != null && stateShop != _currentShop) {
            _currentShop = stateShop;
            _syncFormFromModel(stateShop);
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            _shopBloc.add(const ShopMessageCleared());
          }

          if (state.successMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
            _shopBloc.add(const ShopMessageCleared());
          }
        },
        builder: (BuildContext context, ShopState state) {
          final ShopModel? shop = state.shop ?? _currentShop;

          if (state.status == ShopStatus.loading && shop == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (shop == null) {
            return CustomScaffold(
              appBar: const CustomAppBar(title: 'Shop Dashboard'),
              body: Center(
                child: ElevatedButton(
                  onPressed: () => _shopBloc.add(const ShopFetchRequested()),
                  child: const Text('Retry'),
                ),
              ),
            );
          }

          return CustomScaffold(
            appBar: CustomAppBar(
              title: 'Shop Dashboard',
              trailingWidget: [
                TextButton.icon(
                  onPressed: state.status == ShopStatus.updating ? null : _save,
                  icon: state.status == ShopStatus.updating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: const Text('Save'),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionCard(
                      title: 'Shop Profile',
                      child: Column(
                        spacing: 12,
                        children: [
                          CustomTextFormField(
                            controller: _shopNameController,
                            labelText: 'Shop Name',
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                ? 'Shop name is required'
                                : null,
                          ),
                          CustomTextFormField(
                            controller: _descriptionController,
                            labelText: 'Shop Description',
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SectionCard(
                      title: 'Contact & Address',
                      child: Column(
                        spacing: 12,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  controller: _phoneController,
                                  labelText: 'Phone',
                                  keyboardType: TextInputType.phone,
                                  validator: (value) =>
                                      (value == null || value.trim().isEmpty)
                                      ? 'Phone is required'
                                      : null,
                                ),
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                  controller: _emailController,
                                  labelText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ],
                          ),

                          CustomTextFormField(
                            controller: _addressController,
                            labelText: 'Address',
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SectionCard(
                      title: 'Working Hours',
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _openingTimeController,
                              labelText: 'Opening Time',
                              hintText: 'Pick opening time',
                              readOnly: true,
                              onTap: () => _pickTime(
                                controller: _openingTimeController,
                                title: 'Select opening time',
                              ),
                              suffixIcon: const Icon(Icons.schedule_outlined),
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                  ? 'Required'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextFormField(
                              controller: _closingTimeController,
                              labelText: 'Closing Time',
                              hintText: 'Pick closing time',
                              readOnly: true,
                              onTap: () => _pickTime(
                                controller: _closingTimeController,
                                title: 'Select closing time',
                              ),
                              suffixIcon: const Icon(Icons.schedule_outlined),
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                  ? 'Required'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SectionCard(
                      title: 'Serviceable Pin codes',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _pinCodeController,
                                  labelText: 'Add Pin Code',
                                  hintText: 'Enter 6-digit Pin Code',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  onSubmitted: (_) => _addPinCode(),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _addPinCode,
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: shop.serviceablePinCodes.map((
                              String pinCode,
                            ) {
                              return Chip(
                                label: Text(pinCode),
                                onDeleted: () => _removePinCode(pinCode),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SectionCard(
                      title: 'Shop Controls',
                      child: Row(
                        spacing: 50,
                        children: [
                          Expanded(
                            child: SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const CustomText(text: 'Shop Active'),
                              subtitle: const CustomText(
                                text: 'Enable or disable the shop',
                              ),
                              value: shop.isActive,
                              onChanged: (bool value) =>
                                  _shopBloc.add(ShopActiveToggled(value)),
                            ),
                          ),
                          Expanded(
                            child: SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const CustomText(text: 'Accept Orders'),
                              subtitle: const CustomText(
                                text: 'Allow customers to place orders',
                              ),
                              value: shop.acceptsOrders,
                              onChanged: (bool value) => _shopBloc.add(
                                ShopAcceptsOrdersToggled(value),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
