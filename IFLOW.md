# iFlow CLI 项目文档

## 项目概述

**项目名称**: dev-environment-init  
**项目类型**: 跨平台开发环境初始化工具  
**支持平台**: macOS、Linux、Windows  

本项目是一个全面的开发环境初始化指南和配置集合，帮助开发者在不同操作系统上快速搭建高效的开发环境。项目包含详细的配置文档、OpenSpec 规范管理以及 iFlow CLI 集成。

## 项目结构

```
dev-environment-init/
├── README.md                    # 项目主文档
├── README_MACOS.md             # macOS 开发环境配置指南
├── README_LINUX.md             # Linux 开发环境配置指南
├── README_WINDOWS.md           # Windows 开发环境配置指南
├── IFLOW.md                    # iFlow CLI 项目文档（本文件）
├── AGENTS.md                   # AI 助手指南
├── CLAUDE.md                   # Claude AI 配置
├── .claude/                    # Claude AI 命令配置
│   └── commands/
│       └── openspec/           # OpenSpec 相关命令
│           ├── proposal.md     # 变更提案命令
│           ├── apply.md        # 变更应用命令
│           └── archive.md      # 变更归档命令
├── .iflow/                     # iFlow CLI 配置
│   └── commands/
│       ├── openspec-proposal.md
│       ├── openspec-apply.md
│       └── openspec-archive.md
├── openspec/                   # OpenSpec 规范管理
│   ├── AGENTS.md               # OpenSpec AI 助手指南
│   ├── project.md              # 项目上下文和约定
│   ├── specs/                  # 当前规范（已实现）
│   └── changes/                # 变更提案（待实现）
│       └── archive/            # 已归档的变更
└── img/                        # 项目图片资源
    └── iterm2/                 # iTerm2 配置截图
        ├── key bindings.png
        ├── keys.png
        └── preferences.png
```

## 核心功能

### 1. 跨平台开发环境配置

#### macOS 开发环境
- **包管理**: Homebrew（含国内镜像配置）
- **终端**: iTerm2 + zsh + oh-my-zsh
- **常用工具**: bat、eza、glances、htop、jq、tree、wget 等
- **Python**: Python + uv（现代 Python 包管理工具）
- **Node.js**: nvm + npm（含国内镜像配置）
- **版本控制**: Git
- **AI 编程工具**:
  - gemini-cli（Google AI）
  - claude-code（Anthropic AI）
  - codex（OpenAI）
  - opencode
- **MCP 服务器**: Model Context Protocol 支持

#### Windows 开发环境
- **终端**: PowerShell + Windows Terminal + oh-my-posh
- **子系统**: WSL2（Windows Subsystem for Linux）
- **Python**: Python + uv + Miniconda
- **Node.js**: nvm-windows + npm
- **其他工具**: Git、Java、MinGW
- **AI 编程工具**: 与 macOS 相同的 AI 工具配置

#### Linux 开发环境
- 文档结构已预留，待补充具体配置指南

### 2. OpenSpec 规范管理

项目集成了 OpenSpec 框架，用于规范驱动的开发流程：

#### OpenSpec 工作流
1. **创建变更 (Creating Changes)**
   - 为新功能、重大变更、架构调整创建提案
   - 使用 `/openspec-proposal` 命令启动
   - 包含 proposal.md、tasks.md、design.md 和规范变更

2. **实施变更 (Implementing Changes)**
   - 按照批准的提案实施变更
   - 使用 `/openspec-apply` 命令启动
   - 逐步完成任务清单

3. **归档变更 (Archiving Changes)**
   - 部署后归档完成的变更
   - 使用 `/openspec-archive` 命令启动
   - 更新主规范文档

#### OpenSpec 命令
```bash
# 列出活跃的变更
openspec list

# 列出所有规范
openspec list --specs

# 查看变更或规范详情
openspec show [item]

# 验证变更或规范
openspec validate [item] --strict

# 归档变更
openspec archive <change-id> [--yes|-y]

# 更新指令文件
openspec update [path]
```

### 3. iFlow CLI 集成

项目配置了 iFlow CLI 命令，支持 OpenSpec 工作流：

- `/openspec-proposal`: 创建新的 OpenSpec 变更提案
- `/openspec-apply`: 实施已批准的变更
- `/openspec-archive`: 归档已部署的变更

## 技术栈

