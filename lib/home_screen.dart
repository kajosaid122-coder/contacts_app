import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'add_contact_bottom_sheet.dart';
import 'app_colors.dart';
import 'app_images.dart';
import 'contact_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _contacts = [];

  void _addContact(String name, String email, String phone, File? image) {
    setState(() {
      _contacts.add({
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
      });
    });
  }

  void _showAddContactSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddContactBottomSheet(onAddContact: _addContact),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Image.asset(
                AppImages.routeLogo,
                width: 117,
                height: 39,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _contacts.isEmpty ? _buildEmptyState() : _buildGrid(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingButtons(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppImages.listAnimation,
            width: 240,
            height: 240,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          const Text(
            'There is No Contacts Added Here',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.cream,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      // مسافة تحت عشان الزراير العايمة ما تغطيش آخر كارت
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: _contacts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return ContactCard(
          name: contact['name'] as String,
          email: contact['email'] as String,
          phone: contact['phone'] as String,
          image: contact['image'] as File?,
          onDelete: () {
            setState(() {
              _contacts.removeAt(index);
            });
          },
        );
      },
    );
  }

  Widget _buildFloatingButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_contacts.isNotEmpty) ...[
          FloatingActionButton(
            heroTag: 'deleteAll',
            onPressed: () {
              setState(() {
                _contacts.clear();
              });
            },
            backgroundColor: AppColors.accentRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
        ],
        FloatingActionButton(
          heroTag: 'addContact',
          onPressed: _showAddContactSheet,
          backgroundColor: AppColors.cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.backgroundDark,
            size: 28,
          ),
        ),
      ],
    );
  }
}
