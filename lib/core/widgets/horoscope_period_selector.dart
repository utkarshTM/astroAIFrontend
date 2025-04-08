import 'package:flutter/material.dart';

class HoroscopePeriodSelector extends StatefulWidget {
  final String selectedPeriod;
  final ValueChanged<String> onPeriodChanged;

  const HoroscopePeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  State<HoroscopePeriodSelector> createState() => _HoroscopePeriodSelectorState();
}

class _HoroscopePeriodSelectorState extends State<HoroscopePeriodSelector> {
  final PageController _pageController = PageController();
  final List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final page = _pageController.page?.round();
    if (page != null && page >= 0 && page < periods.length) {
      widget.onPeriodChanged(periods[page]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: PageView.builder(
        controller: _pageController,
        itemCount: periods.length,
        itemBuilder: (context, index) {
          final period = periods[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(period),
              selected: widget.selectedPeriod == period,
              onSelected: (selected) {
                if (selected) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}