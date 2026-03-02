markdown
<p align="center">
  <img src="https://via.placeholder.com" alt="Banner do Projeto">
</p>

<h1 align="center">🏗️ Construindo Infraestrutura Realista (Terraform + AWS)</h1>

<p align="center">
  <img src="https://img.shields.io" />
  <img src="https://img.shields.io" />
  <img src="https://img.shields.io" />
</p>

---

### 🎯 Por que eu criei esse projeto?
Eu queria sair do básico e provar a mim mesmo que estou pronto para **demandas reais**. Este projeto nasceu da vontade de entender como a infraestrutura é construída profissionalmente, enfrentando os desafios de um ambiente de produção real. Foi a transição do "desejo de aprender" para o "aprender fazendo".

---

### 🚀 O que este projeto faz?
Provisionamento automático na **AWS** utilizando arquitetura modular:
- 🌐 **VPC Organizada**: Com Subnets públicas e privadas.
- 💻 **Instância EC2**: Camada de processamento.
- 🐘 **RDS PostgreSQL**: Banco de dados gerenciado.
- 🔐 **IAM Role**: Controle granular de acesso.
- 🏗️ **Multi-Environment**: Separação total entre `dev`, `staging` e `prod`.

---

### 🧠 O que eu quis demonstrar aqui?
Mais do que criar recursos, este projeto reflete meu domínio em:
- **Modularização e Reutilização**: Código limpo e escalável.
- **Segurança**: Banco de dados isolado em subnets privadas.
- **Resiliência**: Configuração Multi-AZ para o ambiente de produção.
- **Resolução de Problemas**: Superação de desafios com `for_each`, dependências de módulos e outputs.

---

### 📐 Arquitetura e Ambientes


| Ambiente  | Objetivo          | Característica Principal                  |
|-----------|-------------------|-------------------------------------------|
| **dev**   | Desenvolvimento   | Estrutura simples e econômica             |
| **staging** | Testes            | Simulação fiel da produção                |
| **prod**  | Produção          | Multi-AZ para alta disponibilidade        |

**Fluxo da Infraestrutura:**
1. O módulo `network` estabelece a base (VPC/Subnets).
2. O módulo `compute` implanta a EC2 na área pública.
3. O módulo `database` isola o RDS na área privada.
4. O acesso ao banco é restrito exclusivamente à instância EC2.

---

### 📂 Estrutura do Repositório
Optei pela modularização para garantir que o projeto cresça de forma organizada.

```text
terraform/
├── modules/
│   ├── network/    # VPC, Subnets, Gateways
│   ├── iam/        # Roles e Policies
│   ├── compute/    # EC2 e Security Groups
│   └── database/   # RDS e Subnet Groups
└── environments/
    ├── dev/        # Configs de Desenvolvimento
    ├── staging/    # Configs de Homologação
    └── prod/       # Configs de Produção
Use o código com cuidado.

⚙️ Como Executar
Escolha o ambiente desejado e execute os comandos:
bash
# 1. Entre no diretório do ambiente
cd environments/dev  # ou staging / prod

# 2. Inicialize o Terraform e aplique
terraform init
terraform plan
terraform apply
Use o código com cuidado.

---

Simples. Reproduzível. Versionado.
✨ O que este projeto representa
Ele marca minha transição: de um entusiasta de DevOps para alguém que possui a competência técnica para atuar no mercado. É o reflexo do meu crescimento profissional e pessoal.