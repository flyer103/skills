---
name: knowledge-explorer
description: 系统化知识探索 - 收集资料、构建知识树、图示化、同步到笔记应用。使用方法：直接说"探索 [主题]"或"学习 [主题]"
version: 1.1
author: OpenClaw Community
---

# 知识探索 Skill

> **版本**: v1.1  
> **适用**: OpenClaw, Claude Code, Claude Desktop  
> **特点**: 跨平台、通用路径、易配置

你是知识探索专家，擅长快速掌握新领域并系统化整理。

## 触发条件

当用户说：
- "探索 [主题]"
- "学习 [主题]"
- "研究 [主题]"
- "帮我了解 [主题]"
- "系统学习 [主题]"

## 配置说明

### 输出路径配置

**默认行为**：
1. 优先保存到笔记应用（Obsidian/Notion/Logseq 等）
2. 备份到 OpenClaw workspace

**路径优先级**（自动检测）：
```bash
# 1. Obsidian（如果检测到）
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/knowledge/
# 或 Linux/Windows 的 Obsidian 路径

# 2. OpenClaw workspace（默认）
~/.openclaw/workspace/

# 3. 用户自定义路径
# 在 HEARTBEAT.md 或对话中指定
```

**自定义路径**：
```
用户：探索 React，保存到 ~/Documents/notes/
```

---

## 执行流程（必须遵循）

### 阶段 1：资料收集（5-10 分钟）

1. **搜索官方来源**
   - 官方文档
   - API 文档
   - GitHub 仓库
   - 权威教程

2. **使用工具**
   ```
   web_search - 搜索 "[主题] official documentation"
   web_search - 搜索 "[主题] tutorial best practices"
   web_fetch - 获取官方文档内容
   ```

### 阶段 2：构建知识树（核心步骤）

**严格遵循 80-15-5 规则**：

| 层级 | 价值占比 | 内容类型 | 数量建议 |
|------|---------|---------|---------|
| 🌳 **主干** | 80% | 核心概念、必会技能 | 5-10 个 |
| 🌿 **分支** | 15% | 进阶应用、最佳实践 | 5-10 个 |
| 🍃 **枝叶** | 5% | 细节配置、边缘案例 | 5-10 个 |

**判断标准**：
- **主干**：不理解就无法使用的内容
- **分支**：掌握后能显著提升的内容
- **枝叶**：特定场景才需要的细节

### 阶段 3：图示化核心概念

**使用 Mermaid 绘制 2-4 个图表**（优先级从高到低）：

1. **概念关系图**（必须）
   ```mermaid
   graph TD
       Core[核心概念] --> Concept1[概念 1]
       Core --> Concept2[概念 2]
   ```

2. **学习路径图**（推荐）
   ```mermaid
   graph LR
       Start[开始] --> Stage1[阶段 1：基础]
       Stage1 --> Stage2[阶段 2：进阶]
   ```

3. **架构图/时序图**（如适用）
   ```mermaid
   graph TB 或 sequenceDiagram
   ```

4. **时间线/流程图**（可选）
   ```mermaid
   timeline 或 graph LR
   ```

**Mermaid 图表类型**（按推荐度）：

| 图表类型 | 用途 | 推荐度 | 稳定性 |
|---------|------|-------|-------|
| `graph TD/LR/TB` | 概念关系、流程 | ⭐⭐⭐⭐⭐ | ✅ 稳定 |
| `mindmap` | 思维导图、知识结构 | ⭐⭐⭐⭐⭐ | ✅ 稳定 |
| `sequenceDiagram` | 时序、交互流程 | ⭐⭐⭐⭐ | ✅ 稳定 |
| `erDiagram` | 实体关系、数据模型 | ⭐⭐⭐⭐ | ✅ 稳定 |
| `pie` | 比例、分布 | ⭐⭐⭐ | ✅ 稳定 |
| `timeline` | 时间线、演进历史 | ⭐⭐⭐ | ⚠️ 实验性 |
| `gantt` | 项目计划、时间表 | ⭐⭐ | ⚠️ 实验性 |
| `journey` | 用户旅程、故事线 | ⭐⭐ | ⚠️ 实验性 |

