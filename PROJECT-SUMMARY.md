# 📋 Resumo do Projeto - FIAP CI/CD Demo

## 🎯 **Visão Geral**

Projeto completo de demonstração de CI/CD para o curso **DevOps e Arquitetura Cloud** da **FIAP POS Tech**, implementando um pipeline automatizado com **GitHub Actions** para deploy de aplicação **React** no **AWS S3**.

---

## 🏗️ **Arquitetura da Solução**

```
Developer → Git Push → GitHub Actions → AWS S3 → Website Live
    ↓           ↓            ↓           ↓         ↓
  Código    Trigger     Test/Build    Deploy   Usuários
```

### **Componentes Principais**
- **Frontend**: React 18 com identidade visual FIAP
- **CI/CD**: GitHub Actions (3 jobs: test → build → deploy)
- **Hospedagem**: AWS S3 Static Website Hosting
- **CDN**: AWS CloudFront (opcional)
- **Monitoramento**: GitHub Actions logs + AWS CloudWatch

---

## 📁 **Estrutura do Projeto**

```
fiap-demo-cicd-static-website-aws/
├── 📄 README.md                    # Documentação principal
├── 📄 LIVE-GUIDE.md               # Guia para live de 1h
├── 📄 SETUP-ENVIRONMENT.md        # Configuração do ambiente
├── 📄 EXERCICIOS.md               # Exercícios práticos
├── 📄 PROJECT-SUMMARY.md          # Este arquivo
├── 📦 package.json                # Dependências Node.js
├── 🔧 .gitignore                  # Arquivos ignorados
├── 📁 public/                     # Arquivos públicos
│   ├── index.html                 # HTML principal
│   └── manifest.json              # PWA manifest
├── 📁 src/                        # Código fonte React
│   ├── App.js                     # Componente principal
│   ├── App.css                    # Estilos principais
│   ├── App.test.js               # Testes automatizados
│   ├── index.js                   # Entry point
│   └── index.css                  # Estilos globais
├── 📁 .github/workflows/          # GitHub Actions
│   └── deploy.yml                 # Pipeline CI/CD
└── 📁 scripts/                    # Scripts auxiliares
    ├── setup-aws.sh              # Configuração AWS
    └── deploy-local.sh            # Deploy local
```

---

## 🚀 **Pipeline CI/CD**

### **Workflow: `.github/workflows/deploy.yml`**

#### **Job 1: Test** 🧪
- Checkout do código
- Setup Node.js 18
- Instalação de dependências
- Execução de testes com coverage
- Upload de relatórios de cobertura

#### **Job 2: Build** 🔨
- Checkout do código
- Setup Node.js 18
- Instalação de dependências
- Build da aplicação React
- Injeção de variáveis de ambiente
- Upload dos artefatos de build

#### **Job 3: Deploy** ☁️
- Download dos artefatos
- Configuração de credenciais AWS
- Sync com bucket S3
- Invalidação do CloudFront (opcional)
- Notificação de sucesso

### **Triggers**
- Push para branch `main`
- Pull Request para `main` (apenas test e build)

---

## 🛠️ **Tecnologias Utilizadas**

### **Frontend**
- **React 18**: Framework JavaScript
- **CSS3**: Estilos com gradientes e animações
- **Jest**: Framework de testes
- **React Testing Library**: Testes de componentes

### **DevOps**
- **GitHub Actions**: Automação CI/CD
- **AWS S3**: Hospedagem estática
- **AWS CloudFront**: CDN global (opcional)
- **AWS CLI**: Interface de linha de comando

### **Desenvolvimento**
- **Node.js 18**: Runtime JavaScript
- **npm**: Gerenciador de pacotes
- **Git**: Controle de versão

---

## 🎨 **Características do Site**

### **Design**
- ✨ Identidade visual FIAP (cores oficiais)
- 📱 Design responsivo
- 🎭 Animações CSS suaves
- 🌈 Gradientes modernos
- 🔍 Glassmorphism effects

### **Funcionalidades**
- 📊 Dashboard de status do pipeline
- ⏰ Timestamp do último deploy
- 🔢 Número do build atual
- 🔗 Links para curso e FIAP
- 📈 Informações da stack tecnológica

### **Interatividade**
- 🎮 Contador de cliques (exercício)
- 👨‍🎓 Informações do aluno (exercício)
- 🔄 Atualizações em tempo real

---

## 📚 **Documentação Incluída**

### **Para Professores**
- **LIVE-GUIDE.md**: Roteiro completo para live de 1h
- **PROJECT-SUMMARY.md**: Visão técnica do projeto

