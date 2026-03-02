# ZenClock 开发指南

## 环境配置

### 必需工具
- Flutter SDK 3.41+
- Dart SDK 3.11+
- Android Studio / VS Code
- Git

### 安装步骤

1. 安装 Flutter
```bash
# 参考官方文档: https://flutter.dev/docs/get-started/install
```

2. 克隆项目
```bash
git clone <repository-url>
cd ZenClock
```

3. 获取依赖
```bash
flutter pub get
```

4. 运行项目
```bash
flutter run
```

## 开发流程

### 分支管理
- `main`: 主分支，稳定版本
- `develop`: 开发分支
- `feature/*`: 功能分支
- `bugfix/*`: 修复分支

### 提交规范
```
<type>(<scope>): <subject>

<body>

<footer>
```

类型（type）:
- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建/工具相关

示例:
```
feat(clock): 添加实时时钟显示功能

- 实现 ClockController
- 添加定时器更新逻辑
- 完成 UI 展示

Closes #123
```

## 代码规范

### Dart 代码风格
遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 规范：

- 使用 `lowerCamelCase` 命名变量和方法
- 使用 `UpperCamelCase` 命名类和枚举
- 使用 `lowercase_with_underscores` 命名库和文件
- 优先使用 `const` 构造函数
- 使用单引号字符串

### 项目规范
- 每个模块独立目录
- Controller 只处理业务逻辑
- View 只负责 UI 展示
- Service 处理数据和外部交互
- Widget 保持可复用性

## 测试

### 单元测试
```bash
flutter test
```

### Widget 测试
```bash
flutter test test/widget_test.dart
```

### 集成测试
```bash
flutter drive --target=test_driver/app.dart
```

## 构建发布

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 调试技巧

### 热重载
- `r`: 热重载
- `R`: 热重启
- `q`: 退出

### 性能分析
```bash
flutter run --profile
```

### 日志输出
```dart
import 'package:flutter/foundation.dart';

if (kDebugMode) {
  print('Debug message');
}
```

## 常见问题

### 依赖冲突
```bash
flutter pub cache repair
flutter clean
flutter pub get
```

### 构建失败
```bash
flutter clean
flutter pub get
flutter run
```

## 资源

- [Flutter 官方文档](https://flutter.dev/docs)
- [GetX 文档](https://pub.dev/packages/get)
- [Dart 语言指南](https://dart.dev/guides)
