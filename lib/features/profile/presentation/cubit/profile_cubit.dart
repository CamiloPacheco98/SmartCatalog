import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/session/cart_session.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:smart_catalog/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final String _email;
  final String _adminUid;
  final UserProfileRepository _userProfileRepository;
  final AuthRepository _authRepository;
  ProfileCubit({
    required String email,
    required String adminUid,
    required UserProfileRepository userProfileRepository,
    required AuthRepository authRepository,
  }) : _email = email,
       _adminUid = adminUid,
       _userProfileRepository = userProfileRepository,
       _authRepository = authRepository,
       super(ProfileInitial());

  Future<void> createProfile({
    required String name,
    required String lastName,
    required String document,
    String? imagePath,
  }) async {
    emit(ProfileLoading());
    // Simulate API
    try {
      await _userProfileRepository.createProfile(
        _adminUid,
        name,
        lastName,
        document,
        imagePath ?? '',
        _email,
      );
      await _initializeUserSession();
      final catalogImages = await _initCatalogImages();
      emit(ProfileSuccess(catalogImages: catalogImages));
    } catch (error) {
      debugPrint('createProfile Error: ${error.toString()}');
      emit(ProfileError(message: 'errors.create_profile_error'.tr()));
    }
  }

  void resetState() {
    emit(ProfileInitial());
  }

  /// Initialize user session after successful sign-in
  Future<void> _initializeUserSession() async {
    try {
      await _initCartProducts();
      await _initOrders();
    } catch (e) {
      debugPrint('Error initializing user session: $e');
    }
  }

  Future<void> _initCartProducts() async {
    try {
      final products = await _authRepository.getCartProducts();
      _authRepository.saveLocalCartProducts(products?.values.toList() ?? []);
      final productsViewModel = products?.values
          .map((e) => CartProductViewModel.fromEntity(e))
          .toList();
      CartSession.instance.initializeProducts(productsViewModel ?? []);
    } catch (error) {
      debugPrint('initCartProducts Error: ${error.toString()}');
    }
  }

  Future<void> _initOrders() async {
    try {
      final orders = await _authRepository.getOrders();
      final ordersMap = Map.fromEntries(orders.map((e) => MapEntry(e.id, e)));
      _authRepository.saveLocalOrders(ordersMap);
      OrdersSession.instance.initializeOrders(ordersMap.values.toList());
    } catch (error) {
      debugPrint('initOrders Error: ${error.toString()}');
    }
  }

  Future<List<String>> _initCatalogImages() async {
    try {
      return await _authRepository.getCatalogImages();
    } catch (error) {
      debugPrint('initCatalogImages Error: ${error.toString()}');
      return [];
    }
  }
}
