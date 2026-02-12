#!/bin/bash

################################################################################
# macOS Claude Code 和 OpenSpec 一键安装脚本
# 
# 功能：
# - 自动安装 Homebrew（如果未安装）
# - 自动安装 Node.js 和 npm（如果未安装）
# - 安装 claude-code 和 openspec-cli
# - 交互式配置 Claude Code 的 API Token 和模型
################################################################################

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

################################################################################
# 日志函数
################################################################################

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

################################################################################
# 工具函数
################################################################################

# 检查命令是否存在
check_command() {
    if ! command -v "$1" &> /dev/null; then
        return 1
    fi
    return 0
}

# 获取当前 shell 的配置文件
get_shell_config_file() {
    local current_shell
    current_shell=$(basename "$SHELL")
    
    case "$current_shell" in
        zsh)
            echo "$HOME/.zshrc"
            ;;
        bash)
            echo "$HOME/.bash_profile"
            ;;
        fish)
            echo "$HOME/.config/fish/config.fish"
            ;;
        *)
            echo ""
            ;;
    esac
}

# 添加 Homebrew 到 PATH 并更新配置文件
add_homebrew_to_path() {
    local shell_config
    local current_shell
    shell_config=$(get_shell_config_file)
    current_shell=$(basename "$SHELL")
    
    local homebrew_path=""
    if [[ -d "/opt/homebrew/bin" ]]; then
        homebrew_path="/opt/homebrew/bin"
    elif [[ -d "/usr/local/bin" ]]; then
        homebrew_path="/usr/local/bin"
    fi
    
    # 添加到当前会话
    if [[ -n "$homebrew_path" ]]; then
        export PATH="$homebrew_path:$PATH"
    fi
    
    # 添加到配置文件
    if [[ -n "$shell_config" && -n "$homebrew_path" ]]; then
        # 检查是否已添加
        if ! grep -q "$homebrew_path" "$shell_config" 2>/dev/null; then
            # 创建配置文件目录（如果不存在）
            mkdir -p "$(dirname "$shell_config")"
            
            # 根据不同的 shell 添加不同的语法
            case "$current_shell" in
                fish)
                    echo "set -gx PATH $homebrew_path \$PATH" >> "$shell_config"
                    ;;
                *)
                    echo "export PATH=\"$homebrew_path:\$PATH\"" >> "$shell_config"
                    ;;
            esac
            log_info "已将 Homebrew 添加到 $shell_config"
            log_info "请运行 'source $shell_config' 或重新打开终端使配置生效"
        else
            log_info "Homebrew 已在 $shell_config 中配置"
        fi
    else
        if [[ -z "$shell_config" ]]; then
            log_warn "无法识别当前 shell ($current_shell)，请手动添加 Homebrew 到 PATH"
        else
            log_warn "未找到 Homebrew 安装路径，请手动添加 Homebrew 到 PATH"
        fi
    fi
}

################################################################################
# 预检查
################################################################################

pre_check() {
    log_step "1. 预检查系统环境"
    
    # 检查操作系统
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "此脚本仅适用于 macOS 系统"
        log_info "当前系统: $OSTYPE"
        exit 1
    fi
    log_info "✓ 操作系统: macOS"
    
    # 检测当前 shell
    current_shell=$(basename "$SHELL")
    shell_config=$(get_shell_config_file)
    log_info "✓ 当前 shell: $current_shell"
    if [[ -n "$shell_config" ]]; then
        log_info "✓ 配置文件: $shell_config"
    else
        log_warn "⚠ 无法识别当前 shell 的配置文件"
    fi
    
    # 检查 Node.js
    if check_command node; then
        node_version=$(node --version)
        log_info "✓ Node.js 已安装: $node_version"
    else
        log_warn "⚠ Node.js 未安装，将通过 Homebrew 安装"
    fi
    
    # 检查 npm
    if check_command npm; then
        npm_version=$(npm --version)
        log_info "✓ npm 已安装: $npm_version"
    else
        log_warn "⚠ npm 未安装，将通过 Homebrew 安装"
    fi
    
    # 检查 Homebrew
    if check_command brew; then
        brew_version=$(brew --version | head -n 1)
        log_info "✓ Homebrew 已安装: $brew_version"
    else
        log_warn "⚠ Homebrew 未安装，将自动安装"
    fi
    
    echo ""
}

################################################################################
# 安装 Homebrew
################################################################################

