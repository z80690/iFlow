# iFlow 项目 - OpenCode 启动脚本（简化版）
# 版本: 1.0
# 日期: 2026-03-30

param(
    [switch]$Verbose
)

Write-Host "=== iFlow 项目 - OpenCode 启动脚本 ===" -ForegroundColor Cyan
Write-Host "版本: 1.0 | 日期: 2026-03-30" -ForegroundColor Gray
Write-Host ""

# 检查当前目录
$currentDir = Get-Location
Write-Host "当前目录: $currentDir" -ForegroundColor Cyan
Write-Host ""

# 检查配置文件
Write-Host "--- 检查配置文件 ---" -ForegroundColor Yellow
$configFiles = @(
    ".env",
    ".opencode/global-config.yaml",
    ".opencode/agents/agent-registry.yaml",
    ".opencode/mcp/*.yaml"
)

foreach ($pattern in $configFiles) {
    $files = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue
    if ($files) {
        foreach ($file in $files) {
            Write-Host "✅ $file" -ForegroundColor Green
        }
    } else {
        Write-Host "❌ $pattern" -ForegroundColor Red
    }
}
Write-Host ""

# 加载环境变量
Write-Host "--- 加载环境变量 ---" -ForegroundColor Yellow
if (Test-Path ".env") {
    $envFile = Get-Content ".env" -Raw
    $envLines = $envFile -split "\r?\n"
    foreach ($line in $envLines) {
        if ($line -match '^(?!#)([^=]+)=(.*)$') {
            $varName = $matches[1].Trim()
            $varValue = $matches[2].Trim()
            [Environment]::SetEnvironmentVariable($varName, $varValue)
            if ($Verbose) {
                Write-Host "  设置: $varName" -ForegroundColor Gray
            }
        }
    }
    Write-Host "✅ 环境变量已加载" -ForegroundColor Green
} else {
    Write-Host "⚠️  .env 文件不存在" -ForegroundColor Yellow
}
Write-Host ""

# 设置 OpenCode 配置路径
Write-Host "--- 配置 OpenCode ---" -ForegroundColor Yellow
$configPath = Join-Path $currentDir "opencode.json"
[Environment]::SetEnvironmentVariable("OPENCODE_CONFIG", $configPath)
Write-Host "✅ OPENCODE_CONFIG: $configPath" -ForegroundColor Green

# 设置默认智能体
[Environment]::SetEnvironmentVariable("OPENCODE_DEFAULT_AGENT", "devops-engine")
Write-Host "✅ OPENCODE_DEFAULT_AGENT: devops-engine" -ForegroundColor Green
Write-Host ""

# 检查 OpenCode 是否已安装
Write-Host "--- 检查 OpenCode ---" -ForegroundColor Yellow
$opencodeCmd = Get-Command "opencode" -ErrorAction SilentlyContinue
if ($opencodeCmd) {
    Write-Host "✅ OpenCode 已安装: $($opencodeCmd.Source)" -ForegroundColor Green
    Write-Host ""
    
    # 启动 OpenCode
    Write-Host "--- 启动 OpenCode ---" -ForegroundColor Yellow
    Write-Host "正在启动 OpenCode..." -ForegroundColor Cyan
    Write-Host ""
    
    try {
        & opencode
    } catch {
        Write-Host "❌ 启动失败: $_" -ForegroundColor Red
        Write-Host "请确保已正确安装 OpenCode CLI" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ OpenCode 未安装" -ForegroundColor Red
    Write-Host ""
    Write-Host "请使用以下命令安装 OpenCode:" -ForegroundColor Yellow
    Write-Host "  npm install -g @opencode-ai/cli" -ForegroundColor Cyan
}
