# ZenClock - 禅意时钟

一个融合禅意美学的 Flutter 时钟应用，采用 Neumorphic 设计风格，提供宁静、专注的时间体验。

![Flutter](https://img.shields.io/badge/Flutter-3.41+-blue)
![Dart](https://img.shields.io/badge/Dart-3.11+-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Version](https://img.shields.io/badge/Version-1.0.0-orange)

## ✨ 核心特性

### 🎨 禅意设计
- **自然配色方案**
  - 浅色主题：温暖的沙石色调（禅宗庭院）
  - 深色主题：深竹绿灰色调（夜间竹林）
  - 强调色：柔和的竹绿色
- **Neumorphic 设计**
  - 手工实现的阴影效果
  - 柔和的凸起/凹陷感
  - 流畅的按压动画
- **极简主义界面**
  - 去除一切不必要的元素
  - 充足的留白空间
  - 单一焦点：时间本身

### 🚀 完整功能

#### ⏰ 闹钟
- 添加/编辑/删除闹钟
- 灵活的重复规则（每天/工作日/周末/自定义）
- 标签和备注
- 震动开关
- 贪睡功能（5/10/15/20/30分钟）
- 本地持久化存储

#### ⏱️ 计时器
- 高精度计时（10ms）
- 无限计次支持
- 单次时间和累计时间显示
- 暂停/继续/重置
- 清晰的计次列表

#### ⏲️ 倒计时
- 快速设置（1/3/5/10/15/30分钟）
- 圆形进度可视化
- 倒计时完成提醒
- 暂停/继续功能
- 重置到初始时间

#### 🌍 世界时钟
- 10个常用城市预设
- 城市搜索和管理
- 实时时间显示
- 自动时差计算
- 滑动删除功能

### 💫 禅意特性

#### 触觉反馈
- 6种分级震动反馈
  - 轻触（10ms）- 数字按钮
  - 中等（15ms）- 功能按钮
  - 强烈（20ms）- 重要操作
  - 成功（双击）- 操作成功
  - 警告（30ms）- 错误提示
  - 选择（8ms）- 选项切换
- 设备兼容性检测
- 可自由开关

#### 音效系统
- 5种自然音效（框架已实现）
  - 竹子敲击声
  - 水滴声
  - 钟声
  - 风铃声
  - 柔和提示音
- 音量控制
- 可自由开关

#### 禅意语录
- 36条精选禅语
- 场景化智能显示
  - 早晨/傍晚自动切换
  - 清除/完成/错误场景
- 淡入淡出动画（800ms）
- 自动刷新（5分钟）

## 🛠️ 技术栈

- **框架**: Flutter 3.41+
- **语言**: Dart 3.11+
- **状态管理**: GetX 4.6.6
- **本地存储**: SharedPreferences 2.2.0
- **触觉反馈**: Vibration 2.0.0
- **音频播放**: AudioPlayers 6.0.0

## � 快速开始

### 环境要求
- Flutter SDK 3.41+
- Dart SDK 3.11+
- Android Studio / VS Code
- Git

### 安装步骤

1. 获取依赖
```bash
flutter pub get
```

2. 运行应用
```bash
flutter run
```

3. 构建发布版本
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📁 项目结构

```
lib/
├── main.dart                           # 应用入口
└── app/
    ├── config/
    │   └── theme/
    │       └── app_theme.dart          # 禅意主题配置
    ├── routes/
    │   ├── app_pages.dart              # 路由配置
    │   └── app_routes.dart             # 路由定义
    ├── services/                       # 服务层
    │   ├── storage_service.dart        # 存储服务
    │   ├── haptic_service.dart         # 触觉反馈
    │   ├── audio_service.dart          # 音效服务
    │   └── zen_quote_service.dart      # 禅意语录
    ├── widgets/                        # 通用组件
    │   ├── neumorphic_container.dart
    │   ├── neumorphic_card.dart
    │   ├── neumorphic_button.dart
    │   └── zen_quote_widget.dart
    └── modules/                        # 功能模块
        ├── clock/                      # 时钟模块
        ├── alarm/                      # 闹钟模块
        ├── timer/                      # 计时器模块
        ├── countdown/                  # 倒计时模块
        ├── world_clock/                # 世界时钟模块
        └── settings/                   # 设置模块
```

## 🎨 设计理念

### 禅意配色

**浅色主题 - 沙石庭院**
```
背景：#E8E4DC  // 温暖的沙色
文字：#3A3A3A  // 墨色
强调：#7C9885  // 竹绿
```

**深色主题 - 夜间竹林**
```
背景：#2B2D2A  // 深竹绿灰
文字：#E8E4DC  // 月光色
强调：#8FA896  // 浅竹绿
```

### Neumorphic 效果

**浅色主题阴影**
- 深色阴影：rgba(0,0,0,0.25) offset(4,4) blur:8
- 浅色高光：white offset(-4,-4) blur:8

**深色主题阴影**
- 深色阴影：rgba(0,0,0,0.6) offset(4,4) blur:8
- 浅色高光：rgba(255,255,255,0.05) offset(-4,-4) blur:8

### 动画时序
- 按钮按压：150ms，缩放到 95%
- 数字切换：300-400ms
- 主题切换：800ms
- 语录淡入：800ms

## 📊 开发进度

- ✅ 第一阶段：基础框架（已完成）
- ✅ 第二阶段：UI 完善（已完成）
- ✅ 第三阶段：核心功能（已完成）
- ✅ 第四阶段：禅意特性（已完成）
- ✅ 第五阶段：增强功能（已完成）
- ⏳ 第六阶段：优化测试（进行中）

**整体完成度：90%**

## 🔧 技术亮点

1. **零第三方 UI 依赖**：手动实现所有 Neumorphic 效果
2. **高精度计时**：计时器支持 10ms 精度
3. **完整的数据持久化**：所有数据本地保存
4. **响应式设计**：GetX 状态管理，自动更新 UI
5. **模块化架构**：清晰的 MVC 结构，易于扩展
6. **分级触觉反馈**：6种不同强度的震动反馈
7. **场景化语录**：根据时间和操作智能显示禅语

## 📝 待完成功能

- [ ] 添加音效文件（5个 mp3）
- [ ] 闹钟铃声选择
- [ ] 后台服务支持
- [ ] 通知推送功能
- [ ] 应用图标和启动页
- [ ] 单元测试
- [ ] 性能优化

## 📖 文档

详细文档请查看 [docs](docs/) 目录：
- [开发方案](docs/development-plan.md)
- [项目架构](docs/architecture.md)
- [设计规范](docs/design.md)
- [API 文档](docs/api.md)
- [实现总结](docs/implementation-summary.md)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- Flutter 团队
- GetX 框架
- Neumorphic 设计社区
- 禅宗美学的启发

---

**项目名称**：ZenClock  
**开发时间**：2026-03-02  
**当前版本**：1.0.0  
**理念**：在时间中寻找宁静

**在时间中寻找宁静，在宁静中感受时间。**
