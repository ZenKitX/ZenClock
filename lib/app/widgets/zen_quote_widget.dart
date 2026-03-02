import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/zen_quote_service.dart';

class ZenQuoteWidget extends StatefulWidget {
  final QuoteContext? context;
  final bool autoRefresh;
  final Duration refreshInterval;

  const ZenQuoteWidget({
    super.key,
    this.context,
    this.autoRefresh = false,
    this.refreshInterval = const Duration(minutes: 5),
  });

  @override
  State<ZenQuoteWidget> createState() => _ZenQuoteWidgetState();
}

class _ZenQuoteWidgetState extends State<ZenQuoteWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final _quoteService = Get.find<ZenQuoteService>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _loadQuote();
    
    if (widget.autoRefresh) {
      _startAutoRefresh();
    }
  }

  void _loadQuote() {
    if (widget.context != null) {
      _quoteService.getQuoteByContext(widget.context!);
    } else {
      _quoteService.getRandomQuote();
    }
    _controller.forward(from: 0.0);
  }

  void _startAutoRefresh() {
    Future.delayed(widget.refreshInterval, () {
      if (mounted) {
        _loadQuote();
        _startAutoRefresh();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final quote = _quoteService.currentQuote.value;
      if (quote.isEmpty) return const SizedBox.shrink();
      
      return FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.format_quote,
                size: 16,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  quote,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.format_quote,
                size: 16,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
            ],
          ),
        ),
      );
    });
  }
}
