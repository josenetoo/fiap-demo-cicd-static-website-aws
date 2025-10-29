#!/bin/bash

# 🚀 Script de Deploy Local para FIAP CI/CD Demo
# Autor: Professor José Neto - FIAP POS Tech

set -e

echo "🎓 FIAP CI/CD Demo - Deploy Local"
echo "================================="

# Verificar se Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não encontrado. Instale primeiro:"
    echo "   https://nodejs.org/en/download/"
    echo "   Ou siga as instruções em SETUP-ENVIRONMENT.md"
    exit 1
fi

# Verificar se npm está instalado
if ! command -v npm &> /dev/null; then
    echo "❌ npm não encontrado. Instale Node.js primeiro:"
    echo "   https://nodejs.org/en/download/"
    exit 1
fi

# Verificar se AWS CLI está instalado
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI não encontrado. Instale primeiro:"
    echo "   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
    exit 1
fi

# Verificar se .env.local existe
if [ ! -f .env.local ]; then
    echo "❌ Arquivo .env.local não encontrado."
    echo "Execute primeiro: ./scripts/setup-aws.sh"
    exit 1
fi

# Carregar variáveis de ambiente
source .env.local

# Verificar se bucket name está definido
if [ -z "$REACT_APP_BUCKET_NAME" ]; then
    echo "❌ REACT_APP_BUCKET_NAME não definido no .env.local"
    exit 1
fi

echo "📦 Bucket de destino: $REACT_APP_BUCKET_NAME"

# Verificar se o bucket existe
if ! aws s3 ls s3://$REACT_APP_BUCKET_NAME --profile fiapaws &> /dev/null; then
    echo "❌ Bucket $REACT_APP_BUCKET_NAME não encontrado ou sem acesso."
    echo "Verifique suas credenciais AWS ou execute: ./scripts/setup-aws.sh"
    exit 1
fi

# Instalar dependências se necessário
if [ ! -d "node_modules" ]; then
    echo "📥 Instalando dependências..."
    npm install
fi

# Pular testes para simplificar a demonstração
echo "⚡ Pulando testes para foco no deploy..."

# Build da aplicação
echo "🔨 Fazendo build da aplicação..."
REACT_APP_BUILD_NUMBER="local-$(date +%s)" npm run build

# Deploy para S3
echo "☁️ Fazendo deploy para S3..."
aws s3 sync build/ s3://$REACT_APP_BUCKET_NAME --delete --cache-control max-age=86400 --profile fiapaws

echo ""
echo "🎉 Deploy concluído com sucesso!"
echo "================================="
echo "🌐 Site disponível em: $REACT_APP_WEBSITE_URL"
echo ""
echo "📊 Estatísticas do deploy:"
aws s3 ls s3://$REACT_APP_BUCKET_NAME --recursive --human-readable --summarize --profile fiapaws
