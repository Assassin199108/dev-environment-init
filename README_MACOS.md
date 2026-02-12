
# ⚙️ Mac基础依赖
## Homebrew 包管理工具
1. <a ref="/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"">安装</a>(如果 安装不了 直接通过​/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)" 国内镜像安装)
2. 配置镜像 
```# brew设置清华镜像源：
echo '# brew设置清华镜像源：\nexport HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"\nexport HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"\nexport HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"\nexport HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"\nexport HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"\n# brew设置清华镜像源\n' >> ~/.zshrc
```
3. homebrew 禁用自动升级   export HOMEBREW_NO_AUTO_UPDATE=1
4. homebrew 设置bin 
```
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
```
5. homebrew 安装旧版本依赖-例如maven3.2.1
```
用 Homebrew 从历史提取旧版公式
新建自有 tap 并提取指定版本
1. brew tap-new $USER/old-maven
2. brew extract --version=3.2.1 maven $USER/old-maven
3. brew install $USER/old-maven/maven@3.2.1
4. 若 --version 未命中，可按历史提交提取：
    a. 找到 homebrew-core(https://formulae.brew.sh/ 搜索maven 进入github，查看历史，找到3.2.5版本) 中旧版maven的提交 SHA 后执行：brew extract maven $USER/old-maven --revision=<commit sha>;然后brew install $USER/old-maven/maven@3.2.1
5. 删除自建的tap
    a. brew untap ${tap}
```

## 安装term2
brew install --cask iterm2
iTerm2 主题设置
1. 修改默认本机主题
![主题](img/iterm2/preferences.png)
2. 唤醒iterm2设置
![唤醒](img/iterm2/keys.png)
3. 自定义快捷键
    * 入口
    ![入口](img/iterm2/key%20bindings.png)
    * new Tab with "Default" Profile  command+n

## zsh + oh my zsh
* brew install zsh
* curl
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
* 配置zshrc文件
```
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/wangwei/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)

# ===== 补全配置（必须在 oh-my-zsh 之前）=====
# zsh配置
# --- 补全样式设置 ---
zmodload zsh/complist
# 开启菜单选择模式
zstyle ':completion:*' menu select
# 其他有用的补全设置
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-zA-Z}={A-Za-z}' 'r:|=? m:{a-zA-Z}={A-Za-z}'
# 禁用补全不到的哔哔声
# setopt NO_BEEP
# --- 关键：解决询问问题 ---
setopt AUTO_LIST
# 补全到 命令行，并同时立即弹出候选列表
setopt NO_LIST_AMBIGUOUS
export LISTMAX=0

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git zsh-syntax-highlighting zsh-autosuggestions
)
# zsh-autocomplete：这个插件会自动在后台运行 ls 或补全查询。当你输入 c 时，它会瞬间找到系统中成百上千个以 c 开头的命令。
# 暂时关闭这个插件
source $ZSH/oh-my-zsh.sh

# 修正 autosuggestions 的颜色（如果颜色太亮看不清）
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# 使我配置的别名 配置变量生效
test -f ~/.bash_aliases && source ~/.bash_aliases
# homebrew 禁用自动升级
export HOMEBREW_NO_AUTO_UPDATE=1
# 管道 自动涂色
alias grep=grep --color=auto

# 命令行bin导入
export PATH="/usr/local/sbin:$PATH"

# python uv默认使用python版本
export UV_PYTHON=3.13.4

# alias
alias ll='eza -abghHliS'

# HomeBrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
# HomeBrew
```

### 🔧 我最常用的第三方包
* bat
    * cat命令增强版本
* eza
    * ls命令增加器
* glances、htop
    * top命令增强器
* jq
    * 命令行json处理器
* jsonpp
    * 命令行 JSON 格式化打印器
* telnet
    * 远端登入
* tldr
    * 快速查阅命令 too long don't read
* tree
    * 谁用谁知道
* wget
    * 单线程下载
* xz
    * 压缩命令行
* zsh
    * 终端命令行解释器
* zsh-completions
    * zsh终端命令补全脚本
