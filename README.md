# 🚀 terraform-aws-ec2-pipe-github

[![Terraform](https://img.shields.io/badge/Terraform-v1.x-blueviolet?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EC2-orange?logo=amazon-aws)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-blue?logo=github)](https://github.com/features/actions)

Este repositório contém um código **Terraform** para criar **duas instâncias EC2** em **duas regiões diferentes da AWS**, utilizando **GitHub Actions** para automação do deploy.

🔗 **Repositório:** [terraform-aws-ec2-pipe-github](https://github.com/dannielvroque/terraform-aws-ec2-pipe-github)

---

## 🏗️ **Arquitetura**

📌 **Recursos Criados:**
- **2 instâncias EC2** em **duas regiões diferentes** da AWS.
- Configuração automática de rede, segurança e instâncias.
- **Deploy automatizado** com **GitHub Actions**.
- **Botão para destruir a infraestrutura** diretamente no GitHub Actions.

📌 **Fluxo do Deploy:**
1️⃣ O código Terraform é enviado para o GitHub.  
2️⃣ O **GitHub Actions** executa o `terraform apply`.  
3️⃣ As instâncias EC2 são criadas em **duas regiões diferentes** da AWS.  
4️⃣ O pipeline retorna os **IPs das EC2** criadas.

---

## 📂 **Estrutura do Repositório**

```bash
terraform-aws-ec2-pipe-github/
│── .github/workflows/terraform-ci.yml   # Pipeline de deploy no GitHub Actions
│── .github/workflows/destroy.yml       # Pipeline para destruir a infraestrutura
│── main.tf                              # Código Terraform principal
│── variables.tf                         # Variáveis do Terraform
│── outputs.tf                           # Saídas do Terraform
│── README.md                            # Documentação
│── backend.tf                           # Nome do bucket usado para armazenar o tfstate



Entendi! Para facilitar, vou fornecer o conteúdo em formato markdown que você pode copiar e colar diretamente no seu arquivo `README.md`. Basta copiar o conteúdo abaixo e colocar no seu repositório:

```markdown
# 🚀 terraform-aws-ec2-pipe-github

[![Terraform](https://img.shields.io/badge/Terraform-v1.x-blueviolet?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EC2-orange?logo=amazon-aws)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-blue?logo=github)](https://github.com/features/actions)

Este repositório contém um código **Terraform** para criar **duas instâncias EC2** em **duas regiões diferentes da AWS**, utilizando **GitHub Actions** para automação do deploy.

🔗 **Repositório:** [terraform-aws-ec2-pipe-github](https://github.com/dannielvroque/terraform-aws-ec2-pipe-github)

---

## 🏗️ **Arquitetura**

📌 **Recursos Criados:**
- **2 instâncias EC2** em **duas regiões diferentes** da AWS.
- Configuração automática de rede, segurança e instâncias.
- **Deploy automatizado** com **GitHub Actions**.
- **Botão para destruir a infraestrutura** diretamente no GitHub Actions.

📌 **Fluxo do Deploy:**
1️⃣ O código Terraform é enviado para o GitHub.  
2️⃣ O **GitHub Actions** executa o `terraform apply`.  
3️⃣ As instâncias EC2 são criadas em **duas regiões diferentes** da AWS.  
4️⃣ O pipeline retorna os **IPs das EC2** criadas.

---

## 📂 **Estrutura do Repositório**

```bash
terraform-aws-ec2-pipe-github/
│── .github/workflows/terraform-ci.yml   # Pipeline de deploy no GitHub Actions
│── .github/workflows/destroy.yml       # Pipeline para destruir a infraestrutura
│── main.tf                              # Código Terraform principal
│── variables.tf                         # Variáveis do Terraform
│── outputs.tf                           # Saídas do Terraform
│── README.md                            # Documentação
│── backend.tf                           # Nome do bucket usado para armazenar o tfstate
```

---

## 🚀 **Como Usar**

### 🔹 **1. Configurar as Credenciais da AWS**
Antes de rodar o Terraform, configure suas credenciais AWS:

```bash
aws configure
```

Ou defina as variáveis de ambiente:

```bash
export AWS_ACCESS_KEY_ID="SUA_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="SUA_SECRET_KEY"
export AWS_REGION="us-east-1"
```

### 🔹 **2. Inicializar o Terraform**

Execute o comando abaixo para inicializar o Terraform:

```bash
terraform init
```

### 🔹 **3. Criar o Plano de Execução**

Verifique o que será feito com o comando:

```bash
terraform plan
```

### 🔹 **4. Aplicar as Mudanças**

Crie os recursos na AWS com o comando:

```bash
terraform apply -auto-approve
```

---

## ⚡ **Automação com GitHub Actions**

O deploy é automatizado usando **GitHub Actions**. O arquivo `.github/workflows/terraform-ci.yml` define o pipeline de deploy.

### 📌 **Passos do pipeline:**
1. **Configuração do ambiente.**
2. **Instalação do Terraform.**
3. **Execução do `terraform apply`** para criar os recursos.

---

## ❌ **Destruir a Infraestrutura**

Se quiser remover os recursos criados, o GitHub Actions possui um botão para **destruir a infraestrutura automaticamente**. 

Clique no botão abaixo para executar o workflow de **destroy**:

[![Destruir Infraestrutura](https://github.com/dannielvroque/terraform-aws-ec2-pipe-github/actions/workflows/destroy.yml/badge.svg)](https://github.com/dannielvroque/terraform-aws-ec2-pipe-github/actions/workflows/destroy.yml)

Ou execute manualmente o comando:

```bash
terraform destroy -auto-approve
```

---

## 📜 **Licença**

Este projeto está sob a licença **MIT**. Veja mais detalhes em [LICENSE](LICENSE).

---

## ✉️ **Contato**

Criado por **[Danniel V. Roque](https://github.com/dannielvroque/)**.  
Se tiver dúvidas ou sugestões, **abra uma issue** ou entre em contato! 🚀

---

### **Como funciona o botão de Destroy?**
O botão de **destroy** é um workflow configurado no **GitHub Actions**. Para isso, é necessário o arquivo `destroy.yml` dentro do diretório `.github/workflows/`, conforme o exemplo abaixo:

📌 **`.github/workflows/destroy.yml`**

```yaml
name: Destroy Infrastructure

on:
  workflow_dispatch:  # Permite rodar manualmente pelo GitHub Actions

jobs:
  destroy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout do código
        uses: actions/checkout@v3

      - name: Configurar AWS Credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Instalar Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Inicializar Terraform
        run: terraform init

      - name: Executar Terraform Destroy
        run: terraform destroy -auto-approve
```

Agora, o botão de **destroy** aparecerá no GitHub Actions, e você poderá **destruir a infraestrutura com um clique**! 💥
```

---

Agora, você pode **copiar** e **colar** o conteúdo acima diretamente no seu arquivo `README.md` no seu repositório. Assim ele estará formatado corretamente para visualização no GitHub!
