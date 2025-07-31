
# 💬 Projeto Fullstack com PHP, MySQL, Docker e Kubernetes

Este projeto é uma aplicação fullstack simples que permite o envio de mensagens através de um formulário web. Os dados são processados por um backend em PHP e armazenados em um banco de dados MySQL. O deploy é feito usando **Docker** e **Kubernetes**.

---

## 🧱 Estrutura do Projeto

```
.
├── backend/               # Backend PHP + Apache
│   ├── conexao.php
│   ├── index.php
│   └── Dockerfile
├── database/              # Banco de dados MySQL
│   ├── sql.sql
│   └── Dockerfile
├── frontend/              # Formulário web (HTML, CSS, JS)
│   ├── index.html
│   ├── css.css
│   └── js.js
├── deployment.yml         # Deploy de containers no Kubernetes
├── services.yml           # Serviços LoadBalancer e ClusterIP
├── script.sh              # Script para Linux/macOS
└── script.bat             # Script para Windows
```

---

## 🎯 Funcionalidade

- Enviar mensagens com nome, e-mail e comentário via formulário web.
- Armazenar os dados em uma tabela MySQL (`mensagens`).
- Backend recebe as requisições via `POST` e insere os dados no banco.
- Email com chave única (não aceita duplicados).
- Interface responsiva com AJAX para envio sem recarregar a página.

---

## 🚀 Tecnologias Utilizadas

- **Frontend**: HTML, CSS, JavaScript (jQuery)
- **Backend**: PHP 7.4 com Apache
- **Banco de Dados**: MySQL 5.7
- **Contêineres**: Docker
- **Orquestração**: Kubernetes
- **Scripts de Automação**: Bash e Batch

---

## 🐳 Imagens Docker

- `lucas/projeto-backend:1.0` – Container do backend PHP
- `lucas/projeto-database:1.0` – Container do banco de dados com script de criação da tabela

---

## 📦 Backend

### 📄 `index.php`
Recebe os dados via POST (`nome`, `email`, `comentario`) e insere na tabela `mensagens`.

### 📄 `conexao.php`
Faz a conexão com o banco de dados MySQL utilizando o hostname `mysql-connection`.

### 📄 `Dockerfile`
Cria a imagem PHP + Apache com as extensões necessárias:
- `mysqli`
- `pdo_mysql`
- `gd`

---

## 🛢️ Database

### 📄 `sql.sql`
Cria a base de dados `meubanco` e a tabela `mensagens`:

```sql
CREATE TABLE mensagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    comentario VARCHAR(100) NOT NULL
);
```

### 📄 `Dockerfile`
Baseado em `mysql:5.7`, inicializa a base com o script SQL acima.

---

## 🎨 Frontend

### 📄 `index.html`
Formulário web com campos:
- Nome
- Email
- Comentário

Usa `AJAX` para enviar os dados para o backend sem recarregar a página.

### 📄 `css.css`
Estiliza o formulário com ícones e responsividade.

### 📄 `js.js`
Faz a requisição AJAX ao backend:

```js
$.ajax({
    url: "http://<IP-DO-BACKEND>", // <-- Substitua pelo IP real
    type: "post",
    data: {
        nome: txt_nome,
        email: txt_email,
        comentario: txt_comentario
    },
    beforeSend: function() {
        console.log("Tentando enviar os dados....");
    }
}).done(function(e) {
    alert("Dados Salvos");
});
```

> ⚠️ **Importante:** após o deploy, edite o campo `url` com o IP externo do serviço `php`.

---

## ⚙️ Deploy no Kubernetes

### 📄 `services.yml`

- Cria um **LoadBalancer** para o serviço PHP (porta 80).
- Cria um serviço **ClusterIP** estático (`mysql-connection`) para o banco.

### 📄 `deployment.yml`

- Cria um **Deployment** para o MySQL com volume persistente.
- Cria um **Deployment** replicado (6 réplicas) para o backend PHP.

---

## 🔄 Scripts de Automação

### 📄 `script.sh` (Linux/macOS)

```bash
./script.sh
```

### 📄 `script.bat` (Windows)

```cmd
script.bat
```

Ambos os scripts realizam as seguintes etapas:

1. Build das imagens Docker (`backend` e `database`)
2. Push para o DockerHub
3. Aplicação dos serviços (`services.yml`)
4. Aplicação dos deployments (`deployment.yml`)

---

## 🌐 Acesso à Aplicação

1. Execute o script para criar as imagens e aplicar os manifestos:

   ```bash
   ./script.sh
   ```

2. Descubra o IP externo do serviço `php`:

   ```bash
   kubectl get svc php
   ```

3. Abra o `index.html` da pasta `frontend` no navegador.

4. No arquivo `js.js`, substitua o valor de `url` pela URL real:

   ```js
   url: "http://<IP-DO-LOADBALANCER>"
   ```

5. Envie uma mensagem e verifique o alerta de sucesso.

---

## ✅ Resultado Esperado

- Os dados preenchidos no formulário são enviados via AJAX.
- O backend insere os dados no banco de forma segura.
- E-mails duplicados são rejeitados pelo banco.
- O feedback visual é imediato ao usuário.

---

## 🔧 Melhorias Futuras

- Adicionar validações no frontend e backend.
- Criar um painel para visualizar as mensagens salvas.
- Adicionar autenticação no envio de dados.
- Persistência de logs e métricas.

---

## 🧑‍💻 Autor

Desenvolvido por **Lucas** como estudo prático de desenvolvimento fullstack com Docker e Kubernetes.
