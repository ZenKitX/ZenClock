import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/world_clock_controller.dart';
import '../models/timezone_model.dart';
import '../../../widgets/neumorphic_card.dart';
import '../../../services/haptic_service.dart';

class CitySearchView extends StatefulWidget {
  const CitySearchView({super.key});

  @override
  State<CitySearchView> createState() => _CitySearchViewState();
}

class _CitySearchViewState extends State<CitySearchView> {
  final _searchController = TextEditingController();
  final _controller = Get.find<WorldClockController>();
  final _haptic = Get.find<HapticService>();
  List<TimezoneModel> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _filteredCities = _controller.availableCities;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCities = _controller.availableCities;
      } else {
        _filteredCities = _controller.availableCities
            .where((city) =>
                city.cityName.toLowerCase().contains(query.toLowerCase()) ||
                city.countryName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加城市'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(16),
            child: NeumorphicCard(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '搜索城市...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _filterCities('');
                          },
                        )
                      : null,
                ),
                onChanged: _filterCities,
              ),
            ),
          ),
          
          // 城市列表
          Expanded(
            child: _filteredCities.isEmpty
                ? Center(
                    child: Text(
                      '没有找到匹配的城市',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredCities.length,
                    itemBuilder: (context, index) {
                      final city = _filteredCities[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildCityItem(context, city),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityItem(BuildContext context, TimezoneModel city) {
    return InkWell(
      onTap: () {
        _haptic.medium();
        _controller.addCity(city);
        Get.back();
        Get.snackbar(
          '已添加',
          '${city.displayName} 已添加到世界时钟',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.cityName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    city.countryName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              city.offsetString,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
