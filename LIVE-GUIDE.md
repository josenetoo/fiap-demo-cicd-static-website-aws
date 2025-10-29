# 🎥 GUIA DA LIVE - CI/CD com GitHub Actions e AWS S3

## ⏰ Cronograma da Live (60 minutos)

### 📋 **Preparação (5 min)**
- [ ] Verificar ambiente AWS Learner Lab ativo
- [ ] Confirmar acesso ao GitHub
- [ ] Testar compartilhamento de tela
- [ ] Abrir terminais e navegadores necessários

---

### 🎯 **Introdução (10 min)**

#### **Apresentação do Projeto (5 min)**
- Mostrar o site final funcionando no S3
- Explicar a **jornada de aprendizado**: Manual → Automatizado
- **Por que começar manual?** Entender cada passo antes de automatizar

#### **Conceitos Fundamentais (5 min)**
- **DevOps Philosophy**: Entender antes de automatizar
- **CI/CD**: Do código à entrega automatizada
- **Infrastructure as Code**: AWS S3 via comandos
- **GitHub Actions**: Automação de todo o processo manual

---

### 🛠️ **PARTE 1: Deploy Manual (25 min)**

#### **1. Setup AWS + Deploy Manual (20 min)**
```bash
# Seguir: STEP-BY-STEP-LOCAL.md
cd fiap-demo-cicd-static-website-aws

# 1. Criar infraestrutura
./scripts/setup-aws.sh

# 2. Build local
npm install
npm run build

# 3. Deploy manual
source .env.local
aws s3 sync build/ s3/$REACT_APP_BUCKET_NAME --profile fiapaws

# 4. Verificar resultado
echo "Site: $REACT_APP_WEBSITE_URL"
```

#### **2. Reflexão: Problemas do Manual (5 min)**
- **Pergunta aos alunos:** "O que acontece se esquecermos um passo?"
- **Discussão:** Escalabilidade, erros humanos, repetição
- **Transição:** "Vamos automatizar tudo isso!"

---

### 🤖 **PARTE 2: Automação GitHub Actions (25 min)**

#### **1. Configurar Secrets GitHub (10 min)**
```bash
# Seguir: STEP-BY-STEP-GITHUB-ACTIONS.md

# Mostrar credenciais AWS
aws configure list --profile fiapaws

# Configurar no GitHub:
# Settings → Secrets → Actions
# - AWS_ACCESS_KEY_ID
# - AWS_SECRET_ACCESS_KEY  
# - AWS_SESSION_TOKEN
# - S3_BUCKET_NAME
```

#### **2. Primeiro Deploy Automatizado (10 min)**
```bash
# Fazer alteração
echo "// Deploy Automatizado!" >> src/App.js

# Push (vai triggerar pipeline)
git add .
git commit -m "feat: primeiro deploy automatizado"
git push origin main

# Acompanhar no GitHub Actions
```

#### **3. Comparação e Resultados (5 min)**
- **Mostrar:** Mesmo resultado, processo diferente
- **Comparar:** Manual (8 passos) vs Automatizado (3 passos)
- **Destacar:** Velocidade, confiabilidade, escalabilidade
- Arquivo `deploy.yml` do GitHub Actions
- Explicar jobs: test → build → deploy

---

### 🚀 **Hands-On: Deploy Automatizado (15 min)**

#### **1. Primeiro Deploy (8 min)**
```bash
# Fazer alteração no código
echo "// Live FIAP $(date)" >> src/App.js

# Commit e push
git add .
git commit -m "feat: deploy durante live FIAP"
git push origin main
```

**Demonstrar:**
- Pipeline executando no GitHub Actions
- Logs de cada etapa
- Site sendo atualizado automaticamente

#### **2. Monitoramento (4 min)**
- Acompanhar execução em tempo real
- Explicar cada job do pipeline
- Mostrar site atualizado

#### **3. Troubleshooting (3 min)**
- Erros comuns e soluções
- Como debuggar falhas no pipeline
- Verificação de permissões AWS

---

### 🎨 **Demonstração Avançada (8 min)**

