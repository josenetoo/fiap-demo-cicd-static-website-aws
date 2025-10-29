# 🏗️ Arquitetura Detalhada - FIAP CI/CD Demo

## 📋 Visão Geral do Sistema

### **🎯 Objetivo**
Demonstrar um pipeline completo de CI/CD usando GitHub Actions para deploy automatizado de uma aplicação React no AWS S3.

---

## 🔄 Fluxos de Deploy

### **📊 Comparação: Manual vs Automatizado**
```mermaid
graph TB
    subgraph "🔧 DEPLOY MANUAL"
        Dev1["👨‍💻 Desenvolvedor"] --> Install1["npm install"]
        Install1 --> Build1["npm run build"]
        Build1 --> Config1["aws configure"]
        Config1 --> Sync1["aws s3 sync"]
        Sync1 --> Site1["🌐 Website"]
    end
    
    subgraph "🤖 DEPLOY AUTOMATIZADO"
        Dev2["👨‍💻 Desenvolvedor"] --> Push["git push"]
        Push --> Actions["GitHub Actions"]
        Actions --> Build2["Build + Deploy"]
        Build2 --> Site2["🌐 Website"]
    end
    
    Manual["⚠️ Manual: 6+ passos"] --> Dev1
    Auto["✅ Automatizado: 3 passos"] --> Dev2
```

---

## 🤖 GitHub Actions Workflow Detalhado

### **⚙️ Pipeline Completo**
```mermaid
graph TD
    subgraph "🔔 Trigger"
        Push["git push origin main"] --> Webhook["GitHub Webhook"]
    end
    
    subgraph "🏃‍♂️ GitHub Actions Runner"
        Webhook --> Job["build-and-deploy Job"]
        
        Job --> Step1["1️⃣ Checkout code"]
        Step1 --> Step2["2️⃣ Setup Node.js 18"]
        Step2 --> Step3["3️⃣ npm install"]
        Step3 --> Step4["4️⃣ npm run build"]
        Step4 --> Step5["5️⃣ Configure AWS"]
        Step5 --> Step6["6️⃣ Deploy to S3"]
        Step6 --> Step7["7️⃣ Show URL"]
        Step7 --> Success["✅ Success"]
    end
    
    subgraph "☁️ AWS"
        Step6 --> S3["🪣 S3 Bucket"]
        S3 --> Website["🌐 Static Website"]
    end
    
    Success --> Notification["📧 Notification"]
```

### **📝 Workflow YAML Breakdown**
```mermaid
graph LR
    subgraph "📄 deploy.yml"
        Trigger["on: push main"] --> Env["env: NODE_VERSION, AWS_REGION"]
        Env --> Jobs["jobs: build-and-deploy"]
        
        Jobs --> Runner["runs-on: ubuntu-latest"]
        Runner --> Steps["steps: 7 actions"]
        
        Steps --> Checkout["actions/checkout@v4"]
        Steps --> NodeSetup["actions/setup-node@v4"]
        Steps --> Install["npm install"]
        Steps --> Build["npm run build"]
        Steps --> AWSConfig["aws-actions/configure-aws-credentials@v4"]
        Steps --> Deploy["aws s3 sync"]
        Steps --> URL["echo S3 URL"]
    end
    
    subgraph "🔒 Secrets"
        AWSConfig --> AccessKey["AWS_ACCESS_KEY_ID"]
        AWSConfig --> SecretKey["AWS_SECRET_ACCESS_KEY"]
        AWSConfig --> SessionToken["AWS_SESSION_TOKEN"]
        Deploy --> BucketName["S3_BUCKET_NAME"]
    end
```

---

## 🏛️ Infraestrutura AWS

### **🪣 S3 Static Website Hosting**
```mermaid
graph TB
    subgraph "🌐 Internet"
        User["👤 Usuário Final"]
        Browser["🌐 Navegador"]
    end
    
    subgraph "☁️ AWS S3 Bucket"
        subgraph "📁 Static Files"
            HTML["index.html"]
            CSS["styles.css"]
            JS["bundle.js"]
            Assets["images, fonts"]
        end
        
        subgraph "⚙️ Configurações"
            WebsiteConfig["Website Hosting<br/>Index: index.html<br/>Error: error.html"]
            PublicPolicy["Bucket Policy<br/>Public Read Access"]
            CORS["CORS Configuration<br/>Allow All Origins"]
        end
    end
    
    subgraph "🔐 Segurança"
        IAM["IAM Permissions"]
        PublicAccess["Public Access Block<br/>Disabled for Website"]
    end
    
    User --> Browser
    Browser -->|"HTTP GET"| HTML
    HTML --> CSS
    HTML --> JS
    HTML --> Assets
    
    WebsiteConfig --> HTML
    PublicPolicy --> HTML
    IAM --> PublicPolicy
    PublicAccess --> WebsiteConfig
```

