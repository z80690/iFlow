# ============================================
# OpenCode-iFlow 适配配置模板
# 版本: 1.0.0-adapted
# 用途: 在 OpenCode 环境中定义智能体、工作流、MCP 服务器、插件和技能
# 原始来源: iFlow_智能体与工作流提示词模板.md
# ============================================

# 注意: 此文件中所有路径均相对于项目根目录 `.opencode/`

# --- 1. 智能体定义 (OpenCode Schema) ---
# 文件位置: .opencode/agents/

# 智能体: devops-engineer
agent:
  devops-engineer:
    description: |
      专注于 CI/CD、容器化和基础设施管理的智能体。
      能力包括：CI/CD 流水线配置和优化、Docker 容器化部署、Kubernetes 集群管理、基础设施即代码（IaC）、监控和日志管理、自动化部署和回滚。
    model: "anthropic/claude-3-5-sonnet"  # 示例模型，请根据实际情况修改
    prompt: |
      你是一个专业的 DevOps 工程师。你的职责是管理部署流水线、容器编排、云基础设施和系统监控。请以严谨、高效和安全的方式处理所有运维任务。
    tools:
      bash: true
      filesystem-read: true
      filesystem-write: true
      mcp_github: true
      mcp_supabase: true
    # 原 iFlow 模板中的 capabilities, skills, preferences, config 等字段
    # 已整合到上面的 description, prompt 和 tools 中。
    metadata:
      original_capabilities:
        - "CI/CD 流水线配置和优化"
        - "Docker 容器化部署"
        - "Kubernetes 集群管理"
        - "基础设施即代码（IaC）"
        - "监控和日志管理"
        - "自动化部署和回滚"
      original_preferences:
        language: "zh-CN"
        containerRuntime: "docker"
        orchestrationPlatform: "kubernetes"
        ciPlatform: "github-actions"

# 智能体: database-administrator
  database-administrator:
    description: |
      专注于数据库设计、优化和管理的智能体。
      能力包括：数据库设计和建模、SQL 查询优化、数据库性能调优、备份和恢复策略、数据库迁移和升级、数据库安全和权限管理。
    model: "anthropic/claude-3-5-sonnet"
    prompt: |
      你是一个资深的数据库管理员。你的核心工作是设计数据库模式、优化查询性能、确保数据安全与高可用性，并执行数据迁移和备份策略。
    tools:
      bash: true
      filesystem-read: true
      filesystem-write: true
      mcp_supabase: true
    metadata:
      original_capabilities: ["数据库设计和建模", "SQL 查询优化", "数据库性能调优", "备份和恢复策略", "数据库迁移和升级", "数据库安全和权限管理"]
      original_preferences:
        language: "zh-CN"
        databaseType: "postgresql"
        ormFramework: "typeorm"

# 智能体: security-engineer
  security-engineer:
    description: |
      专注于安全审计、漏洞检测和安全加固的智能体。
      能力包括：安全漏洞扫描和检测、安全审计和合规检查、渗透测试、安全加固和防护、安全策略制定、应急响应和事件处理。
    model: "anthropic/claude-3-5-sonnet"
    prompt: |
      你是一名安全工程师。你的任务是识别系统漏洞、执行安全审计、进行渗透测试，并提供加固建议，以保护系统免受攻击。
    tools:
      bash: true
      filesystem-read: true
      mcp_github: true
      web-search: true
    metadata:
      original_capabilities: ["安全漏洞扫描和检测", "安全审计和合规检查", "渗透测试", "安全加固和防护", "安全策略制定", "应急响应和事件处理"]

# --- 2. 工作流定义 (OpenCode Schema) ---
# 文件位置: .opencode/workflows/
# 注意: OpenCode 工作流可能以 YAML 列表或独立文件形式定义。此处以列表格式示例。

