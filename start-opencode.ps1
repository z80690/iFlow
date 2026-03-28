# OpenCode 启动脚本
# 此脚本用于自动加载全局配置、设置默认智能体和环境变量

# 加载环境变量
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        if ( -match '^([^#].+?)=(.+)$') {
            [Environment]::SetEnvironmentVariable([1], [2])
        }
    }
}

# 设置默认智能体
[Environment]::SetEnvironmentVariable("OPENCODE_DEFAULT_AGENT", "devops-engineer")

# 启动 OpenCode
Write-Host "=== OpenCode 启动脚本 ===" -ForegroundColor Green
Write-Host "加载全局配置..." -ForegroundColor Yellow
Write-Host "设置默认智能体: devops-engineer" -ForegroundColor Yellow
Write-Host "启动 OpenCode..." -ForegroundColor Yellow
Write-Host ""

# 启动 OpenCode
opencode