### 核心技术
- **包管理**: Homebrew (macOS)、npm、pip、uv
- **终端工具**: zsh、oh-my-zsh、iTerm2、PowerShell、Windows Terminal
- **编程语言**: Python、Node.js、Java
- **版本控制**: Git
- **规范管理**: OpenSpec

### AI 编程工具
- **gemini-cli**: Google Gemini AI 命令行工具
- **claude-code**: Anthropic Claude AI 编程助手
- **codex**: OpenAI Codex 代码生成工具
- **opencode**: OpenCode AI 编程平台

### Python 生态
- **uv**: 现代 Python 包管理工具（替代 pip）
- **虚拟环境**: Python venv、Conda
- **常用包**: FastAPI、Uvicorn、LangChain、BeautifulSoup4

## 开发约定

### 代码风格
- 遵循各语言和框架的最佳实践
- 使用现代化的工具和库（如 uv 替代 pip）
- 优先使用简洁、直接的实现

### 文档规范
- 使用 Markdown 格式
- 提供清晰的步骤说明
- 包含必要的截图和示例代码
- 支持跨平台配置

### Git 工作流
- 使用语义化提交信息
- 分支策略待定义（参考 openspec/project.md）
- 变更提案先于代码实现

## 重要配置

### 国内镜像源配置

#### Homebrew (macOS)
```bash
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
```

#### npm
```bash
npm config set registry https://registry.npmmirror.com
```

#### pip/uv
```bash
# 清华源
export UV_DEFAULT_INDEX="https://pypi.tuna.tsinghua.edu.cn/simple"
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple --user
```

### AI 工具配置

#### Claude Code
配置文件: `~/.claude/settings.json`
```json
{
    "env": {
        "ANTHROPIC_AUTH_TOKEN": "${API_TOKEN}",
        "ANTHROPIC_BASE_URL": "${API_BASE_URL}",
        "ANTHROPIC_MODEL": "${MODEL_NAME}",
        "ANTHROPIC_SMALL_FAST_MODEL": "${MODEL_NAME}"
    }
}
```

#### MCP 服务器
全局配置: `~/.claude.json`
项目配置: `{project_dir}/.mcp.json`

## 常用命令

### macOS 环境设置
```bash
# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装 iTerm2
brew install --cask iterm2

# 安装 zsh 和 oh-my-zsh
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装 uv
pip install uv
export UV_DEFAULT_INDEX="https://pypi.tuna.tsinghua.edu.cn/simple"

# 安装 gemini-cli
npm install -g @google/gemini-cli
export GOOGLE_CLOUD_PROJECT="${API_KEY}"

# 安装 claude-code
npm install -g @anthropic-ai/claude-code
```

### Python 项目初始化
```bash
# 使用 uv 初始化项目
uv init

# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
source venv/bin/activate  # macOS/Linux
.\venv\Scripts\activate   # Windows

# 安装依赖
uv sync
```

### OpenSpec 工作流
```bash
# 查看当前状态
openspec list
openspec list --specs

# 创建变更提案
/openspec-proposal

# 实施变更
/openspec-apply

# 归档变更
/openspec-archive
```

## 项目维护

### 待完善项
- [ ] 完善 README_LINUX.md 的 Linux 环境配置指南
- [ ] 定义 Git 分支策略和提交规范
- [ ] 完善 openspec/project.md 的项目约定
- [ ] 添加自动化测试和 CI/CD 配置
- [ ] 创建贡献指南

### 已知限制
- Linux 平台的配置指南尚未完善
- 项目约定和规范需要进一步细化
- 缺少自动化测试和持续集成

## 相关资源

### 官方文档
- [OpenSpec 规范](openspec/AGENTS.md)
- [项目上下文](openspec/project.md)

### 外部链接
- [Homebrew](https://brew.sh/)
- [Oh My Zsh](https://ohmyz.sh/)
- [uv (Python 包管理)](https://github.com/astral-sh/uv)
- [nvm (Node 版本管理)](https://github.com/nvm-sh/nvm)
- [Claude Code](https://claude.ai/code)
- [Model Context Protocol](https://modelcontextprotocol.io/)

## 贡献指南

欢迎贡献！请遵循以下步骤：

1. 使用 OpenSpec 工作流创建变更提案
2. 确保提案通过严格验证
3. 实施变更并更新相关文档
4. 部署后归档变更

## 许可证

待定义

---

**最后更新**: 2026-02-10
**维护者**: iFlow CLI