### **🔑 Credenciais e Acesso**
```mermaid
sequenceDiagram
    participant Learner as 🎓 AWS Learner Lab
    participant GitHub as 🐙 GitHub Secrets
    participant Actions as ⚙️ GitHub Actions
    participant AWS as ☁️ AWS Services
    participant S3 as 🪣 S3 Bucket

    Learner->>GitHub: 1. Configurar Secrets
    Note over Learner,GitHub: AWS_ACCESS_KEY_ID<br/>AWS_SECRET_ACCESS_KEY<br/>AWS_SESSION_TOKEN<br/>S3_BUCKET_NAME
    
    Actions->>GitHub: 2. Ler Secrets
    GitHub-->>Actions: 🔒 Credenciais seguras
    
    Actions->>AWS: 3. Autenticar
    AWS-->>Actions: ✅ Token válido
    
    Actions->>S3: 4. aws s3 sync build/
    S3-->>Actions: ✅ Upload concluído
    
    Note over Actions,S3: Arquivos sincronizados<br/>Cache-Control: max-age=86400
```

---

## 📊 Métricas e Monitoramento

### **⏱️ Performance do Pipeline**
```mermaid
gantt
    title 🚀 Timeline do Deploy (GitHub Actions)
    dateFormat X
    axisFormat %s

    section Setup
    Checkout code           :0, 10
    Setup Node.js          :10, 20
    
    section Build
    npm install            :20, 60
    npm run build          :60, 90
    
    section Deploy
    Configure AWS          :90, 100
    Deploy to S3           :100, 130
    Show URL               :130, 140
    
    section Total
    Pipeline completo      :0, 140
```

### **📈 Comparação de Eficiência**
```mermaid
xychart-beta
    title "⚡ Tempo de Deploy (segundos)"
    x-axis [Manual, GitHub Actions]
    y-axis "Tempo (s)" 0 --> 600
    bar [480, 140]
```

---

## 🔧 Componentes Técnicos

### **📦 Dependências do Projeto**
```mermaid
graph TD
    subgraph "🎨 Frontend"
        React["React 18.2.0"]
        ReactDOM["React DOM 18.2.0"]
        WebVitals["Web Vitals 2.1.4"]
    end
    
    subgraph "🛠️ Build Tools"
        ReactScripts["React Scripts 5.0.1"]
        Webpack["Webpack<br/>via React Scripts"]
        Babel["Babel<br/>via React Scripts"]
    end
    
    subgraph "☁️ Deploy Tools"
        AWSCLI["AWS CLI v2"]
        GitHubActions["GitHub Actions"]
        NodeJS["Node.js 18"]
    end
    
    React --> ReactScripts
    ReactDOM --> ReactScripts
    ReactScripts --> Webpack
    ReactScripts --> Babel
    
    Webpack --> Build["📦 build/"]
    Build --> AWSCLI
    AWSCLI --> S3Deploy["🪣 S3 Deploy"]
    
    GitHubActions --> NodeJS
    NodeJS --> ReactScripts
```

### **🌐 Arquitetura de Rede**
```mermaid
graph LR
    subgraph "🌍 Global"
        Internet["Internet"]
    end
    
    subgraph "🇺🇸 us-east-1"
        subgraph "S3 Service"
            Bucket["fiap-cicd-demo-xxx"]
            Website["S3 Website Endpoint<br/>bucket.s3-website-us-east-1.amazonaws.com"]
        end
        
        subgraph "IAM Service"
            Policy["Bucket Policy"]
            Permissions["Public Read Permissions"]
        end
    end
    
    Internet --> Website
    Website --> Bucket
    Policy --> Bucket
    Permissions --> Policy
```

---

## 🎓 Valor Educacional

### **📚 Conceitos DevOps Demonstrados**
```mermaid
mindmap
  root((🎯 DevOps<br/>Concepts))
    🔄 CI/CD
      Continuous Integration
      Continuous Deployment
      Automated Testing
      Build Automation
    
    ☁️ Cloud
      Infrastructure as Code
      S3 Static Hosting
      AWS CLI
      Cloud Security
    
    🤖 Automation
      GitHub Actions
      Workflow Triggers
      Secret Management
      Pipeline as Code
    
    🔧 Tools
      Git Version Control
      Node.js Ecosystem
      React Build Process
      AWS Services
```

### **🎯 Jornada de Aprendizado**
```mermaid
journey
    title 🎓 Jornada do Aluno FIAP
    section Manual Deploy
      Entender processo: 3: Aluno
      Configurar AWS: 2: Aluno
      Build e Deploy: 4: Aluno
      Ver problemas: 5: Aluno
    
    section Automação
      Configurar GitHub: 4: Aluno
      Primeiro deploy auto: 5: Aluno
      Comparar resultados: 5: Aluno
      Apreciar automação: 5: Aluno
    
    section Reflexão
      Entender DevOps: 5: Aluno
      Aplicar conceitos: 4: Aluno
      Próximos passos: 4: Aluno
```

---

**🎉 Esta arquitetura demonstra na prática os princípios fundamentais de DevOps: automação, colaboração e entrega contínua! 🚀**