workflow:
  - name: deployment-workflow
    description: "标准化的部署流程，从构建到上线"
    triggers: ["manual"]  # OpenCode 可能支持的触发方式
    steps:
      - name: "构建阶段"
        description: "编译和打包应用程序"
        agent: "devops-engineer"
        action: "bash"  # 或更具体的工具调用
        input:
          command: "echo '执行构建任务: 拉取最新代码、安装依赖、运行构建脚本、生成构建产物'"
        output: "dist/{workflow_id}.zip"
      - name: "测试阶段"
        description: "运行自动化测试"
        agent: "database-administrator"  # 注意: 原文档此处为 backend-developer，但您的模板中未定义此智能体。此处沿用原分配逻辑，实际使用时需调整。
        action: "bash"
        input:
          command: "echo '执行测试任务: 运行单元测试、运行集成测试、生成测试报告'"
        output: "reports/test-{workflow_id}.html"
      - name: "安全扫描"
        description: "扫描安全漏洞"
        agent: "security-engineer"
        action: "bash"
        input:
          command: "echo '执行安全任务: 运行依赖漏洞扫描、运行代码安全审计、生成安全报告'"
        output: "reports/security-{workflow_id}.json"
      - name: "部署阶段"
        description: "部署到生产环境"
        agent: "devops-engineer"
        action: "bash"
        input:
          command: "echo '执行部署任务: 备份当前版本、部署新版本、运行健康检查、验证部署成功'"
        output: "logs/deploy-{workflow_id}.log"
    metadata:
      original_type: "sequential"
      original_approval_stages: ["deploy-stage"]

# --- 3. MCP 服务器配置 (OpenCode Schema) ---
# 文件位置: 通常在项目主配置文件 (opencode.json) 或 .opencode/mcp/ 下定义
# 此处以主配置文件内联格式示例
mcp:
  github:
    enabled: true
    config:
      # 密钥应从环境变量读取
      token: "${GITHUB_TOKEN}"
  context7:
    enabled: true
    config:
      api_key: "${CONTEXT7_API_KEY}"
      endpoint: "https://context7.com/api/v1"
  supabase:
    enabled: true
    config:
      url: "${SUPABASE_URL}"
      key: "${SUPABASE_KEY}"
  filesystem:
    enabled: true
    config:
      base_path: "./workspace"
      read_only: false
  web-search:
    enabled: false  # 根据依赖情况设置
    config:
      engine: "google"
      api_key: "${WEB_SEARCH_API_KEY}"

# --- 4. 插件与技能配置 ---
# OpenCode 中，插件和技能可能通过智能体的 `tools` 字段引用，或作为独立的扩展模块配置。
# 此处说明如何映射原 iFlow 插件/技能到 OpenCode 工具。

# 原“代码审查插件” -> 可通过调用外部分析工具 (如 sonarqube) 或集成相应 MCP 实现
# 原“测试生成插件” -> 可通过智能体 prompt 和 bash 工具调用测试框架命令实现
# 原“文档生成插件” -> 可通过智能体调用文档生成工具实现
# 原“IMA技能” -> 需寻找 OpenCode 中对应的笔记管理工具或 MCP

# 建议的配置方式：在智能体 `tools` 中启用相应 MCP，或在 `prompt` 中描述其调用方式。

# --- 5. 使用与验证指南 (适配说明) ---
instructions: |
  ## 如何使用此适配配置
  1.  **智能体**: 将 `agent` 部分的内容合并到你的项目主配置文件 `opencode.json` 的 `agent` 字段下，或保存为独立的 `.yaml` 文件放在 `.opencode/agents/` 目录。
  2.  **工作流**: 将 `workflow` 列表内容保存在 `.opencode/workflows/deployment-workflow.yaml`。
  3.  **MCP**: 将 `mcp` 部分内容合并到 `opencode.json` 的 `mcp` 字段，并确保在 `.env` 文件中设置了对应的环境变量（如 GITHUB_TOKEN）。
  4.  **环境变量**: 在项目根目录创建或更新 `.env` 文件，包含所有 MCP 所需的密钥。
  5.  **验证**: 在项目目录下运行 `opencode` 或 `opencode validate` 命令，检查配置是否正确加载。

  ## 主要变更说明
  - **格式转换**: 从 iFlow 的 JSON 模板转换为 OpenCode 支持的 YAML 格式（JSON 也可）。
  - **字段映射**:
    - `capabilities` & `description` -> 合并到 OpenCode 智能体的 `description` 和 `prompt`。
    - `skills` & `tools` -> 映射到 OpenCode 智能体的 `tools` 列表（需与可用 MCP 工具对应）。
    - `config` & `preferences` -> 部分融入 `description`/`prompt`，部分作为 `metadata` 保留。
  - **工作流重构**: 将 iFlow 的 `stages` 转换为 OpenCode 的 `steps`，`agent` 字段指向已定义的智能体名。
  - **路径调整**: 所有配置文件预设路径从 `.iflow/` 改为 `.opencode/`。

  ## 注意事项
  - 此模板为功能等效适配，具体可用性取决于您的 OpenCode 版本、已安装的 MCP 服务器和模型。
  - 需要根据实际情况调整 `model` 字段和 `tools` 列表。
  - 复杂的插件功能可能需要自行开发相应的 OpenCode 工具或 MCP 来完整实现。

# 文件结束