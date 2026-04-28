# macOS Config

这是一个向社区分享我个人 macOS 终端配置的仓库，同时也方便其他人按需复刻。当前主要维护两部分内容：

- `zsh/`：`zsh`、`Oh My Zsh`、`Powerlevel10k` 的 shell 配置
- `ghostty/`：Ghostty 终端配置和自定义 shader

它不是“一键装机脚本”，而是一份可以被参考、复刻和按需裁剪的配置集合。看完这份 README，你应该能知道：

- 这个仓库是干嘛的
- 依赖需要先装什么
- 配置文件应该链接到哪里
- 第一次启动后要做什么

## 仓库内容

```text
.
├── README.md
├── ghostty/
│   ├── config.ghostty
│   ├── cursor-theme.sh
│   ├── shaders/
│   └── README.md
└── zsh/
    ├── .zshrc
    └── .p10k.zsh
```

## 适用环境

- macOS
- `zsh`
- `Oh My Zsh`
- `Powerlevel10k`
- Ghostty

当前仓库里的 `zsh/.zshrc` 还启用了这些插件或工具：

- `zsh-autosuggestions`
- `zoxide`
- `jenv`
- `pyenv`
- `nvm`

如果你暂时不用这些工具，可以先装完 README 里的核心依赖，再按需安装；也可以直接删掉 `zsh/.zshrc` 里不需要的插件项。

## 从零开始安装

### 1. 安装 Xcode Command Line Tools

Homebrew 和一部分开发工具依赖它：

```bash
xcode-select --install
```

### 2. 安装 Homebrew

Homebrew 是这个仓库默认使用的包管理器，后面的 Ghostty、字体和一部分命令行工具都建议通过它安装。

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装完成后，按 Homebrew 安装器在终端里给出的提示，把 `brew shellenv` 写入你的 `~/.zprofile`。

可选检查：

```bash
brew --version
```

### 3. 安装 zsh

macOS 默认自带 `zsh`，大多数情况下这一步可以跳过，先确认版本即可：

```bash
zsh --version
```

如果你想使用 Homebrew 安装的新版 `zsh`：

```bash
brew install zsh
```

如果你还想把 Homebrew 版 `zsh` 设为默认 shell，再执行：

```bash
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/zsh"
```

### 4. 安装 Oh My Zsh

这个仓库里的 `zsh/.zshrc` 基于 `Oh My Zsh`，所以这一步是必须的。

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

如果你的网络访问 `raw.githubusercontent.com` 比较慢，也可以使用官方短链接：

```bash
sh -c "$(curl -fsSL https://install.ohmyz.sh)"
```

### 5. 安装 Powerlevel10k

这个仓库的提示符主题是 `Powerlevel10k`，并且已经提供好了现成的 `zsh/.p10k.zsh`。

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

如果你在中国大陆，`Powerlevel10k` 官方 README 也给出了 Gitee 镜像：

