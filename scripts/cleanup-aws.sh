#!/bin/bash

# 🧹 Script de Limpeza AWS para FIAP CI/CD Demo
# Autor: Professor José Neto - FIAP POS Tech

set -e

echo "🧹 FIAP CI/CD Demo - Limpeza de Recursos AWS"
echo "============================================="

# Verificar se AWS CLI está instalado
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI não encontrado. Instale primeiro:"
    echo "   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
    exit 1
fi

# Verificar se profile fiapaws existe
if ! aws configure list-profiles | grep -q "fiapaws"; then
    echo "❌ Profile 'fiapaws' não encontrado."
    echo "   Execute primeiro: ./scripts/setup-aws.sh"
    exit 1
fi

# Verificar se arquivo .env.local existe
if [ ! -f ".env.local" ]; then
    echo "❌ Arquivo .env.local não encontrado."
    echo "   Não há recursos para limpar ou execute primeiro: ./scripts/setup-aws.sh"
    exit 1
fi

# Carregar configurações do .env.local
source .env.local

if [ -z "$REACT_APP_BUCKET_NAME" ]; then
    echo "❌ Nome do bucket não encontrado no .env.local"
    exit 1
fi

echo "📦 Bucket a ser removido: $REACT_APP_BUCKET_NAME"
echo ""

# Confirmar ação
echo "⚠️  ATENÇÃO: Esta ação é IRREVERSÍVEL!"
echo "   Todos os arquivos no bucket serão deletados permanentemente."
echo ""
read -p "Tem certeza que deseja continuar? (digite 'SIM' para confirmar): " confirmation

if [ "$confirmation" != "SIM" ]; then
    echo "❌ Operação cancelada pelo usuário."
    exit 0
fi

echo ""
echo "🗑️ Iniciando limpeza dos recursos..."

# Testar conexão AWS
echo "🔍 Testando conexão com AWS..."
if ! aws sts get-caller-identity --profile fiapaws &> /dev/null; then
    echo "❌ Erro na conexão com AWS. Verifique suas credenciais."
    echo "   Suas credenciais podem ter expirado no Learner Lab."
    exit 1
fi

# Verificar se bucket existe
echo "🔍 Verificando se bucket existe..."
if ! aws s3api head-bucket --bucket "$REACT_APP_BUCKET_NAME" --profile fiapaws 2>/dev/null; then
    echo "⚠️ Bucket $REACT_APP_BUCKET_NAME não encontrado ou sem acesso."
    echo "   Pode já ter sido deletado ou você não tem permissão."
else
    # Remover todos os arquivos do bucket
    echo "🗂️ Removendo todos os arquivos do bucket..."
    if aws s3 rm s3://$REACT_APP_BUCKET_NAME --recursive --profile fiapaws; then
        echo "✅ Arquivos removidos com sucesso!"
    else
        echo "⚠️ Erro ao remover alguns arquivos, continuando..."
    fi

    # Remover política do bucket (se existir)
    echo "🔒 Removendo política do bucket..."
    if aws s3api delete-bucket-policy --bucket "$REACT_APP_BUCKET_NAME" --profile fiapaws 2>/dev/null; then
        echo "✅ Política removida!"
    else
        echo "⚠️ Política não encontrada ou já removida."
    fi

    # Remover configuração de website
    echo "🌐 Removendo configuração de website..."
    if aws s3api delete-bucket-website --bucket "$REACT_APP_BUCKET_NAME" --profile fiapaws 2>/dev/null; then
        echo "✅ Configuração de website removida!"
    else
        echo "⚠️ Configuração de website não encontrada."
    fi

    # Deletar bucket
    echo "🪣 Deletando bucket..."
    if aws s3 rb s3://$REACT_APP_BUCKET_NAME --profile fiapaws; then
        echo "✅ Bucket deletado com sucesso!"
    else
        echo "❌ Erro ao deletar bucket. Pode conter arquivos ou não ter permissão."
        exit 1
    fi
fi

# Remover arquivos locais
echo "🧹 Limpando arquivos locais..."

# Remover pasta build se existir
if [ -d "build" ]; then
    rm -rf build/
    echo "✅ Pasta build/ removida!"
fi

# Remover .env.local
if [ -f ".env.local" ]; then
    rm .env.local
    echo "✅ Arquivo .env.local removido!"
fi

# Remover node_modules se existir (opcional)
read -p "🤔 Deseja também remover node_modules/? (s/N): " remove_modules
if [[ $remove_modules =~ ^[Ss]$ ]]; then
    if [ -d "node_modules" ]; then
        rm -rf node_modules/
        echo "✅ Pasta node_modules/ removida!"
    fi
fi

echo ""
echo "🎉 Limpeza concluída com sucesso!"
echo "================================="
echo "✅ Bucket S3 deletado: $REACT_APP_BUCKET_NAME"
echo "✅ Arquivos locais removidos"
echo ""
echo "📋 Recursos limpos:"
echo "   - Bucket S3 e todos os arquivos"
echo "   - Política de acesso público"
echo "   - Configuração de website hosting"
echo "   - Arquivo .env.local"
echo "   - Pasta build/"
echo ""
echo "💡 Para recriar o ambiente:"
echo "   ./scripts/setup-aws.sh"
echo ""
echo "🎓 Obrigado por usar o FIAP CI/CD Demo!"
