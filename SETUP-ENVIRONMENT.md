# 🛠️ Configuração do Ambiente de Desenvolvimento

## 📋 Pré-requisitos Obrigatórios

### 🟢 Node.js 18+

#### **macOS**
```bash
# Opção 1: Homebrew (Recomendado)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node@18

# Opção 2: Download direto
# Acesse: https://nodejs.org/en/download/
# Baixe e instale o LTS (18.x)

# Verificar instalação
node --version  # deve mostrar v18.x.x
npm --version   # deve mostrar 9.x.x
```

#### **Windows**
```powershell
# Opção 1: Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install nodejs-lts

# Opção 2: Download direto
# Acesse: https://nodejs.org/en/download/
# Baixe e instale o Windows Installer (.msi)
```

#### **Linux (Ubuntu/Debian)**
```bash
# Atualizar repositórios
sudo apt update

# Instalar Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verificar instalação
node --version
npm --version
```

---

### 🔧 Git

#### **macOS**
```bash
# Verificar se já está instalado
git --version

# Se não estiver, instalar via Homebrew
brew install git

# Ou instalar Xcode Command Line Tools
xcode-select --install
```

#### **Windows**
```powershell
# Download direto: https://git-scm.com/download/win
# Ou via Chocolatey
choco install git
```

#### **Linux**
```bash
sudo apt install git
```

---

### ☁️ AWS CLI

#### **macOS**
```bash
# Opção 1: Homebrew
brew install awscli

# Opção 2: Installer oficial
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# Verificar instalação
aws --version
```

#### **Windows**
```powershell
# Download: https://awscli.amazonaws.com/AWSCLIV2.msi
# Ou via Chocolatey
choco install awscli

# Verificar instalação
aws --version
```

#### **Linux**
```bash
# Download e instalação
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verificar instalação
aws --version
```

---

## 🚀 Configuração Inicial do Projeto

### 1. Clone do Repositório
```bash
git clone https://github.com/SEU_USUARIO/fiap-demo-cicd-static-website-aws.git
cd fiap-demo-cicd-static-website-aws
```

### 2. Instalação das Dependências
```bash
npm install
```

### 3. Teste Local
```bash
# Executar em modo desenvolvimento
npm start

# Executar testes
npm test

# Build de produção
npm run build
```

---

## 🔐 Configuração AWS

### 1. Obter Credenciais do Learner Lab

1. Acesse o **AWS Learner Lab** da FIAP
2. Clique em **Start Lab**
3. Aguarde o status ficar **verde**
4. Clique em **AWS Details**
5. Copie as credenciais:
   - AWS Access Key ID
   - AWS Secret Access Key
   - AWS Session Token

### 2. Configurar Profile AWS
```bash
# Configurar profile fiapaws
aws configure --profile fiapaws

# Inserir quando solicitado:
# AWS Access Key ID: [COLE_SUA_ACCESS_KEY]
# AWS Secret Access Key: [COLE_SUA_SECRET_KEY]
# Default region name: us-east-1
# Default output format: json

# Configurar Session Token (temporário)
aws configure set aws_session_token [SEU_SESSION_TOKEN] --profile fiapaws
```

### 3. Testar Configuração
```bash
# Testar conexão
aws sts get-caller-identity --profile fiapaws

# Listar buckets (deve estar vazio inicialmente)
aws s3 ls --profile fiapaws
```

---

## 🎯 Configuração do GitHub

### 1. Fork do Repositório
1. Acesse: https://github.com/professor/fiap-demo-cicd-static-website-aws
2. Clique em **Fork**
3. Selecione sua conta
4. Aguarde a criação do fork

### 2. Clone do Seu Fork
```bash
git clone https://github.com/SEU_USUARIO/fiap-demo-cicd-static-website-aws.git
cd fiap-demo-cicd-static-website-aws
```

### 3. Configurar Git
```bash
# Configurar seu nome e email
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@exemplo.com"

# Verificar configuração
git config --list
```

---

## ✅ Verificação Final

Execute este checklist para garantir que tudo está funcionando:

```bash
# 1. Verificar Node.js
node --version    # ✅ Deve mostrar v18.x.x

# 2. Verificar npm
npm --version     # ✅ Deve mostrar 9.x.x

# 3. Verificar Git
git --version     # ✅ Deve mostrar versão do Git

# 4. Verificar AWS CLI
aws --version     # ✅ Deve mostrar aws-cli/2.x.x

# 5. Verificar conexão AWS
aws sts get-caller-identity --profile fiapaws  # ✅ Deve mostrar suas credenciais

# 6. Testar projeto React
npm start         # ✅ Deve abrir http://localhost:3000
```

---

## 🚨 Troubleshooting

### **Erro: "command not found: npm"**
- Node.js não está instalado ou não está no PATH
- Reinstale o Node.js seguindo as instruções acima
- Reinicie o terminal após a instalação

### **Erro: "aws: command not found"**
- AWS CLI não está instalado
- Siga as instruções de instalação do AWS CLI
- Reinicie o terminal

### **Erro: "The security token included in the request is invalid"**
- Session Token expirou (válido por 3 horas)
- Obtenha novas credenciais no Learner Lab
- Reconfigure o profile AWS

### **Erro: "Access Denied" no S3**
- Verifique se as credenciais estão corretas
- Confirme se o Learner Lab está ativo
- Verifique se está usando o profile correto: `--profile fiapaws`

### **Erro: "Port 3000 is already in use"**
```bash
# Encontrar processo usando a porta
lsof -ti:3000

# Matar o processo
kill -9 $(lsof -ti:3000)

# Ou usar porta diferente
npm start -- --port 3001
```

---

## 🤖 **Scripts Disponíveis**

### **📋 Scripts de Automação**
| Script | Função | Quando Usar |
|--------|--------|-------------|
| `./scripts/setup-aws.sh` | Configura AWS CLI e cria infraestrutura S3 | Primeira configuração ou atualização de credenciais |
| `./scripts/cleanup-aws.sh` | Remove todos os recursos AWS criados | Ao final dos testes para limpar custos |

### **💡 Uso Inteligente do setup-aws.sh:**
- **Primeira vez**: Configura tudo do zero
- **Credenciais existentes**: Detecta automaticamente e pergunta se quer atualizar
- **Session Token expirado**: Testa conexão e pede apenas o que precisa
- **Sempre seguro**: Nunca sobrescreve sem perguntar

---

**🎓 Ambiente configurado? Vamos começar! 🚀**
