#!/bin/bash

# 🚀 Script de Configuração AWS para FIAP CI/CD Demo
# Autor: Professor José Neto - FIAP POS Tech

set -e

echo "🎓 FIAP CI/CD Demo - Configuração AWS"
echo "======================================"

# Verificar se AWS CLI está instalado
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI não encontrado. Instale primeiro:"
    echo "   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
    exit 1
fi

# Verificar se profile fiapaws já tem credenciais configuradas
if aws configure get aws_access_key_id --profile fiapaws &> /dev/null; then
    echo "✅ Profile 'fiapaws' já configurado!"
    echo ""
    echo "🔄 Deseja atualizar as credenciais? (s/N):"
    read -p "Resposta: " update_creds
    
    if [[ $update_creds =~ ^[Ss]$ ]]; then
        echo "🔧 Atualizando credenciais do profile 'fiapaws'..."
        echo "Por favor, insira suas credenciais do AWS Learner Lab:"
        echo ""
        aws configure --profile fiapaws
        
        echo ""
        echo "🔑 Agora configure o Session Token:"
        read -p "AWS Session Token: " session_token
        aws configure set aws_session_token "$session_token" --profile fiapaws
    else
        echo "📋 Mantendo credenciais existentes do profile 'fiapaws'"
        echo ""
        echo "🔍 Testando conexão atual..."
        if aws sts get-caller-identity --profile fiapaws &> /dev/null; then
            echo "✅ Credenciais funcionando! Nada a fazer."
        else
            echo "⚠️ Conexão falhou. Provavelmente Session Token expirado."
            echo "💡 Atualizando apenas o Session Token:"
            read -p "AWS Session Token: " session_token
            aws configure set aws_session_token "$session_token" --profile fiapaws
        fi
    fi
else
    echo "🔧 Configurando profile AWS 'fiapaws'..."
    echo "Por favor, insira suas credenciais do AWS Learner Lab:"
    echo ""
    echo "📋 Você precisará das seguintes informações do Learner Lab:"
    echo "   - AWS Access Key ID"
    echo "   - AWS Secret Access Key"
    echo "   - AWS Session Token (será configurado separadamente)"
    echo ""
    aws configure --profile fiapaws

    # Solicitar Session Token separadamente
    echo ""
    echo "🔑 Agora configure o Session Token:"
    read -p "AWS Session Token: " session_token
    aws configure set aws_session_token "$session_token" --profile fiapaws
fi

# Testar conexão final (se ainda não foi testada)
if [[ $update_creds =~ ^[Ss]$ ]] || [[ -z "$update_creds" ]]; then
    echo "🔍 Testando conexão final com AWS..."
    if aws sts get-caller-identity --profile fiapaws &> /dev/null; then
        echo "✅ Conexão com AWS estabelecida com sucesso!"
        aws sts get-caller-identity --profile fiapaws
    else
        echo "❌ Erro na conexão com AWS. Verifique suas credenciais."
        exit 1
    fi
fi

# Gerar nome único para o bucket
BUCKET_NAME="fiap-cicd-demo-$(date +%s)-$(whoami)"
echo "📦 Nome do bucket: $BUCKET_NAME"

# Criar bucket S3
echo "🪣 Criando bucket S3..."
if aws s3 mb s3://$BUCKET_NAME --profile fiapaws --region us-east-1; then
    echo "✅ Bucket criado com sucesso!"
else
    echo "❌ Erro ao criar bucket. Verifique permissões."
    exit 1
fi

# Configurar bucket para hosting estático
echo "🌐 Configurando hosting estático..."
aws s3 website s3://$BUCKET_NAME \
  --index-document index.html \
  --error-document error.html \
  --profile fiapaws

# Criar política do bucket
echo "🔒 Configurando política de acesso público..."
cat > /tmp/bucket-policy.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
    }
  ]
}
EOF

# Desabilitar Block Public Access
aws s3api put-public-access-block \
  --bucket $BUCKET_NAME \
  --public-access-block-configuration \
  "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false" \
  --profile fiapaws

# Aplicar política
aws s3api put-bucket-policy \
  --bucket $BUCKET_NAME \
  --policy file:///tmp/bucket-policy.json \
  --profile fiapaws

# Salvar configurações
echo "💾 Salvando configurações..."
cat > .env.local << EOF
# Configurações AWS para desenvolvimento local
REACT_APP_BUCKET_NAME=$BUCKET_NAME
REACT_APP_REGION=us-east-1
REACT_APP_WEBSITE_URL=http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com
EOF

echo ""
echo "🎉 Configuração concluída com sucesso!"
echo "======================================"
echo "📦 Bucket S3: $BUCKET_NAME"
echo "🌐 URL do site: http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com"
echo ""
echo "📋 Próximos passos:"
echo "1. Configure as secrets no GitHub:"
echo "   - AWS_ACCESS_KEY_ID"
echo "   - AWS_SECRET_ACCESS_KEY"
echo "   - AWS_SESSION_TOKEN"
echo "   - S3_BUCKET_NAME: $BUCKET_NAME"
echo ""
echo "2. Faça commit e push para testar o pipeline:"
echo "   git add ."
echo "   git commit -m 'feat: configuração inicial'"
echo "   git push origin main"
echo ""
echo "3. Acesse GitHub Actions para acompanhar o deploy"

# Limpar arquivo temporário
rm -f /tmp/bucket-policy.json