* zsh-syntax-highlighting
    * 命令预发校验插件
* alfred
    * 最好用的查找器
    * 安装方式brew install alfred --cask

## 安装uv
什么是uv： python包管理
```
1. 安装uv 
pip install uv
MacOs
# 清华源
echo 'export UV_DEFAULT_INDEX="https://pypi.tuna.tsinghua.edu.cn/simple"'>> ~/.zshrc
# 阿里源
# echo 'export UV_DEFAULT_INDEX="https://mirrors.aliyun.com/pypi/simple/"' >> ~/.zshrc
```
初始化项目：uv init
uv项目安装依赖：uv sync

### uv项目开始
### 创建激活虚拟环境
```
1.创建虚拟环境
python -m venv venv
2.激活虚拟环境
windows
.\venv\Scripts\activate
macOs
source venv/bin/activate
3.退出虚拟环境
deactivate
```
## 安装python
1. 通过uv安装 uv python install ${版本}
2. 通过homebrew安装 brew install python@版本
3. 通过npm安装 npm install -g python@版本
4. 配置pip源
```
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple --user
pip config set global.proxy http://127.0.0.1:<端口号> --user
```

## 安装git
1. 通过homebrew安装 brew install git
2. 配置git信息
```
git config --global user.email xxx
git config --global user.name xxx
```

## 安装nvm
1. 通过homebrew安装 brew install nvm

## 安装node
1. 通过nvm安装node nvm install 8.0.0
2. npm 换源
```
npm config set registry https://registry.npmmirror.com
```
3. node设置本地三方依赖仓库路径
```
npm config set prefix ${path}
```
4. 常用的三方依赖
```
@anthropic-ai/claude-code
@google/gemini-cli
@musistudio/claude-code-router
@openai/codex
@modelcontextprotocol/inspector
```
5. 可通过npx运行服务，例如npx @modelcontextprotocol/inspector uv run python_tool/project_mcp/dag/dag_manage_mcp.py


# 🚀 快速安装

## 一键安装 Claude Code 和 OpenSpec

本项目提供了一个自动化安装脚本，可以快速在 macOS 上安装和配置 Claude Code 和 OpenSpec。

### 使用方法

```bash
# 运行安装脚本
./scripts/install-macos-cc-openspec.sh
```

### 脚本功能

- ✅ 自动安装 Homebrew（如果未安装）
- ✅ 自动安装 Node.js 和 npm（如果未安装）
- ✅ 自动安装 claude-code 和 openspec-cli
- ✅ 交互式配置 Claude Code 的 API Token 和模型
- ✅ 支持国内镜像（Homebrew）
- ✅ 自动检测并适配用户使用的 shell（zsh/bash/fish）
- ✅ 配置文件自动备份

### 安装前准备

确保您有以下信息：

