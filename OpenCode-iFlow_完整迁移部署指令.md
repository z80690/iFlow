# 指令名称：OpenCode-iFlow 完整迁移与测试指令
# 保存为：OpenCode_iFlow_Migration_Instructions.md
# 目标：将 iFlow 模板完整迁移至 OpenCode 1.2.25 项目，并生成测试报告。

## 一、输入与约束
- 输入文件：`iFlow_智能体与工作流提示词模板.md`（项目根目录下）。
- 项目路径：`C:\Users\Administrator\Desktop\iFlow_逆向工程_迁移项目`。
- 目标骨架：已存在的 `.opencode/` 目录及其子目录（agents, workflows, mcp, plugins, skills）。
- 主配置：项目根目录下的 `opencode.json` 文件。
- 环境变量：项目根目录下的 `.env` 文件。
- 核心约束：禁止删减 iFlow 模板中的任何功能定义，仅做格式转换以适配 OpenCode 1.2.25。

## 二、执行步骤（必须按序执行）

### 步骤1：解析源模板
读取并解析 `iFlow_智能体与工作流提示词模板.md` 文件，提取以下全部JSON定义：
1. 智能体（3个）：`devops-engineer`、`database-administrator`、`security-engineer` 的完整定义。
2. 工作流（1个）：`deployment-workflow` 的完整定义。
3. MCP服务器（5个）：GitHub, Context7, Supabase, Filesystem, Web-Search 的定义。
4. 插件（5个）：代码审查、测试生成、文档生成、安全扫描、性能优化的定义。
5. 技能（4个）：代码审查、文档生成、测试生成、IMA（腾讯文档）的定义。

### 步骤2：格式转换（适配OpenCode）
将步骤1提取的iFlow格式定义，一对一转换为OpenCode 1.2.25支持的配置格式。转换包括：
- 将iFlow智能体的字段映射到OpenCode智能体的 `description`、`prompt`、`tools` 字段。
- 将iFlow工作流的 `stages` 映射为OpenCode工作流的 `steps`，确保 `agent` 引用转换后的智能体名。
- 为每个MCP、插件、技能创建独立的、符合OpenCode Schema的配置文件（YAML或JSON）。

### 步骤3：生成配置文件
将步骤2转换后的配置，写入到 `.opencode/` 目录的对应位置：
- 智能体：`.opencode/agents/devops-engineer.yaml`，`database-administrator.yaml`，`security-engineer.yaml`。
- 工作流：`.opencode/workflows/deployment-workflow.yaml`。
- MCP：在 `.opencode/mcp/` 下为每个MCP创建配置文件（如 `github.yaml`），并从 `.env` 文件读取并填入对应环境变量（如 `GITHUB_TOKEN`）。
- 插件：在 `.opencode/plugins/` 下为每个插件创建配置文件。
- 技能：在 `.opencode/skills/` 下为每个技能创建配置文件。

### 步骤4：配置主文件
编辑项目根目录下的 `opencode.json` 文件。其内容必须正确引用以上生成的所有文件，并设置默认工作流。参考结构如下（请根据实际生成的文件名和路径填充）：
{
  "$schema": "https://opencode.ai/config.json",
  "agent": {
    // 此处应正确引用 .opencode/agents/ 下的三个智能体定义
  },
  "workflows": {
    "paths": [".opencode/workflows"],
    "default": "deployment-workflow"
  },
  "mcp": {
    // 此处应启用并配置在 .opencode/mcp/ 下定义的所有MCP服务器
  },
  "plugins": {
    "paths": [".opencode/plugins"]
  },
  "skills": {
    "paths": [".opencode/skills"]
  }
}

### 步骤5：启动与功能测试
1. 启动验证：在项目目录执行 `opencode` 命令。必须成功启动，无配置错误。
2. 工作流测试：触发 `deployment-workflow`，验证其能否按阶段执行并调用正确的智能体。
3. 组件测试：逐一测试每个MCP的连接、每个插件的功能、每个技能的调用。

### 步骤6：生成最终报告
在桌面生成Markdown报告：`iFlow_to_OpenCode_Migration_Report_YYYYMMDD.md`。报告必须包含：
1. 任务概述。
2. 生成的所有配置文件清单。
3. 对 `opencode.json` 的修改详情。
4. 步骤5的详细测试记录（命令、输出、现象）。
5. 遇到的所有问题及解决方案。
6. 迁移结论（成功/失败，各组件状态）。

## 三、最终交付物
1. 配置完整的 `.opencode/` 目录。
2. 修改后的 `opencode.json` 文件。
3. 桌面测试报告文件。

**请立即开始严格执行上述所有步骤。**