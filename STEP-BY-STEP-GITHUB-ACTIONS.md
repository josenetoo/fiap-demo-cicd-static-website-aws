# 🤖 Step-by-Step: Automatizando com GitHub Actions

## 🎯 **Objetivo**
Transformar todo o processo manual que fizemos em um **pipeline automatizado** com GitHub Actions.

---

## 📋 **Pré-requisitos**

### ✅ **Você deve ter completado:**
- ✅ `STEP-BY-STEP-LOCAL.md` (deploy manual funcionando)
- ✅ Bucket S3 criado e configurado
- ✅ Arquivo `.env.local` com as configurações
- ✅ Site funcionando no S3

### ✅ **Você vai precisar:**
- 🐙 Conta no GitHub
- 📁 Repositório GitHub (seu fork deste projeto)

---

## 🔄 **ETAPA 1: Preparar Repositório GitHub**

### **1. Fork do Repositório**
```bash
# Se ainda não fez fork:
# 1. Vá para o repositório original no GitHub
# 2. Clique em "Fork"
# 3. Clone seu fork:

git clone https://github.com/SEU_USUARIO/fiap-demo-cicd-static-website-aws.git
cd fiap-demo-cicd-static-website-aws
```

### **2. Verificar Workflow**
```bash
# Verificar se o workflow existe
cat .github/workflows/deploy.yml

# Deve mostrar o pipeline simplificado que criamos
```

---

## 🔐 **ETAPA 2: Configurar Secrets no GitHub**

### **1. Obter suas credenciais AWS**
```bash
# Mostrar suas credenciais atuais
aws configure list --profile fiapaws

# Mostrar session token
aws configure get aws_session_token --profile fiapaws

# Mostrar nome do bucket
cat .env.local
```

### **2. Configurar Secrets no GitHub**

#### **Acessar configurações:**
1. Vá para seu repositório no GitHub
2. Clique em **Settings** (aba superior)
3. No menu lateral: **Secrets and variables** → **Actions**
4. Clique em **New repository secret**

#### **Criar os seguintes secrets:**

| Secret Name | Valor | Onde Encontrar |
|-------------|-------|----------------|
| `AWS_ACCESS_KEY_ID` | Sua Access Key | AWS Learner Lab → AWS Details |
| `AWS_SECRET_ACCESS_KEY` | Sua Secret Key | AWS Learner Lab → AWS Details |
| `AWS_SESSION_TOKEN` | Seu Session Token | AWS Learner Lab → AWS Details |
| `S3_BUCKET_NAME` | Nome do seu bucket | Arquivo `.env.local` |

#### **⚠️ Importante:**
- **Copie exatamente** como está no Learner Lab
- **Não inclua espaços** antes ou depois
- **Session Token** é uma string longa (~800 caracteres)

---

## 🚀 **ETAPA 3: Primeiro Deploy Automatizado**

### **1. Fazer uma alteração no código**
```bash
# Exemplo: alterar algo visível
echo "// Deploy via GitHub Actions - $(date)" >> src/App.js

# Ou editar manualmente src/App.js e adicionar um comentário
```

### **2. Commit e Push**
```bash
# Adicionar mudanças
git add .

# Commit com mensagem descritiva
git commit -m "feat: primeiro deploy automatizado via GitHub Actions"

# Push para main (vai triggerar o pipeline)
git push origin main
```

### **3. Acompanhar Pipeline**
1. Vá para seu repositório no GitHub
2. Clique na aba **Actions**
3. Você verá o workflow "Deploy to S3" executando
4. Clique no workflow para ver detalhes

---

## 📊 **ETAPA 4: Monitorar Execução**

### **O que você vai ver no GitHub Actions:**

#### **✅ Passos do Pipeline:**
```
🔄 build-and-deploy
├── ✅ Checkout code
├── ✅ Setup Node.js
├── ✅ Install dependencies
├── ✅ Build application
├── ✅ Configure AWS credentials
├── ✅ Deploy to S3
├── ✅ Get S3 Website URL
└── ✅ Deployment notification
```

#### **⏱️ Tempo esperado:** ~2-3 minutos

