import 'dart:math';
import 'package:get/get.dart';

class ZenQuoteService extends GetxService {
  final currentQuote = ''.obs;
  final _random = Random();

  static const List<String> _quotes = [
    '放下执念，心自清明',
    '一即一切，一切即一',
    '错误亦是修行',
    '九九归一',
    '三生万物',
    '时间如流水，珍惜当下',
    '静坐常思己过',
    '心若止水，万物皆明',
    '一念放下，万般自在',
    '行到水穷处，坐看云起时',
    '春有百花秋有月，夏有凉风冬有雪',
    '若无闲事挂心头，便是人间好时节',
    '青青翠竹，尽是法身',
    '郁郁黄花，无非般若',
    '平常心是道',
    '吃茶去',
    '本来无一物，何处惹尘埃',
    '菩提本无树，明镜亦非台',
    '一花一世界，一叶一菩提',
    '色即是空，空即是色',
    '应无所住，而生其心',
    '不立文字，直指人心',
    '见性成佛',
    '明心见性',
    '万法归一',
    '心外无法',
    '境由心生',
    '随缘不变，不变随缘',
    '无念为宗，无相为体',
    '定慧等持，明心见性',
    '时光静好，岁月安然',
    '云在青天水在瓶',
    '竹影扫阶尘不动',
    '月穿潭底水无痕',
    '行亦禅，坐亦禅',
    '语默动静体安然',
  ];

  // 获取随机语录
  String getRandomQuote() {
    final quote = _quotes[_random.nextInt(_quotes.length)];
    currentQuote.value = quote;
    return quote;
  }

  // 根据场景获取语录
  String getQuoteByContext(QuoteContext context) {
    String quote;
    
    switch (context) {
      case QuoteContext.clear:
        quote = _getClearQuote();
        break;
      case QuoteContext.complete:
        quote = _getCompleteQuote();
        break;
      case QuoteContext.error:
        quote = _getErrorQuote();
        break;
      case QuoteContext.morning:
        quote = _getMorningQuote();
        break;
      case QuoteContext.evening:
        quote = _getEveningQuote();
        break;
      case QuoteContext.alarm:
        quote = _getAlarmQuote();
        break;
      default:
        quote = getRandomQuote();
    }
    
    currentQuote.value = quote;
    return quote;
  }

  String _getClearQuote() {
    const quotes = [
      '放下执念，心自清明',
      '本来无一物，何处惹尘埃',
      '一念放下，万般自在',
    ];
    return quotes[_random.nextInt(quotes.length)];
  }

  String _getCompleteQuote() {
    const quotes = [
      '九九归一',
      '万法归一',
      '一即一切，一切即一',
      '功德圆满',
    ];
    return quotes[_random.nextInt(quotes.length)];
  }

  String _getErrorQuote() {
    const quotes = [
      '错误亦是修行',
      '境由心生',
      '平常心是道',
    ];
    return quotes[_random.nextInt(quotes.length)];
  }

  String _getMorningQuote() {
    const quotes = [
      '晨起一念，万物更新',
      '朝阳初升，心随光明',
      '新的一天，新的开始',
    ];
    return quotes[_random.nextInt(quotes.length)];
  }

  String _getEveningQuote() {
    const quotes = [
      '夕阳西下，心归宁静',
      '月穿潭底水无痕',
      '静坐常思己过',
    ];
    return quotes[_random.nextInt(quotes.length)];
  }

  String _getAlarmQuote() {
    const quotes = [
      '时光静好，岁月安然',
      '时间如流水，珍惜当下',
      '一日之计在于晨',
    ];
    return quotes[_random.nextInt(quotes.length)];
  }
}

enum QuoteContext {
  clear,
  complete,
  error,
  morning,
  evening,
  alarm,
  random,
}
