# Deploy Multi-Container com Kubernetes (Frontend + Backend + Database)

Este projeto tem como **foco principal o Kubernetes**, demonstrando como realizar o **deploy de uma aplicação multi-container** (frontend, backend e banco de dados) em um ambiente orquestrado.

O objetivo é aplicar conceitos fundamentais de **orquestração de containers**, **alta disponibilidade**, **escalabilidade** e **boas práticas DevOps**, simulando um cenário real de produção.

---

## 🎯 Objetivo do Projeto

* Demonstrar o uso do **Kubernetes** para orquestrar múltiplos serviços
* Separar responsabilidades entre frontend, backend e banco de dados
* Utilizar manifests Kubernetes para gerenciar deploy, rede e configuração
* Servir como **projeto prático para estudo, portfólio e entrevistas DevOps**

---

## 🧱 Arquitetura da Aplicação

A aplicação é composta por três camadas principais, cada uma rodando em **pods independentes** dentro do cluster Kubernetes:

* **Frontend**

  * Interface com o usuário
  * Consome a API do backend via Service

* **Backend**

  * API responsável pela regra de negócio
  * Comunica-se com o banco de dados internamente no cluster

* **Database**

  * Persistência de dados
  * Exposta apenas internamente (ClusterIP)

A comunicação entre os serviços ocorre através de **Services do Kubernetes**, sem dependência de IPs fixos.

---

## ☸️ Conceitos de Kubernetes Aplicados

* Pods
* Deployments
* Services (ClusterIP / NodePort / LoadBalancer)
* ConfigMaps
* Secrets
* Volumes e PersistentVolumeClaims
* Escalabilidade (replicas)
* Isolamento de rede

---

## 🛠️ Tecnologias Utilizadas

* **Kubernetes** – Orquestração dos containers
* **Docker** – Build das imagens
* **kubectl** – Gerenciamento do cluster
* **Frontend** – (ex: React, Vue ou HTML/CSS/JS)
* **Backend** – (ex: Node.js, Python, Java)
* **Banco de Dados** – (ex: PostgreSQL, MySQL ou MongoDB)

---

## 📁 Estrutura do Projeto

```
.
├── k8s/
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── db-deployment.yaml
│   ├── db-service.yaml
│   ├── configmap.yaml
│   └── secret.yaml
├── frontend/
│   └── Dockerfile
├── backend/
│   └── Dockerfile
└── README.md
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

* Docker
* Kubernetes (Minikube, Kind ou cluster cloud)
* kubectl configurado

### Passos

1. Clone o repositório:

   ```bash
   git clone <url-do-repositorio>
   cd deploy-multi-container
   ```

2. Build das imagens Docker:

   ```bash
   docker build -t frontend:latest ./frontend
   docker build -t backend:latest ./backend
   ```

3. Inicie o cluster (exemplo com Minikube):

   ```bash
   minikube start
   ```

4. Aplique os manifests Kubernetes:

   ```bash
   kubectl apply -f k8s/
   ```

5. Verifique os recursos:

   ```bash
   kubectl get pods
   kubectl get services
   ```

6. Acesse a aplicação:

   ```bash
   minikube service frontend-service
   ```

---

## 🔄 Comunicação Entre os Pods

* O **frontend** acessa o backend via **Service DNS**
* O **backend** conecta-se ao banco usando o nome do service
* O banco não é exposto externamente

Exemplo:

```
http://backend-service:3000
```

---

## 📈 Benefícios do Uso do Kubernetes

* Alta disponibilidade
* Escalabilidade automática
* Gerenciamento centralizado
* Resiliência a falhas
* Padrão amplamente usado em produção

---

## 📌 Possíveis Evoluções

* Horizontal Pod Autoscaler (HPA)
* Ingress Controller
* Helm Charts
* CI/CD com GitHub Actions ou GitLab CI
* Deploy em cloud (EKS, GKE, AKS)

---

## 📄 Licença

Projeto com fins educacionais, voltado ao aprendizado de Ku