### **Para Alunos**
- **README.md**: Documentação principal com passo-a-passo
- **SETUP-ENVIRONMENT.md**: Configuração do ambiente
- **EXERCICIOS.md**: 5 exercícios práticos graduais

### **Scripts Auxiliares**
- **setup-aws.sh**: Automação da configuração AWS
- **deploy-local.sh**: Deploy manual para testes

---

## 🎓 **Objetivos Pedagógicos**

### **Conceitos Abordados**
1. **CI/CD Fundamentals**
   - Continuous Integration
   - Continuous Deployment
   - Pipeline automation

2. **GitHub Actions**
   - Workflow configuration
   - Jobs e steps
   - Secrets management
   - Artifact handling

3. **AWS Services**
   - S3 Static Website Hosting
   - IAM roles e policies
   - CloudFront CDN
   - CLI automation

4. **DevOps Practices**
   - Infrastructure as Code
   - Automated testing
   - Deployment strategies
   - Monitoring e logging

### **Habilidades Desenvolvidas**
- ⚙️ Configuração de pipelines CI/CD
- ☁️ Deploy em cloud (AWS)
- 🧪 Testes automatizados
- 📝 Documentação técnica
- 🔧 Troubleshooting e debugging

---

## ⏰ **Cronograma da Live (60 min)**

| Tempo | Atividade | Conteúdo |
|-------|-----------|----------|
| 0-5 min | Preparação | Setup do ambiente |
| 5-15 min | Introdução | Conceitos e demo |
| 15-35 min | Hands-On Setup | AWS + GitHub config |
| 35-50 min | Deploy Demo | Pipeline em ação |
| 50-58 min | Conceitos Avançados | Próximos passos |
| 58-60 min | Q&A | Dúvidas e encerramento |

---

## 🔧 **Configurações Necessárias**

### **GitHub Secrets**
```
AWS_ACCESS_KEY_ID=AKIA...
AWS_SECRET_ACCESS_KEY=...
AWS_SESSION_TOKEN=...
S3_BUCKET_NAME=fiap-cicd-demo-123456789
```

### **GitHub Variables**
```
CLOUDFRONT_DISTRIBUTION_ID=E1234567890ABC (opcional)
```

### **AWS Resources**
- S3 Bucket com hosting estático habilitado
- Bucket policy para acesso público
- CloudFront distribution (opcional)

---

## 📊 **Métricas de Sucesso**

### **Pipeline**
- ✅ Testes passando (>90% coverage)
- ✅ Build sem erros
- ✅ Deploy automatizado (<5 min)
- ✅ Site acessível publicamente

### **Aprendizado**
- 🎯 Alunos conseguem configurar pipeline
- 🎯 Alunos entendem conceitos CI/CD
- 🎯 Alunos fazem deploy com sucesso
- 🎯 Alunos completam exercícios práticos

---

## 🚨 **Troubleshooting Comum**

### **Erros Frequentes**
1. **Credenciais AWS expiradas** → Renovar no Learner Lab
2. **Bucket name conflito** → Usar nome único
3. **Permissões S3** → Verificar bucket policy
4. **Node.js não instalado** → Seguir SETUP-ENVIRONMENT.md
5. **Tests falhando** → Verificar sintaxe do código

### **Soluções Rápidas**
```bash
# Reset completo do ambiente
./scripts/setup-aws.sh

# Deploy manual para teste
./scripts/deploy-local.sh

# Verificar status AWS
aws sts get-caller-identity --profile fiapaws
```

---

## 🔮 **Próximos Passos**

### **Melhorias Possíveis**
- 🌍 Múltiplos ambientes (dev/staging/prod)
- 🔄 Rollback automático
- 📱 Notificações Slack/Teams
- 📊 Monitoramento avançado
- 🔒 Segurança aprimorada
- 🧪 Testes E2E com Cypress

### **Exercícios Avançados**
- Implementar feature flags
- Configurar blue-green deployment
- Adicionar performance monitoring
- Integrar com SonarQube
- Configurar disaster recovery

---

## 👥 **Créditos**

### **Desenvolvido para**
**FIAP - Faculdade de Informática e Administração Paulista**
- Curso: DevOps e Arquitetura Cloud
- Modalidade: POS Tech
- Público: Profissionais de TI

### **Professor Responsável**
**José Neto**
- Email: professor@fiap.com.br
- LinkedIn: linkedin.com/in/professor

---

## 📄 **Licença**

Este projeto é licenciado sob a **MIT License** e desenvolvido exclusivamente para fins educacionais no contexto do curso de **DevOps e Arquitetura Cloud** da **FIAP POS Tech**.

---

**🎓 Projeto pronto para uso em sala de aula! 🚀**

*Última atualização: Outubro 2024*