```bash
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

### 6. 安装 `zsh-autosuggestions`

当前 `zsh/.zshrc` 里启用了这个插件，不安装的话启动 `zsh` 时会提示插件不存在。

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

### 7. 安装 Ghostty

推荐直接使用 Homebrew Cask：

```bash
brew install --cask ghostty
```

也可以从 Ghostty 官方下载页手动安装 `.dmg`。

### 8. 安装 Powerlevel10k / Ghostty 需要的字体

当前 [ghostty/config.ghostty](/Users/tao/Work/Fio/macos-config/ghostty/config.ghostty) 里显式指定了：

```text
font-family = "MesloLGS NF, PingFang SC"
```

为了让 `Powerlevel10k` 图标和终端显示效果一致，建议安装 Meslo Nerd Font：

```bash
brew install --cask font-meslo-lg-nerd-font
```

## 怎么复刻这套配置

先进入仓库目录：

```bash
cd /path/to/macos-config
```

然后把配置文件链接到用户目录。

### zsh

```bash
ln -sfn "$(pwd)/zsh/.zshrc" ~/.zshrc
ln -sfn "$(pwd)/zsh/.p10k.zsh" ~/.p10k.zsh
```

### Ghostty

当前仓库只保留 Ghostty 官方最新命名的 `config.ghostty`。推荐直接把整个 `ghostty/` 目录链接到 `~/.config/ghostty`，这样主配置和 shader 可以一起生效。

```bash
mkdir -p ~/.config
ln -sfn "$(pwd)/ghostty" ~/.config/ghostty
```

注意：在 macOS 上，如果你之前已经有
`~/Library/Application Support/com.mitchellh.ghostty/config`
或 `config.ghostty`，它会在 XDG 配置之后继续被加载，并覆盖前面的值。最好只保留一套 Ghostty 全局配置，避免排查时混淆。

这套 Ghostty 配置目前的特点：

- 主题是 `TokyoNight`
- 背景透明度 `0.8`，开启模糊，窗口留有 `10px` 边距
- 光标使用方块样式，不闪烁
- 开启 `copy-on-select` 和 `focus-follows-mouse`
- 默认启用两层 cursor shader：
  - `cursor_blaze_no_trail.glsl`：给当前光标增加高亮和发光感
  - `cursor_smear.glsl`：在光标移动时增加一段拖尾 / smear 效果
- 当前默认 cursor 配色是 `blue`，也就是脚本里的“冰蓝极光”

如果你想切换 cursor 配色，仓库里还提供了快捷脚本：

```bash
cd ghostty
./cursor-theme.sh --list
./cursor-theme.sh --theme=green
```

可选颜色有 `blue`、`green`、`rose`、`amber`。脚本会同时修改两个 shader 文件里的颜色常量，保证发光层和拖尾层保持同一套配色。切换后，重载 Ghostty 配置或重启 Ghostty 即可生效。

## 第一次启动后

### 1. 重启 shell

```bash
exec zsh
```

### 2. 如果想重新生成自己的 p10k 样式

```bash
p10k configure
```

如果你只是想复刻仓库里的样式，不需要执行这一步。

### 3. 打开 Ghostty

第一次打开后，确认这些项目是否符合预期：

- 主题是否为 `TokyoNight`
- 字体是否正常显示图标
- 背景透明、模糊和 shader 是否正常生效

## 常见问题

### `[oh-my-zsh] theme 'powerlevel10k/powerlevel10k' not found`

说明 `Powerlevel10k` 还没安装到 `Oh My Zsh` 的主题目录，回到上面的“安装 Powerlevel10k”步骤执行一次即可。

### `[oh-my-zsh] plugin 'zsh-autosuggestions' not found`

说明插件还没安装，执行上面的 `zsh-autosuggestions` 安装命令即可；如果你不想用它，也可以把 `zsh/.zshrc` 里的 `zsh-autosuggestions` 从插件列表里删掉。

### 图标乱码 / 提示符符号不对

优先检查两件事：

- 是否已经安装 `MesloLGS NF`
- Ghostty 是否真的在使用 `MesloLGS NF, PingFang SC`

如果你更想用自己的字体，可以直接改 `ghostty/config.ghostty` 里的 `font-family`。

### `nvm` / `pyenv` / `jenv` / `zoxide` 没装

这些属于当前 shell 配置里预留的开发工具集，不是使用仓库的绝对前置条件。你可以：

- 按需安装它们
- 或者删掉 `zsh/.zshrc` 里不需要的插件项

## 参考

- Homebrew: <https://brew.sh/>
- Ghostty 安装文档: <https://ghostty.org/docs/install/binary>
- Ghostty 配置文档: <https://ghostty.org/docs/config>
- Oh My Zsh: <https://ohmyz.sh/>
- Powerlevel10k: <https://github.com/romkatv/powerlevel10k>
- zsh-autosuggestions: <https://github.com/zsh-users/zsh-autosuggestions>
