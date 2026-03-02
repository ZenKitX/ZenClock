# ZenClock API 文档

## ClockController

时钟控制器，管理时间状态和更新逻辑。

### 属性

#### currentTime
```dart
final Rx<DateTime> currentTime
```
当前时间的响应式变量。

### 方法

#### onInit()
```dart
@override
void onInit()
```
控制器初始化时调用，启动定时器。

#### onClose()
```dart
@override
void onClose()
```
控制器销毁时调用，取消定时器。

#### _startTimer()
```dart
void _startTimer()
```
启动定时器，每秒更新一次时间。

---

## AppTheme

应用主题配置类。

### 静态属性

#### lightTheme
```dart
static ThemeData lightTheme
```
浅色主题配置（沙石庭院）。

#### darkTheme
```dart
static ThemeData darkTheme
```
深色主题配置（夜间竹林）。

---

## 路由配置

### Routes

路由常量定义。

```dart
abstract class Routes {
  static const CLOCK = '/clock';
}
```

### AppPages

路由页面配置。

```dart
class AppPages {
  static const INITIAL = Routes.CLOCK;
  static final routes = [...];
}
```