install_homebrew() {
    if check_command brew; then
        log_info "Homebrew 已安装，跳过安装步骤"
        return 0
    fi
    
    log_step "2. 安装 Homebrew"
    log_warn "未检测到 Homebrew，正在自动安装..."
    
    # 询问用户是否使用国内镜像
    read -p "是否使用国内镜像安装 Homebrew？(推荐，速度更快) [Y/n]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        # 使用国内镜像安装
        log_info "正在使用国内镜像安装 Homebrew..."
        /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    else
        # 使用官方安装脚本
        log_info "正在使用官方脚本安装 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # 添加 Homebrew 到 PATH
    add_homebrew_to_path
    
    # 验证 Homebrew 安装
    if check_command brew; then
        brew_version=$(brew --version | head -n 1)
        log_info "✓ Homebrew 安装成功: $brew_version"
        return 0
    else
        log_error "Homebrew 安装失败"
        log_info "请手动安装 Homebrew: https://brew.sh/"
        exit 1
    fi
}

################################################################################
# 安装 npm（通过 Homebrew 安装 Node.js）
################################################################################

install_npm() {
    if check_command npm; then
        log_info "npm 已安装，跳过安装步骤"
        return 0
    fi
    
    log_step "3. 安装 Node.js 和 npm"
    log_warn "未检测到 npm，正在安装..."
    
    # 安装 Node.js（包含 npm）
    log_info "正在通过 Homebrew 安装 Node.js（包含 npm）..."
    if brew install node; then
        node_version=$(node --version)
        npm_version=$(npm --version)
        log_info "✓ Node.js 安装成功: $node_version"
        log_info "✓ npm 安装成功: $npm_version"
        return 0
    else
        log_error "Node.js 安装失败"
        log_info "请手动安装 Node.js: https://nodejs.org/"
        exit 1
    fi
}

################################################################################
# 安装 claude-code 和 openspec-cli
################################################################################

install_tools() {
    log_step "4. 安装 claude-code 和 openspec-cli"
    
    # 检查并安装 claude-code（带重试机制）
    if check_command claude; then
        claude_version=$(claude --version 2>/dev/null || echo "unknown")
        log_info "✓ claude-code 已安装: $claude_version，跳过安装步骤"
    else
        log_info "正在安装 claude-code..."
        local max_retries=3
        local retry_count=0
        
        while [ $retry_count -lt $max_retries ]; do
            if npm install -g @anthropic-ai/claude-code; then
                log_info "✓ claude-code 安装成功"
                break
            else
                retry_count=$((retry_count + 1))
                if [ $retry_count -lt $max_retries ]; then
                    log_warn "claude-code 安装失败，正在重试 ($retry_count/$max_retries)..."
                    sleep 2
                else
                    log_error "claude-code 安装失败，已达到最大重试次数"
                    exit 1
                fi
            fi
        done
    fi
    
    # 检查并安装 openspec-cli（带重试机制）
    if check_command openspec; then
        openspec_version=$(openspec --version 2>/dev/null || echo "unknown")
        log_info "✓ openspec-cli 已安装: $openspec_version，跳过安装步骤"
    else
        log_info "正在安装 openspec-cli..."
        local max_retries=3
        local retry_count=0
        
        while [ $retry_count -lt $max_retries ]; do
            if npm install -g openspec-cli; then
                log_info "✓ openspec-cli 安装成功"
                break
            else
                retry_count=$((retry_count + 1))
                if [ $retry_count -lt $max_retries ]; then
                    log_warn "openspec-cli 安装失败，正在重试 ($retry_count/$max_retries)..."
                    sleep 2
                else
                    log_error "openspec-cli 安装失败，已达到最大重试次数"
                    exit 1
                fi
            fi
        done
    fi
    
    echo ""
}

################################################################################
# 交互式配置
################################################################################

