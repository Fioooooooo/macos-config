# Ghostty 终端配置

这个目录保存的是 Ghostty 的个人配置，包括主配置文件和自定义 shader。

## 当前配置

- 主题：`TokyoNight`
- 背景：透明度 `0.8`，开启模糊
- 窗口边距：`10px`
- 光标：方块，不闪烁
- 字体：`MesloLGS NF, PingFang SC`，字号 `13`
- 交互：`copy-on-select`、`focus-follows-mouse`
- 自定义 shader：
  - `shaders/cursor_blaze_no_trail.glsl`
  - `shaders/cursor_smear.glsl`
- 当前默认 cursor 配色：`blue`（冰蓝极光）

这两个 shader 叠加后的效果不是“全局滤镜”，而是专门作用在光标上：

- `cursor_blaze_no_trail.glsl`：强化当前光标本体的高亮和发光感
- `cursor_smear.glsl`：在光标移动时生成一段短拖尾，让移动更有速度感

## 文件结构

```text
.
├── config.ghostty    # Ghostty 主配置文件
├── cursor-theme.sh   # 快速切换 cursor 配色
├── shaders/
│   ├── bloom25.glsl
│   ├── cursor_blaze_no_trail.glsl
│   ├── cursor_smear.glsl
│   ├── cursor_sweep.glsl
│   └── README.md
└── README.md
```

## 使用方法

推荐直接把整个目录链接到 XDG 配置路径：

```bash
mkdir -p ~/.config
ln -sfn /path/to/this/ghostty ~/.config/ghostty
```

然后重启 Ghostty，或者执行配置重载。

## Cursor 配色切换

仓库额外提供了一个快捷脚本，用来同时切换两个 cursor shader 的配色：

```bash
cd /path/to/this/ghostty
./cursor-theme.sh --list
./cursor-theme.sh --theme=rose
```

支持的主题有：

- `blue`：冰蓝极光
- `green`：翡翠绿
- `rose`：玫瑰金
- `amber`：琥珀火

脚本会同步修改：

- `shaders/cursor_blaze_no_trail.glsl`
- `shaders/cursor_smear.glsl`

这样可以保证光标高亮层和拖尾层使用同一套颜色。切换完成后，重载配置或重启 Ghostty 即可生效。

## 配置说明

查看 Ghostty 当前支持的全部配置项：

```bash
ghostty +show-config --default --docs
```

如果你在 macOS 上已经有
`~/Library/Application Support/com.mitchellh.ghostty/config`
或 `config.ghostty`，它会在 `~/.config/ghostty/config.ghostty` 之后继续被加载。为了避免覆盖关系不清楚，建议只保留一套全局配置。

## 参考

- Ghostty 官方文档：<https://ghostty.org>
- Ghostty 配置文档：<https://ghostty.org/docs/config>
- 光标 shader 来源：<https://github.com/sahaj-b/ghostty-cursor-shaders>
