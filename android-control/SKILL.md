---
name: android-control
description: 通过 ADB 控制 Android 手机（截图、点击、滑动、输入文字、拍照、发短信）。使用 adb 命令操作已连接的 Android 设备。
---

# Android Control Skill

通过 ADB 控制 Android 手机。前提：手机已开启 USB 调试并连接电脑。

## 检查连接

```bash
adb devices
```

如果显示 `unauthorized`，需要在手机上允许 USB 调试。

## 常用命令

### 截图

```bash
# 方法一：截图到手机再拉取
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png ./
adb shell rm /sdcard/screenshot.png

# 方法二：直接输出到本地（推荐）
adb exec-out screencap -p > screenshot.png
```

### 点击

```bash
adb shell input tap <x> <y>

# 示例：点击屏幕中央（1080x2400 分辨率）
adb shell input tap 540 1200
```

### 滑动

```bash
adb shell input swipe <x1> <y1> <x2> <y2> <duration_ms>

# 向上滑动（手指从下往上划）
adb shell input swipe 500 1500 500 500 300

# 向下滑动
adb shell input swipe 500 500 500 1500 300
```

### 输入文字

```bash
adb shell input text "hello"
```

注意：只能输入英文字符。中文需要用 URL 参数或剪贴板方案。

### 按键

```bash
# 常用按键
adb shell input keyevent KEYCODE_HOME      # Home 键
adb shell input keyevent KEYCODE_BACK      # 返回键
adb shell input keyevent KEYCODE_APP_SWITCH # 最近任务
adb shell input keyevent KEYCODE_POWER     # 电源键
adb shell input keyevent KEYCODE_WAKEUP    # 唤醒屏幕
adb shell input keyevent KEYCODE_VOLUME_UP # 音量+
adb shell input keyevent KEYCODE_VOLUME_DOWN # 音量-
```

### 获取屏幕分辨率

```bash
adb shell wm size
```

### 打开应用

```bash
adb shell am start -n <package>/<activity>

# 常用应用
adb shell am start -n com.tencent.mm/.ui.LauncherUI           # 微信
adb shell am start -n com.android.camera/.Camera              # 相机
adb shell am start -n com.android.mms/.ui.ComposeMessageRouterActivity # 短信
```

### 获取当前 Activity

```bash
adb shell dumpsys window | grep -i mCurrentFocus
```

### 获取 UI 元素信息

```bash
# 导出 UI 层级
adb shell uiautomator dump /sdcard/ui.xml
adb shell cat /sdcard/ui.xml

# 查找特定元素
adb shell cat /sdcard/ui.xml | grep "send_button"
```

## AI 操作流程

1. 先截图，用 image 工具分析界面
2. 确定要点击/操作的坐标
3. 执行操作
4. 再次截图验证结果
5. 循环直到完成任务

---

## MIUI 特殊处理

### 相机拍照

小米手机使用 `android.media.action.IMAGE_CAPTURE` Intent 会打开 OneShotCamera 模式，需要手动确认保存。推荐使用普通相机模式：

```bash
# 打开普通相机（自动保存）
adb shell am start -n com.android.camera/.Camera

# 等待相机启动
sleep 2

# 点击拍照按钮（屏幕底部中央，1080x2400 分辨率）
adb shell input tap 540 2100

# 等待拍照完成（MIUI 会自动保存到 DCIM/Camera/）
sleep 2
```

**注意**：
- 普通相机模式拍照后会自动保存，无需手动确认
- 照片保存在 `/storage/emulated/0/DCIM/Camera/`

### 获取最新照片

```bash
# 查询最新照片
adb shell "content query --uri content://media/external/images/media 2>/dev/null | grep -E '(DCIM|Camera)' | head -1"

# 拉取照片到本地
adb pull /storage/emulated/0/DCIM/Camera/IMG_xxx.jpg ./photo.jpg
```

### 短信发送

MIUI 短信应用有特殊处理：

```bash
# 通过 Intent 打开短信编辑界面（支持 URL 编码的中文内容）
PHONE="<手机号>"
BODY=$(echo '短信内容' | jq -sRr @uri)
adb shell "am start -a android.intent.action.SENDTO -d 'sms:${PHONE}?body=${BODY}'"

# 等待界面加载
sleep 2

# 发送按钮位置（1080x2400 分辨率）
# 先获取按钮坐标
adb shell uiautomator dump /sdcard/ui.xml
adb shell cat /sdcard/ui.xml | grep 'send_button' | grep -oE 'bounds="\[[0-9,]+\]\[[0-9,]+\]"'

# 点击发送按钮（根据实际坐标调整）
adb shell input tap 992 2282
```

**注意事项：**
- 内容通过 URL 参数传递，支持中文
- 发送按钮需要输入框有内容才会变成"发送短信"图标
- 可能弹出权限请求（麦克风等），需要处理

### 处理权限弹窗

```bash
# 使用 uiautomator 获取按钮位置
adb shell uiautomator dump /sdcard/perm.xml
adb shell cat /sdcard/perm.xml | grep -E "(允许|拒绝|Allow|Deny)" | grep -oE 'text="[^"]*"|bounds="[^"]*"'

# 点击对应按钮
adb shell input tap <x> <y>
```

### 截图限制

MIUI 可能在某些界面禁止截图（返回15KB空文件）。解决方法：

