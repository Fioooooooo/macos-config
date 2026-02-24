# Ghostty 终端配置

Ghostty 终端模拟器个人配置文件。

## 特性

- **半透明背景**: 背景透明度 88%，启用背景模糊效果
- **自定义窗口边距**: 水平和垂直边距均为 10px
- **光标设置**: 方块光标，禁用闪烁
- **字体**: Monaco 字体，13pt
- **自定义着色器**: 光标扫描效果（cursor_sweep.glsl）

## 文件结构

```
.
├── config              # 主配置文件
├── shaders/           # 自定义 GLSL 着色器
│   ├── cursor_ripple.glsl
│   ├── cursor_sweep.glsl
│   └── README.md
└── README.md          # 本文件
```

## 使用方法

1. 将此配置目录链接或复制到 Ghostty 配置路径：

   ```bash
   ln -s /path/to/this/ghostty ~/.config/ghostty
   ```

2. 重启 Ghostty 或重新加载配置

## 配置说明

查看所有可用配置选项：

```bash
ghostty +show-config --default --docs
```

## 参考

- [Ghostty 官方文档](https://ghostty.org)
- [光标着色器来源](https://github.com/sahaj-b/ghostty-cursor-shaders)
