# MacOS 常用配置

## zsh

### 1. Homebrew

参考 https://gitee.com/cunkai/HomebrewCN 进行配置，国内用户可以切换镜像源，以提升安装和更新 Homebrew 的速度。

### 2. p10k

安装并配置 p10k 主题，内置了大量 zsh 的优化，可定制性高：https://github.com/romkatv/powerlevel10k

配置文件可参照 `zsh/.p10k.zsh`

## Ghostty

安装 ghostty 后，创建 symlink 即可使用（已经与 p10k 主题做了集成）

```shell
ln -s /path/to/this/ghostty ~/.config/ghostty
```