interactive_config() {
    log_step "5. 配置 Claude Code"
    
    # 收集 API Token
    while true; do
        read -p "请输入您的 Claude API Token: " -r ANTHROPIC_AUTH_TOKEN
        if [[ -n "$ANTHROPIC_AUTH_TOKEN" ]]; then
            break
        else
            log_warn "API Token 不能为空，请重新输入"
        fi
    done
    
    # 收集 API Base URL（带默认值）
    read -p "请输入 API Base URL (默认: https://api.anthropic.com): " -r ANTHROPIC_BASE_URL
    ANTHROPIC_BASE_URL=${ANTHROPIC_BASE_URL:-https://api.anthropic.com}
    
    # 收集模型名称（带默认值）
    echo ""
    log_info "常用模型："
    log_info "  - claude-sonnet-4-20250514 (推荐)"
    log_info "  - claude-3-5-sonnet-20241022"
    log_info "  - claude-3-5-haiku-20241022"
    read -p "请输入模型名称 (默认: claude-sonnet-4-20250514): " -r ANTHROPIC_MODEL
    ANTHROPIC_MODEL=${ANTHROPIC_MODEL:-claude-sonnet-4-20250514}
    
    # 显示配置摘要
    echo ""
    log_info "配置摘要："
    echo "  API Base URL: $ANTHROPIC_BASE_URL"
    echo "  模型: $ANTHROPIC_MODEL"
    echo ""
    
    # 等待用户确认
    read -p "确认以上配置？(Y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        log_warn "配置已取消"
        exit 0
    fi
    
    echo ""
}

################################################################################
# 创建配置文件
################################################################################

create_config_file() {
    local config_file="$HOME/.claude/settings.json"
    local config_content
    
    # 创建 JSON 配置
    config_content=$(cat <<EOF
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "${ANTHROPIC_AUTH_TOKEN}",
    "ANTHROPIC_BASE_URL": "${ANTHROPIC_BASE_URL}",
    "ANTHROPIC_MODEL": "${ANTHROPIC_MODEL}",
    "ANTHROPIC_SMALL_FAST_MODEL": "${ANTHROPIC_MODEL}"
  }
}
EOF
)
    
    log_step "6. 创建配置文件"
    
    if [ -f "$config_file" ]; then
        echo "警告: 配置文件 $config_file 已存在"
        read -p "是否覆盖？: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_warn "跳过配置文件创建"
            return 1
        fi
        # 备份现有配置
        backup_file="$config_file.backup.$(date +%Y%m%d%H%M%S)"
        cp "$config_file" "$backup_file"
        log_info "已备份现有配置到: $backup_file"
    fi
    
    # 创建目录
    mkdir -p "$(dirname "$config_file")"
    
    # 写入配置文件
    echo "$config_content" > "$config_file"
    
    # 设置权限
    chmod 600 "$config_file"
    
    log_info "✓ 配置文件已创建: $config_file"
    log_info "✓ 文件权限已设置为 600"
    
    echo ""
}

################################################################################
# 验证安装
################################################################################

verify_installation() {
    log_step "7. 验证安装"
    
    # 验证 claude 命令
    if check_command claude; then
        claude_version=$(claude --version 2>/dev/null || echo "unknown")
        log_info "✓ claude 命令可用: $claude_version"
    else
        log_error "✗ claude 命令不可用"
        exit 1
    fi
    
    # 验证 openspec 命令
    if check_command openspec; then
        openspec_version=$(openspec --version 2>/dev/null || echo "unknown")
        log_info "✓ openspec 命令可用: $openspec_version"
    else
        log_error "✗ openspec 命令不可用"
        exit 1
    fi
    
    # 验证配置文件
    if [ -f "$HOME/.claude/settings.json" ]; then
        log_info "✓ 配置文件存在: ~/.claude/settings.json"
    else
        log_warn "⚠ 配置文件不存在"
    fi
    
    echo ""
}

################################################################################
# 显示完成信息
################################################################################

show_completion() {
    log_step "8. 安装完成"
    
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ✓ Claude Code 和 OpenSpec 安装成功！${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "后续步骤："
    echo ""
    echo "1. 如果您安装了 Homebrew，请运行以下命令使配置生效："
    if [[ -n "$(get_shell_config_file)" ]]; then
        echo "   source $(get_shell_config_file)"
    fi
    echo "   或重新打开终端"
    echo ""
    echo "2. 启动 Claude Code："
    echo "   claude"
    echo ""
    echo "3. 使用 OpenSpec："
    echo "   openspec list"
    echo ""
    echo "4. 更新配置："
    echo "   编辑 ~/.claude/settings.json"
    echo ""
    echo -e "${YELLOW}提示：${NC}"
    echo "  - 如果遇到问题，请检查网络连接"
    echo "  - 确保您的 API Token 有效"
    echo "  - 查看 README_MACOS.md 获取更多帮助"
    echo ""
}

################################################################################
# 错误处理
################################################################################

error_handler() {
    echo ""
    log_error "脚本执行失败"
    log_info "请检查上面的错误信息"
    log_info "常见问题："
    echo "  1. 网络连接问题 → 检查您的网络或使用代理"
    echo "  2. 权限问题 → 确保您有足够的权限"
    echo "  3. API Token 无效 → 请检查您的 API Token"
    echo ""
    exit 1
}

# 设置错误处理
trap error_handler ERR

################################################################################
# 主函数
################################################################################

main() {
    echo ""
    echo -e "${BLUE}══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  macOS Claude Code 和 OpenSpec 一键安装脚本${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════════════${NC}"
    echo ""
    
    # 执行安装步骤
    pre_check
    install_homebrew
    install_npm
    install_tools
    interactive_config
    create_config_file
    verify_installation
    show_completion
}

# 运行主函数
main "$@"