**使用建议**：
- ✅ 优先使用稳定图表类型（graph, mindmap, sequenceDiagram, erDiagram, pie）
- ✅ 实验性功能也**可以使用**（timeline, gantt, journey）
- ✅ 在 Obsidian/GitHub/Mermaid Live 中测试兼容性
- ✅ 如遇渲染问题，提供备选方案（如用 graph LR 替代 timeline）
- ✅ 节点命名使用标准字符，提高兼容性

**实验性功能注意事项**：
- `timeline`：在某些旧版本 Mermaid 中可能不支持
- `gantt`：需要特定格式，渲染复杂
- **解决方案**：如遇兼容性问题，替换为等效的 `graph LR` 图表

### 阶段 4：输出交付

**文件名格式**：`[主题]_知识树.md`

**保存策略**（自动）：

1. **检测笔记应用**：
   ```bash
   # macOS - Obsidian
   if [ -d ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian ]; then
       SAVE_PATH=~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian/knowledge/
   # Linux - Obsidian
   elif [ -d ~/.config/obsidian ]; then
       SAVE_PATH=~/.config/obsidian/knowledge/
   # 备用：OpenClaw workspace
   else
       SAVE_PATH=~/.openclaw/workspace/
   fi
   ```

2. **自动创建目录**：
   - 如果 `knowledge/` 不存在，自动创建
   - 确保路径可写

3. **保存确认**：
   ```
   ✅ 知识树已保存
      📁 [保存路径]/[主题]_知识树.md
      📱 [同步状态，如适用]
      💎 [查看建议]
   ```

**用户指定路径**：
```
用户：探索 Python，保存到 ~/Documents/learning/
→ 使用用户指定的路径
```

---

## 文件结构模板

```markdown
# [主题] 知识树

> 生成时间: YYYY-MM-DD  
> 来源: [官方文档链接]  
> 目的: [具体学习目标]

---

## 🌳 主干：核心知识（80% 价值）

### 1. [核心概念 1]
**定义**：[简明定义]

**为什么重要**：
- [原因 1]
- [原因 2]

**如何使用**：
```bash
# 示例代码或命令
```

### 2. [核心概念 2]
...

---

## 🌿 分支：重要知识（15% 价值）

### 11. [进阶主题 1]
...

---

## 🍃 枝叶：细节知识（5% 价值）

### 17-25. [细节配置]
...

---

## 🎯 学习路径

### 阶段 1：掌握核心（2-3 小时）
- [ ] 学习 [核心概念 1]
- [ ] 学习 [核心概念 2]
- [ ] 完成快速入门

### 阶段 2：进阶实践（3-5 小时）
- [ ] 学习 [进阶主题 1]
- [ ] 实际项目应用

### 阶段 3：深度定制（可选）
- [ ] 学习 [细节配置]
- [ ] 性能优化

---

## 💡 快速入门（5-10 分钟）

### 步骤 1：安装（X 分钟）
```bash
# 通用安装命令
```

### 步骤 2：初始化（Y 分钟）
```bash
# 初始化命令
```

### 步骤 3：基本使用（Z 分钟）
```bash
# 基本命令示例
```

---

## ❓ FAQ（常见问题）

[FAQ 内容 - 根据阶段 3 判断是否生成]

---

## 📚 扩展资源

- **官方文档**: [链接]
- **最佳实践**: [链接]
- **社区**: [链接]
- **推荐教程**: [链接]

---

## 🎨 概念关系图

[Mermaid 图表]

---

## 🚀 学习路径图

[Mermaid 图表]
```

---

## 质量检查清单

完成后必须验证：
- [ ] 主干内容覆盖 80% 核心价值
- [ ] 至少 2 个 Mermaid 图表
- [ ] 包含快速入门指南（5-10 分钟可完成）
- [ ] 提供学习路径建议
- [ ] 文件已保存到适当位置
- [ ] 使用通用路径（无硬编码用户名）

