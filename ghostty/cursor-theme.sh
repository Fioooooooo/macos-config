#!/usr/bin/env bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLAZE="$SCRIPT_DIR/shaders/cursor_blaze_no_trail.glsl"
SMEAR="$SCRIPT_DIR/shaders/cursor_smear.glsl"

THEME_ORDER=(blue green rose amber)

get_theme_info() {
  # 设置 THEME_NAME 和 THEME_LETTER，避免 $() 子进程丢失中文编码
  case "$1" in
    blue)  THEME_NAME="冰蓝极光"; THEME_LETTER="A" ;;
    green) THEME_NAME="翡翠绿";   THEME_LETTER="B" ;;
    rose)  THEME_NAME="玫瑰金";   THEME_LETTER="C" ;;
    amber) THEME_NAME="琥珀火";   THEME_LETTER="D" ;;
    *)     THEME_NAME="";         THEME_LETTER=""  ;;
  esac
}

list_themes() {
  echo "可用主题:"
  for key in "${THEME_ORDER[@]}"; do
    get_theme_info "$key"
    echo "  $key: $THEME_NAME"
  done
}

switch_theme() {
  local theme="$1"
  get_theme_info "$theme"

  if [[ -z "$THEME_NAME" ]]; then
    echo "错误: 未知主题 '$theme'" >&2
    echo "运行 --list 查看可用主题" >&2
    exit 1
  fi

  for file in "$BLAZE" "$SMEAR"; do
    # 注释掉所有已启用的 const vec4 行
    sed -i '' 's/^const vec4 TRAIL_COLOR /\/\/ const vec4 TRAIL_COLOR /' "$file"
    sed -i '' 's/^const vec4 TRAIL_COLOR_ACCENT /\/\/ const vec4 TRAIL_COLOR_ACCENT /' "$file"

    # 取消目标主题的注释（匹配字母标签后的下一行）
    sed -i '' "/\/\/ $THEME_LETTER: /{
      n
      s|^// \(const vec4 TRAIL_COLOR [^A].*\)|\1|
    }" "$file"
    sed -i '' "/\/\/ $THEME_LETTER: /{
      n
      n
      s|^// \(const vec4 TRAIL_COLOR_ACCENT .*\)|\1|
    }" "$file"
  done

  printf "已切换到: %s（%s）\n" "$THEME_NAME" "$theme"
  printf "重载配置（⌘+Shift+,）或重启 Ghostty 后生效\n"
}

usage() {
  cat <<EOF
用法:
  cursor-theme.sh --list          列出所有可用主题
  cursor-theme.sh --theme=<名称>  切换到指定主题
  cursor-theme.sh --help          显示帮助

可用主题: blue, green, rose, amber
EOF
}

case "$1" in
  --list)
    list_themes
    ;;
  --theme=*)
    switch_theme "${1#--theme=}"
    ;;
  --help|"")
    usage
    ;;
  *)
    echo "错误: 未知参数 '$1'" >&2
    usage
    exit 1
    ;;
esac