#### **🎯 Resultado esperado:**
```
🚀 Deploy realizado com sucesso!
📅 Data: 2025-10-29T14:30:00Z
🔢 Build: 1
📝 Commit: abc123...
🌐 URL: http://seu-bucket.s3-website-us-east-1.amazonaws.com
```

---

## 🔍 **ETAPA 5: Verificar Resultado**

### **1. Verificar site atualizado**
```bash
# Usar a URL do seu bucket
open http://SEU_BUCKET.s3-website-us-east-1.amazonaws.com

# Ou verificar via curl
curl -I http://SEU_BUCKET.s3-website-us-east-1.amazonaws.com
```

### **2. Comparar com deploy manual**
- ✅ **Resultado idêntico** ao deploy manual
- ✅ **Mais rápido** (sem intervenção humana)
- ✅ **Mais confiável** (sempre os mesmos passos)

---

## 🔄 **ETAPA 6: Testar Fluxo Completo**

### **1. Fazer mais alterações**
```bash
# Alterar título ou conteúdo
sed -i '' 's/Deploy Realizado com Sucesso!/🚀 Deploy Automatizado Funcionando!/g' src/App.js

# Ou editar manualmente qualquer arquivo em src/
```

### **2. Deploy automático**
```bash
git add .
git commit -m "feat: testando pipeline automático"
git push origin main

# Pipeline vai executar automaticamente!
```

### **3. Verificar mudanças**
- Acompanhar no GitHub Actions
- Verificar site atualizado
- Tempo total: ~2-3 minutos

---

## 🎓 **Comparação: Manual vs Automatizado**

### **🐌 Processo Manual (que fizemos antes):**
```bash
# 8 comandos manuais toda vez:
npm install
npm run build
source .env.local
aws s3 sync build/ s3://$BUCKET --profile fiapaws
# + verificações manuais
# Tempo: ~5-10 minutos
# Erro humano: Alto risco
```

### **🚀 Processo Automatizado (GitHub Actions):**
```bash
# 3 comandos apenas:
git add .
git commit -m "sua mensagem"
git push origin main
# Tempo: ~2-3 minutos
# Erro humano: Zero risco
```

---

## 🛠️ **Troubleshooting**

### **❌ Pipeline falhou?**

#### **1. Verificar Secrets**
```bash
# No GitHub Actions, procurar por erros como:
# "The security token included in the request is invalid"
# "Access Denied"
```
**Solução:** Verificar se secrets estão corretos

#### **2. Session Token expirado**
```bash
# Erro: "Token has expired"
```
**Solução:** 
1. Obter novo Session Token no Learner Lab
2. Atualizar secret `AWS_SESSION_TOKEN` no GitHub

#### **3. Bucket não encontrado**
```bash
# Erro: "NoSuchBucket"
```
**Solução:** Verificar secret `S3_BUCKET_NAME`

### **✅ Pipeline passou mas site não atualizou?**
- Aguardar 1-2 minutos (cache do browser)
- Fazer refresh forçado (Ctrl+F5)
- Verificar se mudança foi realmente commitada

---

## 🎯 **Próximos Passos Avançados**

### **1. Melhorias Possíveis:**
- **Notificações**: Slack, Discord, email
- **Ambientes**: Staging → Production
- **Rollback**: Automático em caso de falha
- **Monitoramento**: CloudWatch, alertas
- **Segurança**: Scan de vulnerabilidades, rotação de credenciais

---

## 📝 **Resumo do que Automatizamos**

### **✅ Antes (Manual):**
- 👨‍💻 Desenvolvedor faz build local
- 📤 Upload manual para S3
- 🔍 Verificação manual
- ⏱️ 5-10 minutos por deploy
- 😰 Risco de erro humano

### **✅ Agora (Automatizado):**
- 🤖 GitHub Actions faz tudo
- ⚡ Deploy em 2-3 minutos
- 🔒 Processo consistente
- 📊 Histórico completo
- 🎯 Zero intervenção manual

---

**🎉 Parabéns! Você criou seu primeiro pipeline de CI/CD completo! 🚀**

**💡 Agora você entende tanto o processo manual quanto a automação - isso é DevOps na prática! 🎓**