#### **1. Modificação em Tempo Real (4 min)**
```javascript
// Alterar src/App.js - adicionar contador
const [clicks, setClicks] = useState(0);

// Adicionar botão interativo
<button onClick={() => setClicks(clicks + 1)}>
  Cliques: {clicks} 🚀
</button>
```

#### **2. Deploy e Verificação (4 min)**
- Commit da alteração
- Acompanhar pipeline
- Testar funcionalidade no site

---

### 📚 **Conceitos Avançados (2 min)**

#### **Próximos Passos**
- **Ambientes múltiplos**: dev/staging/prod
- **CloudFront**: CDN global
- **Rollback automático**: Reverter deploys com problemas
- **Monitoramento**: CloudWatch e alertas
- **Segurança**: IAM roles e policies

---

## 🎯 **Roteiro de Apresentação**

### **Slide 1: Abertura**
```
🎓 FIAP POS Tech - DevOps e Arquitetura Cloud
🚀 CI/CD com GitHub Actions e AWS S3
👨‍🏫 Professor: José Neto
```

### **Slide 2: Agenda**
```
📋 O que vamos fazer hoje:
• Criar pipeline CI/CD completo
• Deploy automatizado no AWS S3
• Monitoramento em tempo real
• Boas práticas DevOps
```

### **Slide 3: Arquitetura**
```
🏗️ Arquitetura da Solução:
Developer → Git Push → GitHub Actions → AWS S3 → Website Live
```

---

## 🗣️ **Falas Importantes**

### **Abertura**
> "Hoje vamos implementar um pipeline completo de CI/CD. Vocês vão ver como uma simples alteração no código pode ser automaticamente testada, compilada e colocada em produção em questão de minutos."

### **Durante Setup**
> "Notem que estamos usando o AWS Learner Lab da FIAP. As credenciais são temporárias, mas isso simula perfeitamente um ambiente real de desenvolvimento."

### **Durante Deploy**
> "Observem que não precisamos fazer nada manualmente. O GitHub Actions detectou nossa alteração e está executando todo o pipeline automaticamente."

### **Encerramento**
> "Vocês acabaram de ver DevOps na prática. Automatização, testes, deploy contínuo - tudo isso reduz erros e acelera entregas."

---

## 🛠️ **Comandos de Backup**

### **Se algo der errado:**

#### **Reset do Bucket**
```bash
aws s3 rm s3://$BUCKET_NAME --recursive --profile fiapaws
```

#### **Deploy Manual**
```bash
./scripts/deploy-local.sh
```

#### **Verificar Status**
```bash
aws s3 ls s3://$BUCKET_NAME --profile fiapaws
aws sts get-caller-identity --profile fiapaws
```

---

## 📱 **Interação com Alunos**

### **Perguntas para Engajar**
1. "Quem já usou CI/CD na empresa?"
2. "Qual a vantagem de automatizar deploys?"
3. "Como vocês fazem deploy hoje?"
4. "Já tiveram problemas com deploy manual?"

### **Exercícios Rápidos**
1. "Alterem a cor do site e façam commit"
2. "Adicionem seu nome na página"
3. "Criem um novo componente React"

---

## 🎬 **Checklist Final**

### **Antes da Live**
- [ ] Testar todo o fluxo uma vez
- [ ] Preparar ambiente AWS
- [ ] Verificar internet e ferramentas
- [ ] Ter backup dos comandos

### **Durante a Live**
- [ ] Compartilhar tela com qualidade
- [ ] Falar pausadamente
- [ ] Explicar cada passo
- [ ] Interagir com chat

### **Após a Live**
- [ ] Disponibilizar repositório
- [ ] Responder dúvidas no chat
- [ ] Compartilhar material adicional

---

## 🚨 **Troubleshooting Rápido**

### **Erro de Credenciais AWS**
```bash
# Reconfigurar profile
aws configure --profile fiapaws
```

### **Pipeline Falhando**
- Verificar secrets no GitHub
- Checar logs do Actions
- Validar permissões do bucket

### **Site não Carregando**
- Verificar política do bucket
- Confirmar hosting estático habilitado
- Testar URL diretamente

---

**🎓 Boa live, Professor! 🚀**