```bash
# 使用 exec-out 方式（推荐）
adb exec-out screencap -p > screenshot.png

# 检查截图是否有效（应大于100KB）
ls -la screenshot.png
```

### 通知栏无法滑动关闭

MIUI 通知栏可能无法通过 swipe 关闭，使用：
```bash
adb shell input keyevent KEYCODE_HOME
```

### 点击需要额外权限

如果点击报错 `INJECT_EVENTS permission`：
**设置 → 更多设置 → 开发者选项 → USB 调试（安全设置）** → 开启

---

## 通用函数

### 发送短信

```bash
send_sms() {
    local phone="$1"
    local message="$2"
    local body=$(echo "$message" | jq -sRr @uri)
    
    adb shell "am start -a android.intent.action.SENDTO -d 'sms:${phone}?body=${body}'"
    sleep 2
    
    # 获取发送按钮坐标并发送
    adb shell uiautomator dump /sdcard/ui.xml
    local bounds=$(adb shell cat /sdcard/ui.xml | grep 'content-desc="发送短信"' | grep -oE 'bounds="\[[0-9,]+\]\[[0-9,]+\]"' | head -1)
    
    if [ -n "$bounds" ]; then
        # 解析坐标并点击中心点
        local x1=$(echo "$bounds" | grep -oE '\[([0-9]+),' | head -1 | tr -d '[,')
        local y1=$(echo "$bounds" | grep -oE ',([0-9]+)\]' | head -1 | tr -d ',]')
        local x2=$(echo "$bounds" | grep -oE '\[([0-9]+),' | tail -1 | tr -d '[,')
        local y2=$(echo "$bounds" | grep -oE ',([0-9]+)\]' | tail -1 | tr -d ',]')
        local cx=$(( (x1 + x2) / 2 ))
        local cy=$(( (y1 + y2) / 2 ))
        adb shell input tap $cx $cy
        echo "短信已发送到 $phone"
    else
        echo "未找到发送按钮"
    fi
}

# 使用示例
# send_sms "13800138000" "这是一条测试短信"
```

### 拍照并获取

```bash
take_photo() {
    local output="${1:-photo.jpg}"
    
    adb shell am start -n com.android.camera/.Camera
    sleep 2
    adb shell input tap 540 2100  # 拍照按钮
    sleep 2
    
    # 获取最新照片
    local latest=$(adb shell "content query --uri content://media/external/images/media 2>/dev/null | grep 'DCIM/Camera' | head -1" | grep -oE '/storage[^,]*')
    
    if [ -n "$latest" ]; then
        adb pull "$latest" "$output"
        echo "照片已保存到 $output"
    else
        echo "未找到照片"
    fi
}

# 使用示例
# take_photo "my_photo.jpg"
```

---

## ADBKeyboard 中文输入

`adb shell input text` 不支持中文，需要安装 ADBKeyboard：

```bash
# 安装 ADBKeyboard
curl -L -o /tmp/ADBKeyboard.apk "https://github.com/senzhk/ADBKeyBoard/raw/master/ADBKeyboard.apk"
adb install /tmp/ADBKeyboard.apk

# 启用并设置为默认输入法
adb shell ime enable com.android.adbkeyboard/.AdbIME
adb shell settings put secure default_input_method com.android.adbkeyboard/.AdbIME

# 输入中文（需要输入框获得焦点）
adb shell am broadcast -a ADB_INPUT_TEXT --es msg '这是中文内容'

# 恢复原输入法（如讯飞）
adb shell settings put secure default_input_method com.iflytek.inputmethod.miui/.FlyIME
```

---

## ⚠️ 重要规则

### 失败重试限制

**同一操作失败超过 3 次 → 立即停止并报告，不再重复尝试。**

这包括：
- 同一坐标点击 3 次无反应
- 同一命令执行 3 次失败
- 同一 UI 元素查找 3 次找不到

遇到这种情况，应该：
1. 停止当前操作
2. 向用户报告失败原因
3. 提供可能的解决方案或询问下一步

---

## 中文输入（ADBKeyboard）

ADB 原生 `input text` 不支持中文。解决方案：安装 ADBKeyboard。

### 安装与配置

```bash
# 下载并安装
curl -L -o /tmp/ADBKeyboard.apk "https://github.com/senzhk/ADBKeyBoard/raw/master/ADBKeyboard.apk"
adb install /tmp/ADBKeyboard.apk

# 启用并设置为默认输入法
adb shell ime enable com.android.adbkeyboard/.AdbIME
adb shell settings put secure default_input_method com.android.adbkeyboard/.AdbIME
```

### 使用方法

```bash
# 输入中文（需要先点击输入框获得焦点）
adb shell am broadcast -a ADB_INPUT_TEXT --es msg '这是中文内容'

# 恢复原输入法（讯飞）
adb shell settings put secure default_input_method com.iflytek.inputmethod.miui/.FlyIME
```

**注意：** 输入前必须确保输入框已获得焦点（已点击激活）

---

## 注意事项

- 坐标基于手机实际分辨率（小米常见：1080x2400）
- `input text` 不支持中文，使用 ADBKeyboard 或 URL 参数方案
- 某些应用可能有防自动化检测
- MIUI 相机普通模式拍照自动保存，OneShotCamera 模式需手动确认
- MIUI 某些界面禁止截图，返回 15KB 空文件
- 使用 `uiautomator dump` 获取准确的 UI 元素坐标
- **同一操作失败超过 3 次 → 停止并报告**
