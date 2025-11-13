
# ⚙️ Mac基础依赖
## Homebrew 包管理工具
1. <a ref="/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"">安装</a>
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
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete
)
#plugins
## auto suggestions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi
## auto suggestions
#plugins
source $ZSH/oh-my-zsh.sh

# 使我配置的别名 配置变量生效
test -f ~/.bash_aliases && source ~/.bash_aliases
# 管道 自动涂色
alias grep=grep --color=auto
```


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