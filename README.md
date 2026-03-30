# iFlow 项目 - OpenCode 集成环境

## 项目简介

iFlow 项目是一个集成了 OpenCode 完整能力的独立 AI 开发环境。

## 项目特性

- 完全独立运行：项目包含所有必要的配置和脚本
- 智能体系统：内置 3 个专业智能体
- MCP 服务器集成：支持 GitHub、Context7、Supabase、文件系统、Web 搜索
- 工作流支持：包含部署工作流，支持多步骤自动化任务
- 环境变量管理：使用 .env 文件管理所有敏感信息
- 可移植性：所有配置使用相对路径和环境变量

## 快速开始

### 前置要求

1. 安装 Node.js（版本 >= 14.16）
2. 安装 OpenCode CLI：
   npm install -g @opencode-ai/cli

### 启动项目

Windows：
  .\start-opencode.ps1

## 智能体系统

### 内置智能体

1. DevOps 工程师 - CI/CD、容器化、基础设施管理
2. 数据库管理员 - 数据库设计、优化、管理
3. 安全工程师 - 安全审计、漏洞检测、加固
