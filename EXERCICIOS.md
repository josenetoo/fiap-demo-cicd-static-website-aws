# 🎯 Exercícios Práticos - CI/CD com GitHub Actions

## 🏃‍♂️ Exercício 1: Personalização Básica (15 min)

### **Objetivo**
Personalizar o site com suas informações e observar o pipeline em ação.

### **Tarefas**
1. **Alterar informações pessoais**
   ```javascript
   // Em src/App.js, encontre e altere:
   <h3>Demo de CI/CD com GitHub Actions</h3>
   // Para:
   <h3>Demo de CI/CD - [SEU NOME]</h3>
   ```

2. **Adicionar sua turma**
   ```javascript
   // Adicione após o h3:
   <p className="turma-info">Turma: [SUA TURMA] - {new Date().getFullYear()}</p>
   ```

3. **Personalizar cores** (src/App.css)
   ```css
   /* Altere a cor principal do gradiente */
   .App-header {
     background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
   }
   ```

### **Entrega**
- Faça commit: `git commit -m "feat: personalização com meu nome"`
- Push: `git push origin main`
- Compartilhe a URL do seu site no chat

---

## 🏃‍♂️ Exercício 2: Funcionalidade Interativa (20 min)

### **Objetivo**
Adicionar um contador de cliques e deploy automático.

### **Tarefas**
1. **Adicionar estado do contador**
   ```javascript
   // No início do componente App, após os outros useState:
   const [clicks, setClicks] = useState(0);
   const [lastClickTime, setLastClickTime] = useState('');
   ```

2. **Criar função de clique**
   ```javascript
   // Adicionar antes do return:
   const handleClick = () => {
     setClicks(clicks + 1);
     setLastClickTime(new Date().toLocaleTimeString('pt-BR'));
   };
   ```

3. **Adicionar botão interativo**
   ```javascript
   // Adicionar após os info-cards:
   <div className="interactive-section">
     <h4>🎮 Seção Interativa</h4>
     <button 
       className="click-button" 
       onClick={handleClick}
     >
       Clique aqui! 🚀
     </button>
     <div className="click-stats">
       <p>Total de cliques: <strong>{clicks}</strong></p>
       {lastClickTime && (
         <p>Último clique: <strong>{lastClickTime}</strong></p>
       )}
     </div>
   </div>
   ```

4. **Estilizar o botão** (src/App.css)
   ```css
   .interactive-section {
     margin: 2rem 0;
     padding: 2rem;
     background: rgba(255, 255, 255, 0.1);
     border-radius: 15px;
     border: 1px solid rgba(255, 255, 255, 0.2);
   }

   .click-button {
     background: linear-gradient(45deg, #ff6b6b, #ee5a24);
     color: white;
     border: none;
     padding: 1rem 2rem;
     border-radius: 25px;
     font-size: 1.2rem;
     font-weight: 600;
     cursor: pointer;
     transition: all 0.3s ease;
     margin-bottom: 1rem;
   }

   .click-button:hover {
     transform: scale(1.05);
     box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
   }

   .click-stats p {
     margin: 0.5rem 0;
     font-size: 1.1rem;
   }
   ```

### **Entrega**
- Commit: `git commit -m "feat: adicionar contador interativo"`
- Push e teste a funcionalidade no site

---

## 🏃‍♂️ Exercício 3: Testes Automatizados (15 min)

### **Objetivo**
Adicionar testes para a nova funcionalidade.

### **Tarefas**
1. **Adicionar testes do contador** (src/App.test.js)
   ```javascript
   import { fireEvent } from '@testing-library/react';

   test('renders interactive button', () => {
     render(<App />);
     const button = screen.getByText(/Clique aqui!/i);
     expect(button).toBeInTheDocument();
   });

   test('counter increases when button is clicked', () => {
     render(<App />);
     const button = screen.getByText(/Clique aqui!/i);
     
     // Clicar no botão
     fireEvent.click(button);
     
     // Verificar se o contador aumentou
     const counter = screen.getByText(/Total de cliques: 1/i);
     expect(counter).toBeInTheDocument();
   });

   test('displays last click time after clicking', () => {
     render(<App />);
     const button = screen.getByText(/Clique aqui!/i);
     
     fireEvent.click(button);
     
     const lastClick = screen.getByText(/Último clique:/i);
     expect(lastClick).toBeInTheDocument();
   });
   ```

2. **Executar testes localmente**
   ```bash
   npm test -- --coverage --watchAll=false
   ```

### **Entrega**
- Commit: `git commit -m "test: adicionar testes do contador"`
- Verificar se os testes passam no GitHub Actions

---

## 🏃‍♂️ Exercício 4: Componente Personalizado (25 min)

### **Objetivo**
Criar um componente separado para exibir informações do aluno.

### **Tarefas**
1. **Criar componente StudentInfo** (src/components/StudentInfo.js)
   ```javascript
   import React from 'react';
   import './StudentInfo.css';

   const StudentInfo = ({ name, course, semester, rm }) => {
     return (
       <div className="student-info">
         <h4>👨‍🎓 Informações do Aluno</h4>
         <div className="student-details">
           <div className="detail-item">
             <span className="label">Nome:</span>
             <span className="value">{name}</span>
           </div>
           <div className="detail-item">
             <span className="label">Curso:</span>
             <span className="value">{course}</span>
           </div>
           <div className="detail-item">
             <span className="label">Semestre:</span>
             <span className="value">{semester}</span>
           </div>
           <div className="detail-item">
             <span className="label">RM:</span>
             <span className="value">{rm}</span>
           </div>
         </div>
       </div>
     );
   };

   export default StudentInfo;
   ```

