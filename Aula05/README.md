# 🏥 Lab de Banco de Dados: O Caso da Clínica Médica "HealthTech"

Bem-vindo ao laboratório prático de normalização! Neste desafio, você atuará como um DBA responsável por modernizar o sistema legado de uma clínica médica.

## 🎯 Objetivo
O objetivo deste laboratório é aplicar as técnicas de **Normalização de Dados** em um esquema "sujo" extraído de um sistema legado, garantindo que a nova estrutura atenda aos requisitos de **1NF, 2NF e 3NF**.

---

## 📝 O Cenário
Atualmente, todos os dados da clínica estão consolidados em uma única tabela gigante chamada `Relatorio_Geral_Consultas`. 

### Estrutura Atual (Tabela Não Normalizada):
|------------------------|------------------------------------|
| Campo                  | Descrição                          |
|------------------------|------------------------------------|
| `ID_Consulta`          | Identificador único da consulta    |
| `Data` / `Hora`        | Momento do atendimento             |
| `CPF_Paciente`         | Documento do paciente              |
| `Nome_Paciente`        | Nome completo do paciente          |
| `Telefone_Paciente`    | Contato do paciente                |
| `CRM_Medico`           | Registro profissional do médico    |
| `Nome_Medico`          | Nome completo do médico            |
| `Especialidade_Medico` | Área de atuação do médico          |
| `Valor_Consulta`       | Preço cobrado pelo atendimento     |
| `ID_Convenio`          | Identificador do convênio          |
| `Nome_Convenio`        | Nome da operadora de saúde         |
|------------------------|------------------------------------|

---

## 🛠️ Tarefas (Trabalho Final)

### 1. Identificação de Problemas
- **Anomalias:** Liste 2 exemplos de anomalias (inserção, exclusão ou alteração) que podem ocorrer nesta tabela única.
- **Dependências Funcionais:** Identifique as dependências. *Exemplo: O `ID_Convenio` determina o `Nome_Convenio`?*

### 2. Normalização Passo a Passo
Demonstre a evolução do banco de dados em cada etapa:
- **Passo 1:** Demonstre como a tabela ficaria na **1NF**.
- **Passo 2:** Aplique a **2NF** (removendo dependências parciais).
- **Passo 3:** Aplique a **3NF** (removendo dependências transitivas).

### 3. Modelagem Final
- **MER:** Crie o MER.
- **Modelo Lógico:** Desenhe o Modelo Lógico.
- **Script SQL:** Escreva o script DDL (`CREATE TABLE`) para a estrutura normalizada, definindo corretamente as Chaves Primárias (**PK**) e Estrangeiras (**FK**).

---

## 📤 Entrega
Para concluir este lab, siga os passos abaixo:
1. Crie um repositório no seu **GitHub**.
2. Suba o arquivo `projeto_normalizado.sql` com os comandos de criação.
3. Inclua uma imagem ou PDF do seu **Diagrama (DER) e Modelo Logico** na pasta raiz.
4. Edite o arquivo `README.md` do seu repositório com as respostas das questões teóricas (Tarefa 1).

---

## 💡 Dica de Ouro
Ao lidar com a **2NF**, lembre-se: se você tem uma chave primária composta, todos os outros campos devem depender da **chave inteira**. Se um campo depende apenas de "metade" da chave, ele está no lugar errado!

---
*Este laboratório faz parte da disciplina de Modelagem de Bancos de Dados Relacionais.*