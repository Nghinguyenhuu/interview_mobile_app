import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../resources/colors.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Tỉnh thành tổ chức, ban nhạc tổ chức',
            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.grey),
            prefixIconConstraints: BoxConstraints(maxHeight: 32, maxWidth: 48),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Assets.images.svg.iconSearchInactive.svg(width: 32, height: 32),
            ),
            suffixIconConstraints: BoxConstraints(maxHeight: 32, maxWidth: 48),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Assets.images.svg.iconFilterInactive.svg(width: 24, height: 24),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            isDense: true,
            border: _buildBorderTextField(),
            enabledBorder: _buildBorderTextField(),
            focusedBorder: _buildBorderTextField(),
            filled: true,
            fillColor: AppColors.neutral),
      ),
    );
  }

  InputBorder _buildBorderTextField() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
