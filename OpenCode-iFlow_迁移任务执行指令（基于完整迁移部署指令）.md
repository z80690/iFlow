# 任务：执行 iFlow 到 OpenCode 的完整迁移与测试

## 核心目标
请严格按照位于项目根目录 `C:\Users\Administrator\Desktop\iFlow_逆向工程_迁移项目\OpenCode-iFlow_完整迁移部署指令.md` 文件（下称“主指令文件”）中的全部要求，完成 iFlow 智能体系统向 OpenCode 环境的完整迁移、部署、测试，并生成一份详细的桌面报告。

## 具体步骤（严格遵循主指令文件执行）

### 第一步：读取与解析
1.  **读取**：请先完整阅读并理解上述路径下的“主指令文件”。
2.  **解析**：明确你需要从文件 `iFlow_智能体与工作流提示词模板.md` 中提取的所有核心组件定义，包括：
    *   3个智能体 (`devops-engineer`, `database-administrator`, `security-engineer`) 的完整JSON定义。
    *   1个工作流 (`deployment-workflow`) 的完整JSON定义。
    *   5个MCP服务器 (GitHub, Context7, Supabase, Filesystem, Web-Search) 的功能描述和配置项。
    *   5个插件 (代码审查、测试生成、文档生成、安全扫描、性能优化) 的功能描述。
    *   4个技能 (代码审查、文档生成、测试生成、IMA) 的功能描述。

### 第二步：执行迁移与配置（主指令文件第2-5步）
3.  **格式转换**：将第一步提取的iFlow格式定义，转换为OpenCode 1.2.25支持的配置格式（参考OpenCode官方Schema）。
4.  **生成配置文件**：在项目目录的 `.opencode/` 下创建对应子目录，并将转换后的配置写入以下路径：
    *   `.opencode/agents/` （智能体YAML文件）
    *   `.opencode/workflows/` （工作流YAML文件）
    *   `.opencode/mcp/` （MCP服务器配置文件，需从`.env`读取密钥）
    *   `.opencode/plugins/` （插件配置文件）
    *   `.opencode/skills/` （技能配置文件）
5.  **配置主文件**：修改项目根目录的 `opencode.json` 文件，确保其正确引用以上生成的配置文件，并将 `deployment-workflow` 设为默认工作流。
6.  **启动与测试**：
    *   在项目目录下执行 `opencode` 命令，验证配置可正常启动。
    *   触发 `deployment-workflow` 工作流，验证其执行流程和智能体调用。
    *   逐一测试各MCP服务器、插件、技能的核心功能。

### 第三步：生成桌面报告
7.  **编写报告**：在桌面生成一份名为 `iFlow_to_OpenCode_Migration_Report_YYYYMMDD.md` 的Markdown格式报告。报告必须包含以下章节：
    *   **1. 任务概述**：复述本任务目标及依据的主指令文件。
    *   **2. 配置文件生成清单**：列出所有在 `.opencode/` 目录下生成的文件及其路径。
    *   **3. 主配置修改记录**：展示对 `opencode.json` 文件的具体修改内容（建议使用diff格式或前后对比）。
    *   **4. 测试过程与结果**：详细记录第六步中每一项测试的执行命令、控制台输出、成功/失败现象及错误信息。
    *   **5. 问题与解决方案**：列出执行过程中遇到的所有兼容性、配置或运行时问题，以及你所采取的解决措施。
    *   **6. 最终结论**：明确说明迁移是否成功，OpenCode环境当前是否可用，各组件（智能体、工作流、MCP、插件、技能）的功能状态，并给出后续优化或问题排查建议。

## 最终交付物
1.  一个配置完整、可启动的OpenCode项目目录。
2.  桌面上的测试报告文件 `iFlow_to_OpenCode_Migration_Report_YYYYMMDD.md`。

**请立即开始执行，并严格遵循“主指令文件”中的每一步操作说明。**