1. **Claude API Token** - 从 [Anthropic Console](https://console.anthropic.com/) 获取
2. **网络连接** - 确保可以访问互联网（或使用代理）

### 安装步骤

1. 克隆或下载本项目
2. 运行安装脚本
3. 按照提示输入 API Token 和模型信息
4. 等待安装完成

### 验证安装

```bash
# 验证 Claude Code
claude --version

# 验证 OpenSpec
openspec list

# 启动 Claude Code
claude
```

### 手动配置（备选方案）

如果您更喜欢手动配置，请参考下方的"Vibe Coding"章节。

---

# 🚀 Vibe Coding
## gemini-cli
1. 通过npm 安装gemini: npm install -g @google/gemini-cli
2. <a ref="https://aistudio.google.com/api-keys">google</a> 申请API KEY
3. 配置API Key，vim ~/.zshrc , export GOOGLE_CLOUD_PROJECT="${API KEY}"
4. 终端启动 gemini

## codex
1. 通过npm 安装codex: npm install -g @openai/codex
2. 通过配置文件配置模型和地址，配置文件路径为~/.codex/config.toml，配置文件如下
```
# Set the default model and provider
model = "GLM-4.6"
model_provider = "test"

# Configure the your provider
[model_providers.test]
name = "test"
# Make sure you set the appropriate subdomain for this URL.
base_url = "${可以设置openrouter地址等}"
env_key = "${环境变量Token的Key}"
wire_api = "chat"
```
3. 终端启动 codex

## claude code
1. 通过npm 安装claude code: npm install -g @anthropic-ai/claude-code
2. 通过配置文件配置模型和地址，配置文件路径为~/.claude/settings.json，配置文件如下
```
{
    "env": {
        "ANTHROPIC_AUTH_TOKEN": "${api访问的token}",
        "ANTHROPIC_BASE_URL": "${API模型访问地址，可以是openrouter}$",
        "ANTHROPIC_MODEL": "GLM-4.5",
        "ANTHROPIC_SMALL_FAST_MODEL": "GLM-4.5"
    }
}
```
3.添加全局mcp server配置，配置文件路径为~/.claude.json,配置文件如下
```
{
    "mcpServers": {
        "pokemon": {
            "disable": false,
            "timeout": 60,
            "command": "uv",
            "args": [
                    "--directory", 
                    "~/project/personel/pokemon_mcp", 
                    "run", 
                    "pokemon_mcp.py"
                ],
            "env": {}
        }
    }
}
```
4.添加项目维度mcp server配置，配置文件路径为{{project_dir}}/.mcp.json
```
{
  "mcpServers": {
    "evo.rec.dag.manage": {
      "command": "uv",
      "args": [
        "--directory",
        "./project_mcp/dag",
        "--isolated",
        "run",
        "dag_manage_mcp.py"
      ]
    }
  }
}
```
5.功能拓展
```
输出样式：/output-style：可选择默认、解释型人格、学习
think模式：think hard/think more/think a lot/think longer/think/ultrathink

```
## opencode
1.通过npm 安装open code: npm install -g opencode-ai
2.通过npm 按照oh-my-opencode: npm install -g oh-my-opencod
3.配置opencode信息及API KEY
- 配置opencode信息: vim ~/.config/opencode/opencode.json
    - 可配置模型、权限、agents
    - 具体可参考官方文档 https://opencode.ai/docs/models/
- 配置opencode API KEY: vim ~/.local/share/opencode/auth.json格式如下
```
{
  "{{具体模型提供方 例如openrouter}}": {
    "type": "api",
    "key": "{{API_KEY}}"
  }
}
```
- 配置oh-my-opencode信息: vim ~/.config/opencode/oh-my-opencode.json
    - 配置信息可参考官网

## mcp server
通过mcp dev {{具体mcp server}}可以测试mcp 连接


## openspec
通过npm -g install @fission-ai/openspec下载openspec
- 进入对应项目路径
- 运行openspec init 初始化openspec能力
- 选择你运行的AI Coding Agent
- Copy下面Prompt到AI Coding Agent对话窗口
```
1. Populate your project context:
   "Please read openspec/project.md and help me fill it out
    with details about my project, tech stack, and conventions"

2. Create your first change proposal:
   "I want to add [YOUR FEATURE HERE]. Please create an
    OpenSpec change proposal for this feature"

3. Learn the OpenSpec workflow:
   "Please explain the OpenSpec workflow from openspec/AGENTS.md
    and how I should work with you on this project"
```
- 后续即可使用


---

# ❓ 常见问题解答 (FAQ)

## 快速安装相关问题

### Q1: 如何获取 Claude API Token？

**A:** 访问 [Anthropic Console](https://console.anthropic.com/)，登录或注册账号，然后在 API Keys 部分创建新的 API Token。

### Q2: 如何选择合适的模型？

**A:** 推荐使用以下模型：
- **claude-sonnet-4-20250514** - 最新版本，性能最佳（推荐）
- **claude-3-5-sonnet-20241022** - 稳定版本
- **claude-3-5-haiku-20241022** - 快速响应，适合简单任务

### Q3: 安装失败怎么办？

**A:** 常见问题和解决方案：

1. **网络问题**
   - 检查网络连接
   - 考虑使用代理
   - 选择国内镜像安装 Homebrew

2. **权限问题**
   - 确保您有足够的权限
   - 尝试使用 sudo（不推荐）

3. **Homebrew 安装失败**
   - 尝试使用国内镜像
   - 手动安装 Homebrew: https://brew.sh/

4. **npm 安装失败**
   - 检查 npm 源配置
   - 尝试使用国内镜像: `npm config set registry https://registry.npmmirror.com`

### Q4: 如何更新配置？

**A:** 编辑配置文件：
```bash
# 编辑 Claude Code 配置
vim ~/.claude/settings.json

# 修改后重新启动 Claude Code
claude
```

### Q5: 如何卸载？

**A:** 手动卸载步骤：

```bash
# 卸载 claude-code
npm uninstall -g @anthropic-ai/claude-code

# 卸载 openspec-cli
npm uninstall -g openspec-cli

# 删除配置文件
rm -rf ~/.claude

# （可选）卸载 Node.js 和 Homebrew
# 注意：这可能会影响其他依赖 Node.js 的应用
```

### Q6: 脚本支持哪些 shell？

**A:** 脚本支持以下 shell：
- **zsh** - macOS Catalina 及以后默认
- **bash** - 旧版本 macOS 默认
- **fish** - 现代化 shell
- **其他** - 会提示手动配置

脚本会自动检测您使用的 shell，并将 Homebrew 添加到对应的配置文件。

### Q7: 安装后需要做什么？

**A:** 安装完成后：

1. **使配置生效**
   ```bash
   # 如果您安装了 Homebrew
   source ~/.zshrc  # 或 ~/.bash_profile，取决于您的 shell
   # 或重新打开终端
   ```

2. **验证安装**
   ```bash
   claude --version
   openspec list
   ```

3. **开始使用**
   ```bash
   claude
   ```

### Q8: 配置文件在哪里？

**A:** 配置文件位置：
- **Claude Code 配置**: `~/.claude/settings.json`
- **Claude MCP 配置**: `~/.claude.json`
- **项目 MCP 配置**: `{project_dir}/.mcp.json`

### Q9: 如何使用国内镜像？

**A:** 脚本在安装 Homebrew 时会询问是否使用国内镜像，选择 "Y" 即可。

对于 npm，可以手动配置：
```bash
npm config set registry https://registry.npmmirror.com
```

### Q10: 脚本会覆盖现有配置吗？

**A:** 脚本会：
- 检测配置文件是否已存在
- 如果存在，提示您选择覆盖或跳过
- 如果选择覆盖，会自动备份现有配置

### Q11: 如何配置 MCP 服务器？

**A:** MCP 服务器配置需要手动添加：

1. **全局 MCP 配置** (`~/.claude.json`):
```json
{
  "mcpServers": {
    "your-server-name": {
      "command": "uv",
      "args": ["--directory", "/path/to/your/mcp", "run", "server.py"]
    }
  }
}
```

2. **项目 MCP 配置** (`{project_dir}/.mcp.json`):
```json
{
  "mcpServers": {
    "your-server-name": {
      "command": "uv",
      "args": ["--directory", "./project_mcp", "run", "server.py"]
    }
  }
}
```

### Q12: 安装过程中遇到错误怎么办？

**A:** 请查看错误信息，常见错误：

1. **"command not found"** - 命令未找到
   - 确保已正确安装依赖
   - 检查 PATH 配置

2. **"Permission denied"** - 权限被拒绝
   - 检查文件权限
   - 确保有足够的权限

3. **"Network error"** - 网络错误
   - 检查网络连接
   - 尝试使用代理

4. **"API Token invalid"** - API Token 无效
   - 检查 API Token 是否正确
   - 确认 Token 未过期

### Q13: 如何获取帮助？

**A:** 获取帮助的方式：
- 查看本文档
- 查看 Claude Code 官方文档
- 查看 OpenSpec 官方文档
- 在项目仓库提交 Issue

---

**提示**: 如果您遇到其他问题，请查看项目的 GitHub Issues 或提交新的 Issue。