# Script para atualizar repositório GitHub
Write-Host "🚀 Atualizando repositório GitHub..." -ForegroundColor Green

# Adicionar Git ao PATH
$env:PATH += ";C:\Program Files\Git\bin"

# Adicionar arquivos
Write-Host "📦 Adicionando arquivos..." -ForegroundColor Yellow
& "C:\Program Files\Git\bin\git.exe" add .

# Fazer commit
Write-Host "💾 Fazendo commit..." -ForegroundColor Yellow
& "C:\Program Files\Git\bin\git.exe" commit -m "🔧 Melhorias: Variáveis de ambiente e otimizações"

# Push para GitHub
Write-Host "🚀 Enviando para GitHub..." -ForegroundColor Yellow
& "C:\Program Files\Git\bin\git.exe" push origin main

Write-Host "✅ Atualização concluída!" -ForegroundColor Green 