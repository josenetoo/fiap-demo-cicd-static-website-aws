#!/bin/bash

# 🧪 Script de Teste do Ambiente - FIAP CI/CD Demo
# Autor: Professor José Neto - FIAP POS Tech

echo "🎓 FIAP CI/CD Demo - Teste do Ambiente"
echo "====================================="

# Função para verificar comando
check_command() {
    if command -v $1 &> /dev/null; then
        echo "✅ $1 está instalado: $(which $1)"
        if [ "$1" = "node" ]; then
            echo "   Versão: $(node --version)"
        elif [ "$1" = "npm" ]; then
            echo "   Versão: $(npm --version)"
        elif [ "$1" = "aws" ]; then
            echo "   Versão: $(aws --version)"
        fi
    else
        echo "❌ $1 não está instalado"
        return 1
    fi
}

echo ""
echo "🔍 Verificando dependências..."
echo "------------------------------"

# Verificar Node.js
check_command "node"
node_status=$?

# Verificar npm
check_command "npm"
npm_status=$?

# Verificar Git
check_command "git"
git_status=$?

# Verificar AWS CLI
check_command "aws"
aws_status=$?

echo ""
echo "📁 Verificando arquivos do projeto..."
echo "------------------------------------"

# Verificar arquivos essenciais
files_to_check=(
    "package.json"
    "src/App.js"
    "src/App.css"
    "src/index.js"
    "public/index.html"
    ".github/workflows/deploy.yml"
)

missing_files=0
for file in "${files_to_check[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file existe"
    else
        echo "❌ $file não encontrado"
        missing_files=$((missing_files + 1))
    fi
done

echo ""
echo "🔐 Verificando configuração AWS..."
echo "---------------------------------"

# Verificar se profile fiapaws existe
if aws configure list --profile fiapaws &> /dev/null; then
    echo "✅ Profile 'fiapaws' configurado"
    
    # Testar conexão (se possível)
    if aws sts get-caller-identity --profile fiapaws &> /dev/null; then
        echo "✅ Conexão AWS funcionando"
        echo "   Account: $(aws sts get-caller-identity --profile fiapaws --query Account --output text 2>/dev/null || echo 'N/A')"
    else
        echo "⚠️ Profile configurado mas sem conexão (credenciais podem ter expirado)"
    fi
else
    echo "❌ Profile 'fiapaws' não configurado"
fi

# Verificar .env.local
if [ -f ".env.local" ]; then
    echo "✅ Arquivo .env.local existe"
    if grep -q "REACT_APP_BUCKET_NAME" .env.local; then
        bucket_name=$(grep "REACT_APP_BUCKET_NAME" .env.local | cut -d'=' -f2)
        echo "   Bucket configurado: $bucket_name"
    fi
else
    echo "❌ Arquivo .env.local não encontrado"
fi

echo ""
echo "📊 Resumo do Status"
echo "==================="

total_errors=0

if [ $node_status -ne 0 ]; then
    echo "❌ Node.js precisa ser instalado"
    total_errors=$((total_errors + 1))
fi

if [ $npm_status -ne 0 ]; then
    echo "❌ npm precisa ser instalado"
    total_errors=$((total_errors + 1))
fi

if [ $git_status -ne 0 ]; then
    echo "❌ Git precisa ser instalado"
    total_errors=$((total_errors + 1))
fi

if [ $aws_status -ne 0 ]; then
    echo "❌ AWS CLI precisa ser instalado"
    total_errors=$((total_errors + 1))
fi

if [ $missing_files -gt 0 ]; then
    echo "❌ $missing_files arquivo(s) do projeto não encontrado(s)"
    total_errors=$((total_errors + 1))
fi

if [ $total_errors -eq 0 ]; then
    echo ""
    echo "🎉 Ambiente está pronto para uso!"
    echo "Próximos passos:"
    echo "1. Execute: ./scripts/setup-aws.sh (se ainda não executou)"
    echo "2. Configure as secrets no GitHub"
    echo "3. Faça seu primeiro commit e push"
else
    echo ""
    echo "⚠️ $total_errors problema(s) encontrado(s)"
    echo "Consulte SETUP-ENVIRONMENT.md para instruções de instalação"
fi

echo ""
echo "📚 Documentação disponível:"
echo "- README.md: Guia completo"
echo "- SETUP-ENVIRONMENT.md: Configuração do ambiente"
echo "- LIVE-GUIDE.md: Roteiro da live"
echo "- EXERCICIOS.md: Exercícios práticos"
