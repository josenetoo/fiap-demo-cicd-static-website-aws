# 🚀 Step-by-Step: Deploy Local para AWS S3

## 🎯 **Objetivo**
Aprender o processo completo de deploy fazendo **tudo manualmente primeiro**, para depois automatizar com GitHub Actions.

---

## 📋 **Pré-requisitos**

### ✅ **Verificar se tem tudo instalado:**
```bash
# Node.js
node --version  # deve mostrar v18.x.x

# npm
npm --version   # deve mostrar 9.x.x

# AWS CLI
aws --version   # deve mostrar aws-cli/2.x.x

# Git
git --version   # deve mostrar git version 2.x.x
```

### ❌ **Se algo estiver faltando:**
- Consulte o arquivo `SETUP-ENVIRONMENT.md` para instalação

---

## 🏗️ **ETAPA 1: Criar Infraestrutura AWS**

### **Opção A: Script Automatizado (Recomendado)**
```bash
# Executar o script que criamos
./scripts/setup-aws.sh
```

### **Opção B: Comandos Manuais**
```bash
# 1. Configurar credenciais AWS
aws configure --profile fiapaws
# Inserir:
# - AWS Access Key ID (do Learner Lab)
# - AWS Secret Access Key (do Learner Lab)
# - Default region: us-east-1
# - Default output format: json

# 2. Configurar Session Token
aws configure set aws_session_token "SEU_SESSION_TOKEN_AQUI" --profile fiapaws

# 3. Testar conexão
aws sts get-caller-identity --profile fiapaws

# 4. Criar bucket S3 (nome único)
export BUCKET_NAME="fiap-cicd-demo-$(date +%s)-$(whoami)"
aws s3 mb s3://$BUCKET_NAME --profile fiapaws

# 5. Configurar website hosting
aws s3 website s3://$BUCKET_NAME \
  --index-document index.html \
  --error-document error.html \
  --profile fiapaws

# 6. Configurar política pública
cat > bucket-policy.json << EOF
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

aws s3api put-bucket-policy \
  --bucket $BUCKET_NAME \
  --policy file://bucket-policy.json \
  --profile fiapaws

# 7. Remover bloqueio de acesso público
aws s3api put-public-access-block \
  --bucket $BUCKET_NAME \
  --public-access-block-configuration \
  "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false" \
  --profile fiapaws

# 8. Salvar configurações
echo "REACT_APP_BUCKET_NAME=$BUCKET_NAME" > .env.local
echo "REACT_APP_WEBSITE_URL=http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com" >> .env.local
echo "REACT_APP_AWS_REGION=us-east-1" >> .env.local

# 9. Limpar arquivo temporário
rm bucket-policy.json

echo "✅ Bucket criado: $BUCKET_NAME"
echo "🌐 URL: http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com"
```

---

## 💻 **ETAPA 2: Preparar Aplicação React**

### **1. Instalar dependências**
```bash
# Instalar pacotes do Node.js
npm install
```

### **2. Testar aplicação localmente**
```bash
# Iniciar servidor de desenvolvimento
npm start

# Abrir no navegador: http://localhost:3000
# Verificar se está funcionando
# Pressionar Ctrl+C para parar
```

### **3. Fazer build de produção**
```bash
# Gerar arquivos otimizados para produção
npm run build

# Verificar se pasta 'build' foi criada
ls -la build/
```

---

## ☁️ **ETAPA 3: Deploy Manual no S3**

### **1. Carregar arquivos no S3**
```bash
# Carregar variáveis do .env.local
source .env.local

# Sincronizar pasta build com S3
aws s3 sync build/ s3://$REACT_APP_BUCKET_NAME \
  --delete \
  --cache-control max-age=86400 \
  --profile fiapaws

echo "🚀 Deploy realizado!"
echo "🌐 Site disponível em: $REACT_APP_WEBSITE_URL"
```

### **2. Testar o site**
```bash
# Abrir no navegador
open $REACT_APP_WEBSITE_URL

# Ou copiar e colar a URL no navegador
echo "URL: $REACT_APP_WEBSITE_URL"
```

---

## 🔄 **ETAPA 4: Simular Mudanças (CI/CD Manual)**

### **1. Fazer uma alteração no código**
```bash
# Exemplo: alterar o footer
sed -i '' 's/2025/2025 - Atualizado!/g' src/App.js

# Ou editar manualmente o arquivo src/App.js
```

### **2. Rebuild e redeploy**
```bash
# 1. Novo build
npm run build

# 2. Novo deploy
aws s3 sync build/ s3://$REACT_APP_BUCKET_NAME \
  --delete \
  --cache-control max-age=86400 \
  --profile fiapaws

# 3. Verificar mudança
echo "🔄 Atualização deployada!"
echo "🌐 Verificar em: $REACT_APP_WEBSITE_URL"
```

---

## 📊 **ETAPA 5: Monitoramento e Verificação**

### **1. Verificar arquivos no S3**
```bash
# Listar arquivos no bucket
aws s3 ls s3://$REACT_APP_BUCKET_NAME --recursive --profile fiapaws

# Ver tamanho total
aws s3 ls s3://$REACT_APP_BUCKET_NAME --recursive --human-readable --summarize --profile fiapaws
```

### **2. Verificar logs de acesso (opcional)**
```bash
# Ver configuração do bucket
aws s3api get-bucket-website --bucket $REACT_APP_BUCKET_NAME --profile fiapaws
```

---

## 🎓 **Reflexão: O que Aprendemos?**

### **Processo Manual que Fizemos:**
1. ✅ **Configurar AWS** (credenciais, bucket, políticas)
2. ✅ **Preparar código** (install, build)
3. ✅ **Deploy manual** (sync para S3)
4. ✅ **Testar resultado** (verificar site)
5. ✅ **Fazer mudanças** (edit, rebuild, redeploy)

### **Problemas do Processo Manual:**
- 🐌 **Lento**: Muitos comandos manuais
- 😰 **Propenso a erros**: Fácil esquecer um passo
- 🔄 **Repetitivo**: Mesmo processo toda vez
- 👥 **Não escalável**: E se fossem 10 desenvolvedores?

### **💡 Solução: Automatizar com GitHub Actions!**

---

## 🚀 **Próximo Passo: GitHub Actions**

Agora que entendemos **todo o processo manual**, vamos automatizar tudo isso com **GitHub Actions**!

### **O que o GitHub Actions vai fazer por nós:**
- ✅ **Trigger automático** quando fizermos push
- ✅ **Build automático** da aplicação
- ✅ **Deploy automático** no S3
- ✅ **Notificação** do resultado

### **Vantagens:**
- ⚡ **Rápido**: Deploy em 2-3 minutos
- 🔒 **Confiável**: Sempre os mesmos passos
- 👥 **Colaborativo**: Toda a equipe usa o mesmo processo
- 📊 **Rastreável**: Histórico de todos os deploys

---

## 📝 **Comandos de Limpeza (Opcional)**

### **Se quiser limpar tudo depois:**
```bash
# Remover bucket (cuidado!)
aws s3 rm s3://$REACT_APP_BUCKET_NAME --recursive --profile fiapaws
aws s3 rb s3://$REACT_APP_BUCKET_NAME --profile fiapaws

# Remover arquivos locais
rm -rf build/
rm .env.local
```

---

**🎉 Parabéns! Você fez seu primeiro deploy manual completo! Agora vamos automatizar tudo isso! 🚀**
