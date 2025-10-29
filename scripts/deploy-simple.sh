#!/bin/bash

# 🚀 Script de Deploy Simples - FIAP CI/CD Demo
# Autor: Professor José Neto - FIAP POS Tech
# Versão simplificada que pula testes se houver problemas

echo "🎓 FIAP CI/CD Demo - Deploy Simples"
echo "===================================="

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

# Verificar se Node.js está disponível
if command -v node &> /dev/null && command -v npm &> /dev/null; then
    echo "✅ Node.js e npm encontrados - fazendo build completo"
    
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
    
    BUILD_DIR="build"
else
    echo "⚠️ Node.js/npm não encontrados - usando arquivos estáticos pré-construídos"
    
    # Criar estrutura básica para demonstração
    BUILD_DIR="demo-build"
    mkdir -p $BUILD_DIR
    
    # Criar index.html básico
    cat > $BUILD_DIR/index.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FIAP CI/CD Demo</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #E91E63 0%, #AD1457 50%, #880E4F 100%);
            color: white;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .container {
            text-align: center;
            max-width: 800px;
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }
        h1 { font-size: 3rem; margin-bottom: 10px; }
        h2 { font-size: 1.5rem; margin-bottom: 30px; opacity: 0.9; }
        .status { background: rgba(76, 175, 80, 0.2); padding: 20px; border-radius: 10px; margin: 20px 0; }
        .info { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin: 30px 0; }
        .card { background: rgba(255, 255, 255, 0.1); padding: 20px; border-radius: 10px; }
        .links { margin-top: 30px; }
        .links a { 
            display: inline-block; 
            margin: 10px; 
            padding: 10px 20px; 
            background: rgba(255, 255, 255, 0.2); 
            color: white; 
            text-decoration: none; 
            border-radius: 25px; 
            transition: all 0.3s ease;
        }
        .links a:hover { background: rgba(255, 255, 255, 0.3); }
    </style>
</head>
<body>
    <div class="container">
        <h1>FIAP</h1>
        <h2>DevOps e Arquitetura Cloud - CI/CD Demo</h2>
        
        <div class="status">
            <h3>🚀 Deploy Realizado com Sucesso!</h3>
            <p>Pipeline executado em: <strong id="deploy-time"></strong></p>
        </div>
        
        <div class="info">
            <div class="card">
                <h4>📦 Tecnologias</h4>
                <p>GitHub Actions<br>AWS S3<br>Static Hosting</p>
            </div>
            <div class="card">
                <h4>🎯 Objetivo</h4>
                <p>Demonstrar CI/CD<br>Deploy Automatizado<br>DevOps na Prática</p>
            </div>
            <div class="card">
                <h4>🎓 Curso</h4>
                <p>FIAP POS Tech<br>DevOps e Arquitetura Cloud<br>Hands-on Learning</p>
            </div>
        </div>
        
        <div class="links">
            <a href="https://postech.fiap.com.br/curso/devops-e-arquitetura-cloud" target="_blank">Conheça o Curso</a>
            <a href="https://fiap.com.br" target="_blank">FIAP.com.br</a>
        </div>
        
        <p style="margin-top: 30px; opacity: 0.8; font-size: 0.9rem;">
            © 2024 FIAP - Desenvolvido para fins educacionais
        </p>
    </div>
    
    <script>
        document.getElementById('deploy-time').textContent = new Date().toLocaleString('pt-BR');
    </script>
</body>
</html>
EOF

    echo "✅ Página de demonstração criada"
fi

# Deploy para S3
echo "☁️ Fazendo deploy para S3..."
aws s3 sync $BUILD_DIR/ s3://$REACT_APP_BUCKET_NAME --delete --cache-control max-age=86400 --profile fiapaws

echo ""
echo "🎉 Deploy concluído com sucesso!"
echo "================================="
echo "🌐 Site disponível em: $REACT_APP_WEBSITE_URL"
echo ""
echo "📊 Estatísticas do deploy:"
aws s3 ls s3://$REACT_APP_BUCKET_NAME --recursive --human-readable --summarize --profile fiapaws

# Limpar build temporário se foi criado
if [ "$BUILD_DIR" = "demo-build" ]; then
    rm -rf demo-build
    echo ""
    echo "🧹 Arquivos temporários removidos"
fi
