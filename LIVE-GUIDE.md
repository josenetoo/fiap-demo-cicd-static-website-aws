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
- Explicar arquitetura: React → GitHub Actions → S3
- Demonstrar pipeline simplificado em ação

#### **Conceitos Fundamentais (5 min)**
- **CI/CD**: Continuous Integration/Continuous Deployment
- **GitHub Actions**: Automação de workflows
- **S3 Static Hosting**: Hospedagem de sites estáticos
- **Deploy Automatizado**: Build e deploy em uma etapa

---

### 🛠️ **Hands-On: Configuração (20 min)**

#### **1. Setup do Ambiente AWS (8 min)**
```bash
# Demonstrar ao vivo
cd fiap-demo-cicd-static-website-aws
./scripts/setup-aws.sh
```

**Pontos importantes:**
- Explicar credenciais temporárias do Learner Lab
- Mostrar criação do bucket S3
- Demonstrar configuração de hosting estático

#### **2. Configuração do GitHub (7 min)**
- Fork do repositório
- Configuração das Secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY` 
  - `AWS_SESSION_TOKEN`
  - `S3_BUCKET_NAME`

#### **3. Análise do Código (5 min)**
- Estrutura do projeto React
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
