# Docker for Laravel

Este repositório é um ambiente Docker projetado para simplificar o desenvolvimento, teste e produção de aplicações Laravel. Ele oferece uma estrutura robusta para criar ambientes isolados, suportando GitHub Actions e Kubernetes para automação e escalabilidade.

---

## Estrutura do Repositório

Abaixo estão os arquivos e diretórios presentes no repositório, com uma explicação detalhada sobre o objetivo de cada um.

### Diretório `.github/workflows`

Este diretório contém os workflows do GitHub Actions para CI/CD e deploy automatizado:

- **ci-cd.yaml**: Configuração para execução de testes e verificações no código a cada commit ou PR.
- **deploy-prod.yaml**: Workflow para realizar o deploy no ambiente de produção usando Kubernetes.
- **deploy-test.yaml**: Workflow para realizar o deploy no ambiente de teste.

### Diretório `docker`

Contém configurações Docker para PHP e NGINX.

#### Subdiretório `nginx`

- **default.dev.conf**: Configuração do NGINX para o ambiente de desenvolvimento.
- **default.prod.conf**: Configuração do NGINX para o ambiente de produção.

#### Subdiretório `php`

- **php.dev.Dockerfile**: Dockerfile para construir a imagem PHP no ambiente de desenvolvimento.
- **php.prod.Dockerfile**: Dockerfile para construir a imagem PHP no ambiente de produção, incluindo otimizações para desempenho e segurança.
- **www.conf**: Configuração padrão do PHP-FPM compartilhada entre os ambientes.
- **www.dev.conf**: Configuração personalizada do PHP-FPM para desenvolvimento.

### Diretório `k8s`

Contém configurações para implantação no Kubernetes.

#### Subdiretório `dev`

- **deployment.yaml**: Configuração de implantação para o ambiente de desenvolvimento.
- **ingress.yaml**: Configuração do ingress para rotação de tráfego.
- **persistentvolumeclaim.yaml**: Configuração de volume persistente para o armazenamento.
- **service.yaml**: Configuração de serviço para expor o aplicativo.

#### Subdiretório `test`

- **deployment.yaml**: Configuração de implantação para o ambiente de teste.
- **ingress.yaml**: Configuração do ingress para rotação de tráfego.
- **persistentvolumeclaim.yaml**: Configuração de volume persistente para o armazenamento.
- **service.yaml**: Configuração de serviço para expor o aplicativo.

#### Subdiretório `prod`

- **deployment.yaml**: Configuração de implantação para o ambiente de produção.
- **ingress.yaml**: Configuração do ingress para rotação de tráfego.
- **persistentvolumeclaim.yaml**: Configuração de volume persistente para o armazenamento.
- **service.yaml**: Configuração de serviço para expor o aplicativo.

### Arquivos na raiz

- **.env.example**: Arquivo de exemplo para variáveis de ambiente usadas no projeto.
- **docker-compose.dev.yml**: Configuração do Docker Compose para o ambiente de desenvolvimento.
- **docker-compose.prod.yml**: Configuração do Docker Compose para o ambiente de produção.

---

## Como Implementar em Projetos Laravel

Abaixo estão os passos detalhados para implementar este ambiente Docker em um projeto Laravel.

### 1. Clone este Repositório

Clone o repositório diretamente dentro do seu projeto Laravel:

```bash
cd seu-projeto-laravel
git clone https://github.com/FlavioMoreir4/docker-for-laravel docker-setup
```

### 2. Movendo os Arquivos para a Raiz

Mova todos os arquivos e pastas da pasta clonada para a raiz do seu projeto:

```bash
mv docker-setup/* ./ && mv docker-setup/.* ./ && rmdir docker-setup
```

### 3. Ajuste do Arquivo `.env`

Copie o arquivo `.env.example` e ajuste as variáveis de ambiente conforme o seu projeto:

```bash
cp .env.example .env
```

### 4. Suba os Contêiners

Para o ambiente de desenvolvimento:

```bash
docker-compose -f docker-compose.dev.yml up -d
```

Para o ambiente de produção:

```bash
docker-compose -f docker-compose.prod.yml up -d
```

### 5. Verifique os Contêiners

Confira se os contêineres estão rodando corretamente:

```bash
docker ps
```

### 6. Deploy com Kubernetes

Use as configurações no diretório `k8s/` para criar ambientes em Kubernetes:

```bash
kubectl apply -f k8s/dev/  # Para desenvolvimento
kubectl apply -f k8s/test/ # Para teste
kubectl apply -f k8s/prod/ # Para produção
```

### 7. Configuração CI/CD

Certifique-se de que os workflows do GitHub Actions em `.github/workflows` estão configurados para o seu repositório. Ajuste os arquivos YAML conforme o seu ambiente e requisitos de deploy.

---

## Contribuições

Fique à vontade para abrir issues ou enviar PRs com melhorias ou correções para este repositório.

<!-- ## Licença

Este projeto está sob a licença MIT. Consulte o arquivo LICENSE para mais informações. -->