---

## 跨平台支持

### macOS
```bash
# Obsidian iCloud
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/knowledge/

# 本地 Obsidian
~/Documents/Obsidian/knowledge/
```

### Linux
```bash
# Obsidian
~/.config/obsidian/knowledge/
# 或
~/Documents/Obsidian/knowledge/
```

### Windows (WSL)
```bash
# Obsidian
/mnt/c/Users/$USER/Documents/Obsidian/knowledge/
# 或使用 Windows 路径表示
C:\Users\[用户名]\Documents\Obsidian\knowledge\
```

### 自动检测逻辑
1. 检查常见笔记应用路径
2. 如果都不存在，使用 `~/.openclaw/workspace/`
3. 用户可通过对话指定自定义路径

---

## 特殊场景处理

### 场景 1：主题过于宽泛
**处理**：先询问用户具体方向
```
"[主题] 很广，建议聚焦于：
1. 具体方向 A
2. 具体方向 B
你更想学习哪个？"
```

### 场景 2：找不到官方文档
**处理**：使用最权威的来源，并在文档中注明

### 场景 3：用户指定保存路径
**处理**：优先使用用户指定的路径

### 场景 4：路径不存在
**处理**：自动创建目录
```bash
mkdir -p "[目标路径]"
```

### 场景 5：权限问题
**处理**：提示用户检查权限，使用备用路径

---

## 通用化设计原则

### ✅ 应该做

1. **使用通用路径表示**
   - ✅ `~/` (用户主目录)
   - ✅ `$HOME/` (环境变量)
   - ✅ `~/.openclaw/` (标准 OpenClaw 路径)

2. **避免硬编码**
   - ✅ 自动检测用户环境
   - ✅ 提供配置选项
   - ✅ 使用相对路径

3. **跨平台兼容**
   - ✅ 支持 macOS/Linux/Windows
   - ✅ 自动适配路径格式
   - ✅ 提供平台特定说明

### ❌ 不应该做

1. **硬编码用户名**
   - ❌ `/Users/username/...`
   - ✅ `~/...` 或 `$HOME/...`

2. **硬编码绝对路径**
   - ❌ `/home/username/...`
   - ✅ 自动检测或询问用户

3. **假设特定环境**
   - ❌ 假设使用 Obsidian
   - ✅ 支持多种笔记应用

---

## 示例对话

**用户**：探索 React 18

**助手**：
```
📚 阶段 1：资料收集
✅ 找到 React 官方文档
✅ 收集核心概念...

🌳 阶段 2：构建知识树
识别核心概念（80% 价值）：
1. Concurrent Rendering
2. Suspense
3. Transitions
...

🎨 阶段 3：图示化
✅ 架构图
✅ 学习路径图

💾 阶段 4：输出
检测到 Obsidian...
✅ 已保存到 Obsidian
   📁 knowledge/React_18_知识树.md
   📱 iCloud 同步已启用
   💎 在 Obsidian 中查看

🎯 快速入门（5 分钟）：
1. 升级到 React 18
2. 使用 createRoot
3. 尝试 useTransition
```

---

## 记忆要点

- **80-15-5 原则**是核心
- **关键点提炼**：定义、重要性、使用、陷阱
- **快速入门**必须可操作
- **图示化**增强理解
- **FAQ 判断**：复杂概念、常见误解、面试高频 → 需要
- **通用路径**便于分享
- **自动检测**减少配置

---

## 适配指南

### 其他用户如何使用

1. **直接使用**（无需配置）：
   ```
   探索 [主题]
   ```
   - 自动保存到 `~/.openclaw/workspace/`

2. **配置 Obsidian**（可选）：
   - 安装 Obsidian
   - 启用 iCloud 同步（macOS）
   - Skill 自动检测并使用

3. **自定义路径**：
   ```
   探索 [主题]，保存到 [自定义路径]
   ```

---

**使用此 Skill，知识探索变得简单、系统化、可分享！** 🚀✨
