# ZenClock 项目架构

## 技术栈

- **框架**: Flutter 3.41+
- **语言**: Dart 3.11+
- **状态管理**: GetX
- **路由管理**: GetX Navigation
- **本地存储**: SharedPreferences
- **音频**: AudioPlayers
- **触觉反馈**: Vibration

## 架构模式

本项目采用 **GetX MVC 架构模式**，结合模块化设计。

### 目录结构

```
lib/
├── main.dart                    # 应用入口
└── app/
    ├── config/                  # 配置文件
    │   └── theme/              # 主题配置
    ├── routes/                  # 路由配置
    ├── modules/                 # 功能模块
    │   └── clock/              # 时钟模块
    │       ├── bindings/       # 依赖注入
    │       ├── controllers/    # 业务逻辑
    │       └── views/          # UI 视图
    ├── widgets/                 # 通用组件
    ├── services/                # 服务层
    └── utils/                   # 工具类
```

## 模块设计

### Clock 模块（时钟）
- **Controller**: 管理时间状态和更新逻辑
- **View**: 展示时钟界面
- **Binding**: 依赖注入配置

### 未来模块规划
- **Alarm 模块**: 闹钟功能
- **Timer 模块**: 计时器功能
- **Countdown 模块**: 倒计时功能
- **WorldClock 模块**: 世界时钟功能

## 数据流

```
View (UI) 
  ↓ 用户交互
Controller (业务逻辑)
  ↓ 状态更新
Service (服务层)
  ↓ 数据持久化
Storage (本地存储)
```

## 状态管理

使用 GetX 的响应式状态管理：
- `.obs` 创建可观察变量
- `Obx()` 监听状态变化
- `Get.find()` 获取控制器实例

## 依赖注入

通过 GetX Binding 实现依赖注入：
- 懒加载控制器
- 自动内存管理
- 解耦模块依赖
