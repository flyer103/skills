# Skills Collection

这是我日常使用和探索过程中积累的 openclaw skills 集合。

## 📋 目录

- [Android 控制 (android-control)](#android-control)
- [知识探索 (knowledge-explorer)](#knowledge-explorer)
- [使用方式](#使用方式)

## Skills

### Android 控制 (android-control)

通过 ADB 控制 Android 手机（截图、点击、滑动、输入文字、拍照、发短信）。

**触发方式**：
- "控制手机 [操作]"
- "发送短信 [号码] [内容]"
- "拍照"
- "截图"

**核心特性**：
- 📱 支持屏幕截图、点击、滑动等基本操作
- ⌨️ 支持文本输入（含中文，需 ADBKeyboard）
- 📸 支持拍照并获取照片
- 💬 支持发送短信（含中文内容）
- 🎯 支持 MIUI 系统特殊处理
- 🔧 提供 UI 元素定位和坐标计算

**前提要求**：
- 手机已开启 USB 调试
- 手机已连接电脑
- 已授权 USB 调试（如显示 `unauthorized` 需在手机上允许）

**示例**：
```
控制手机截图
发送短信 13800138000 测试消息
拍照
控制手机打开微信
```

### 知识探索 (knowledge-explorer)

系统化知识探索工具，帮助快速掌握新领域并整理成结构化文档。

**触发方式**：
- "探索 [主题]"
- "学习 [主题]"
- "研究 [主题]"

**核心特性**：
- 📚 自动收集官方文档和权威资料
- 🌳 按照 80-15-5 规则构建知识树
- 🎨 使用 Mermaid 图表可视化核心概念
- 📝 生成结构化文档保存到 workspace
- 🎯 提供快速入门指南和学习路径

**示例**：
```
探索 React 18
学习 Kubernetes 架构
研究 Rust 所有权机制
```

## 使用方式

1. 将 `skills/` 目录添加到你的 openclaw 配置路径中
2. 使用相应的触发词激活对应的 skill
3. 按照提示完成交互

每个 skill 都会自动执行相应的任务，并提供详细的输出和文档。

## License

MIT License - 详见 [LICENSE](LICENSE)
