import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [deployTime, setDeployTime] = useState('');
  const [buildNumber, setBuildNumber] = useState('');

  useEffect(() => {
    setDeployTime(new Date().toLocaleString('pt-BR'));
    setBuildNumber(process.env.REACT_APP_BUILD_NUMBER || 'local');
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <div className="fiap-logo">
          <h1>FIAP</h1>
          <span>POS TECH</span>
        </div>
        
        <div className="main-content">
          <h2>DevOps e Arquitetura Cloud</h2>
          <h3>Demo de CI/CD com GitHub Actions</h3>
          
          <div className="demo-info">
            <div className="info-card">
              <h4>🚀 Pipeline Status</h4>
              <p className="status-success">Deploy Realizado com Sucesso!</p>
            </div>
            
            <div className="info-card">
              <h4>📅 Último Deploy</h4>
              <p>{deployTime}</p>
            </div>
            
            <div className="info-card">
              <h4>🔢 Build Number</h4>
              <p>#{buildNumber}</p>
            </div>
          </div>

          <div className="tech-stack">
            <h4>Stack Tecnológico</h4>
            <div className="tech-items">
              <span className="tech-item">React</span>
              <span className="tech-item">GitHub Actions</span>
              <span className="tech-item">AWS S3</span>
              <span className="tech-item">Static Hosting</span>
            </div>
          </div>

          <div className="course-info">
            <h4>Sobre o Curso</h4>
            <p>
              Este projeto demonstra a implementação de um pipeline de CI/CD 
              completo utilizando GitHub Actions para deploy automatizado 
              de aplicações estáticas no AWS S3.
            </p>
            <div className="links">
              <a 
                href="https://postech.fiap.com.br/curso/devops-e-arquitetura-cloud" 
                target="_blank" 
                rel="noopener noreferrer"
                className="course-link"
              >
                Conheça o Curso
              </a>
              <a 
                href="https://fiap.com.br" 
                target="_blank" 
                rel="noopener noreferrer"
                className="fiap-link"
              >
                FIAP.com.br
              </a>
            </div>
          </div>
        </div>

        <footer className="App-footer">
          <p>© 2024 FIAP - Faculdade de Informática e Administração Paulista</p>
          <p>Desenvolvido para fins educacionais</p>
        </footer>
      </header>
    </div>
  );
}

export default App;
