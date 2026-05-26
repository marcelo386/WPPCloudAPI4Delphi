# WPPCloudAPI4Delphi

![Delphi](https://img.shields.io/badge/Delphi-Compatible-red)
![WhatsApp Cloud API](https://img.shields.io/badge/WhatsApp-Cloud%20API-25D366)
![RESTRequest4Delphi](https://img.shields.io/badge/RESTRequest4Delphi-Compatible-blue)
![Horse](https://img.shields.io/badge/Horse-Compatible-orange)

Componente Delphi para integração com a **API Oficial do WhatsApp Cloud API**.

O projeto **WPPCloudAPI4Delphi** foi desenvolvido para facilitar a comunicação entre aplicações Delphi e a API oficial da Meta, permitindo criar integrações para envio e recebimento de mensagens pelo WhatsApp de forma oficial, segura e organizada.

---

## 🚀 Principais Características

- Integração com a API Oficial do WhatsApp Cloud API
- Estrutura de componente para Delphi
- Suporte ao uso com RESTRequest4Delphi
- Compatível com projetos utilizando Horse
- Instalação via package `.dpk`
- Organização simples para adicionar ao Library Path
- Ideal para aplicações desktop, serviços e APIs desenvolvidas em Delphi

---

## 📦 Dependências

Antes de instalar o componente, é necessário baixar as bibliotecas abaixo:

| Biblioteca | Link |
|---|---|
| RESTRequest4Delphi | https://github.com/viniciussanchez/RESTRequest4Delphi.git |
| Dataset Serialize | https://github.com/viniciussanchez/dataset-serialize.git |
| Horse | https://github.com/HashLoad/horse.git |

---

## 💬 Comunidade

Participe do grupo no WhatsApp para dúvidas, sugestões, atualizações e troca de experiências:

```text
https://chat.whatsapp.com/BTyTXQSCdpcHVTanpDGBTv?mode=ems_copy_t
```

---

## ⚙️ Configuração do Library Path

Adicione os diretórios abaixo no **Library Path** do Delphi:

```text
...\horse.git\tags\v2.0.14\src
...\RESTRequest4Delphi.git\tags\v3.0.19\src
...\dataset-serialize.git\tags\v2.4.8\src
...\WPPCloudAPI4Delphi\Source
```

> Ajuste os caminhos conforme o local onde os projetos foram baixados em sua máquina.

---

## 🛠️ Como Instalar

Abra o package do componente no Delphi:

```text
...\WPPCloudAPI4Delphi\Packages\WPPCloudAPI4Delphi.dpk
```

Depois execute no Delphi:

1. **Compile**
2. **Install**

Após a instalação, o componente estará disponível para uso no Delphi.

---

## ⚠️ Ajuste Necessário no WebBroker

Para evitar erro de compilação ao utilizar o Horse em package, pode ser necessário realizar um ajuste na unit `Web.WebBroker.pas`.

Esse ajuste consiste em copiar a unit original do Delphi para a pasta `src` do Horse e comentar a diretiva `{$DENYPACKAGEUNIT}`.

---

### 1. Localize a unit original do Delphi

```text
C:\Program Files (x86)\Embarcadero\Studio\20.0\source\internet\Web.WebBroker.pas
```

---

### 2. Copie a unit para a pasta `src` do Horse

Exemplo:

```text
...\horse.git\tags\v2.0.14\src
```

---

### 3. Abra a unit copiada e localize a linha abaixo

```pascal
{$DENYPACKAGEUNIT}
```

---

### 4. Comente a diretiva

Deixe assim:

```pascal
// {$DENYPACKAGEUNIT}
```

Esse ajuste permite que a unit seja utilizada corretamente dentro do package.

---

## 🖼️ Imagens de Apoio

### Ajuste na unit `Web.WebBroker.pas`

![Ajuste WebBroker](https://user-images.githubusercontent.com/69150213/222624501-b374489c-f198-4de7-98b0-75b2768e2406.jpeg)

---

### Comentando a diretiva `DENYPACKAGEUNIT`

![Comentando DENYPACKAGEUNIT](https://user-images.githubusercontent.com/69150213/222625763-04dcbb6a-efa8-4bb7-8ddf-849c426a8992.jpeg)

---

## 📁 Estrutura Básica do Projeto

```text
WPPCloudAPI4Delphi
├── Packages
│   └── WPPCloudAPI4Delphi.dpk
├── Source
│   └── Units do componente
└── README.md
```

---

## ✅ Checklist de Instalação

- [ ] Baixar o RESTRequest4Delphi
- [ ] Baixar o Dataset Serialize
- [ ] Baixar o Horse
- [ ] Configurar o Library Path no Delphi
- [ ] Copiar `Web.WebBroker.pas` para a pasta `src` do Horse
- [ ] Comentar a diretiva `{$DENYPACKAGEUNIT}`
- [ ] Abrir o package `WPPCloudAPI4Delphi.dpk`
- [ ] Compilar o package
- [ ] Instalar o componente

---

## 📲 Sobre a WhatsApp Cloud API

A **WhatsApp Cloud API** é a API oficial da Meta para integração com o WhatsApp Business Platform.

Com ela, é possível enviar e receber mensagens de forma oficial, utilizando recursos da plataforma como:

- Mensagens de texto
- Templates aprovados
- Mensagens com mídia
- Webhooks
- Integração com sistemas externos
- Comunicação automatizada com clientes

---

## 📄 Licença

MIT license

Exemplo:

```text
MIT
```

---

## 👨‍💻 Autor

Projeto desenvolvido para facilitar o uso da **WhatsApp Cloud API Oficial** em aplicações Delphi.

---

## ⭐ Contribuição

Sugestões, melhorias e contribuições são bem-vindas.

Caso encontre algum problema, abra uma issue no repositório ou participe do grupo da comunidade no WhatsApp.

---

## 📌 Observação

Este projeto utiliza bibliotecas de terceiros. Verifique as respectivas licenças e documentações oficiais dos projetos dependentes antes de utilizar em produção.