2. **Criar estilos** (src/components/StudentInfo.css)
   ```css
   .student-info {
     background: rgba(255, 255, 255, 0.15);
     backdrop-filter: blur(10px);
     border-radius: 20px;
     padding: 2rem;
     margin: 2rem 0;
     border: 1px solid rgba(255, 255, 255, 0.3);
   }

   .student-info h4 {
     margin-bottom: 1.5rem;
     font-size: 1.3rem;
     text-align: center;
   }

   .student-details {
     display: grid;
     gap: 1rem;
   }

   .detail-item {
     display: flex;
     justify-content: space-between;
     align-items: center;
     padding: 0.8rem;
     background: rgba(255, 255, 255, 0.1);
     border-radius: 10px;
   }

   .label {
     font-weight: 600;
     opacity: 0.9;
   }

   .value {
     font-weight: 500;
     color: #fff;
   }
   ```

3. **Usar o componente** (src/App.js)
   ```javascript
   // Importar no topo
   import StudentInfo from './components/StudentInfo';

   // Adicionar após a seção interativa:
   <StudentInfo 
     name="[SEU NOME COMPLETO]"
     course="DevOps e Arquitetura Cloud"
     semester="1º Semestre 2024"
     rm="[SEU RM]"
   />
   ```

4. **Criar pasta components**
   ```bash
   mkdir src/components
   ```

### **Entrega**
- Commit: `git commit -m "feat: adicionar componente StudentInfo"`
- Verificar renderização no site

---

## 🏃‍♂️ Exercício 5: Variáveis de Ambiente (10 min)

### **Objetivo**
Usar variáveis de ambiente para configurações dinâmicas.

### **Tarefas**
1. **Criar arquivo .env.local**
   ```env
   REACT_APP_STUDENT_NAME=Seu Nome Aqui
   REACT_APP_STUDENT_RM=RM12345
   REACT_APP_GITHUB_USERNAME=seu-usuario
   ```

2. **Usar variáveis no componente**
   ```javascript
   // Em src/App.js, substituir valores fixos:
   <StudentInfo 
     name={process.env.REACT_APP_STUDENT_NAME || "Nome não configurado"}
     course="DevOps e Arquitetura Cloud"
     semester="1º Semestre 2024"
     rm={process.env.REACT_APP_STUDENT_RM || "RM não configurado"}
   />
   ```

3. **Adicionar link do GitHub**
   ```javascript
   // Adicionar nos links:
   <a 
     href={`https://github.com/${process.env.REACT_APP_GITHUB_USERNAME}`}
     target="_blank" 
     rel="noopener noreferrer"
     className="github-link"
   >
     Meu GitHub 🐙
   </a>
   ```

### **Entrega**
- Commit: `git commit -m "feat: configurar variáveis de ambiente"`
- Testar localmente antes do push

---

## 🏆 Desafio Extra: Pipeline Avançado (30 min)

### **Objetivo**
Implementar melhorias no pipeline de CI/CD.

### **Tarefas Avançadas**

1. **Adicionar notificação de deploy**
   ```yaml
   # Em .github/workflows/deploy.yml, adicionar job:
   notify:
     runs-on: ubuntu-latest
     needs: deploy
     if: always()
     steps:
     - name: Notify deployment status
       run: |
         if [ "${{ needs.deploy.result }}" == "success" ]; then
           echo "✅ Deploy realizado com sucesso!"
           echo "🌐 Site: http://${{ secrets.S3_BUCKET_NAME }}.s3-website-us-east-1.amazonaws.com"
         else
           echo "❌ Deploy falhou!"
         fi
   ```

2. **Adicionar cache de dependências**
   ```yaml
   # Melhorar o job de build:
   - name: Cache node modules
     uses: actions/cache@v3
     with:
       path: ~/.npm
       key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
       restore-keys: |
         ${{ runner.os }}-node-
   ```

3. **Adicionar verificação de qualidade**
   ```yaml
   # Novo job antes do build:
   lint:
     runs-on: ubuntu-latest
     steps:
     - uses: actions/checkout@v4
     - uses: actions/setup-node@v4
       with:
         node-version: '18'
         cache: 'npm'
     - run: npm ci
     - run: npm run lint --if-present
   ```

### **Entrega**
- Commit: `git commit -m "feat: melhorar pipeline CI/CD"`
- Documentar as melhorias implementadas

---

## 📊 Critérios de Avaliação

### **Exercício 1-2: Básico (60 pontos)**
- ✅ Site personalizado funcionando
- ✅ Pipeline executando sem erros
- ✅ Funcionalidade interativa implementada

### **Exercício 3-4: Intermediário (30 pontos)**
- ✅ Testes passando
- ✅ Componente personalizado criado
- ✅ Código bem estruturado

### **Exercício 5 + Desafio: Avançado (10 pontos)**
- ✅ Variáveis de ambiente configuradas
- ✅ Melhorias no pipeline implementadas
- ✅ Documentação das alterações

---

## 🎯 Dicas de Sucesso

### **Boas Práticas**
- Faça commits pequenos e frequentes
- Use mensagens de commit descritivas
- Teste localmente antes do push
- Acompanhe os logs do GitHub Actions

### **Troubleshooting**
- Se o pipeline falhar, verifique os logs
- Teste a aplicação localmente: `npm start`
- Execute os testes: `npm test`
- Verifique a sintaxe do código

### **Recursos Úteis**
- [React Documentation](https://reactjs.org/docs/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [AWS S3 Static Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

---

**🚀 Mãos à obra! Boa sorte nos exercícios! 🎓**
