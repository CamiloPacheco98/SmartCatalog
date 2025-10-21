import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final String _email;
  final String _adminUid;
  ProfileCubit({required String email, required String adminUid})
    : _email = email,
      _adminUid = adminUid,
      super(ProfileInitial());

  void createProfile({
    required String name,
    required String lastName,
    required String document,
    String? imagePath,
  }) {
    emit(ProfileLoading());
    debugPrint('email: $_email');
    debugPrint('adminUid: $_adminUid');
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      // Here you would typically call a repository to save the profile
      emit(ProfileSuccess());
    });
  }

  void resetState() {
    emit(ProfileInitial());
  }
  //TODO: Initialize user session after successful sign-in
  //  /// Initialize user session after successful sign-in
  // Future<void> _initializeUserSession() async {
  //   try {
  //     await _initCartProducts();
  //     await _initOrders();
  //   } catch (e) {
  //     debugPrint('Error initializing user session: $e');
  //   }
  // }

  // Future<void> _initCartProducts() async {
  //   try {
  //     final products = await _authRepository.getCartProducts();
  //     _authRepository.saveLocalCartProducts(products?.values.toList() ?? []);
  //     final productsViewModel = products?.values
  //         .map((e) => CartProductViewModel.fromEntity(e))
  //         .toList();
  //     CartSession.instance.initializeProducts(productsViewModel ?? []);
  //   } catch (error) {
  //     debugPrint('initCartProducts Error: ${error.toString()}');
  //   }
  // }

  // Future<void> _initOrders() async {
  //   try {
  //     final orders = await _authRepository.getOrders();
  //     final ordersMap = Map.fromEntries(orders.map((e) => MapEntry(e.id, e)));
  //     _authRepository.saveLocalOrders(ordersMap);
  //     OrdersSession.instance.initializeOrders(ordersMap.values.toList());
  //   } catch (error) {
  //     debugPrint('initOrders Error: ${error.toString()}');
  //   }
  // }

  // Future<List<String>> _initCatalogImages() async {
  //   try {
  //     return await _authRepository.getCatalogImages();
  //   } catch (error) {
  //     debugPrint('initCatalogImages Error: ${error.toString()}');
  //     return [];
  //   }
  // }
}
