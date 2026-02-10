# salesforce-core

O **salesforce-core** é um repositório voltado para aprendizado prático em Salesforce, servindo como um ambiente de estudo contínuo, onde conceitos fundamentais da plataforma são aplicados de forma estruturada e seguindo boas práticas de desenvolvimento.

## Projetos 🧑🏻‍🔬

### Fruityvice

  Consiste na integração com a API [Fruityvice](https://www.fruityvice.com/) através do desenvolvimento de classes Apex Callout REST, Controller e testes unitários. O backend comunica-se com a UI por meio de componentes Web do Lightning. 

  > 💡 **Dica**: O arquivo `./fruityvice-xml/package.xml` contém todos os metadados necessários para realizar o deploy dessa feature em seu ambiente.
    É necessário atribuir o permission set `Grant_Fruityvice_Integration_Access` para visualizar a integração.

 **Apex e configuração**
  
>  **FruityviceService.cls**: Implementa métodos para comunicação com a API nos recursos de listagem total de frutas e listagem de fruta por Id, lançando uma exceção personalizada do tipo FruityviceException caso o endpoint retorne um status code 4xx (único possível pela documentação oficial da API) <br> <br>
> **FruityviceController.cls**: Expõe os métodos desenvolvidos na classe de serviço para o front-end através das anotações `@AuraEnabled` em cada função. Também captura as exceções FruityviceException para lançá-las novamente com uma mensagem mais amigável para UI. <br> <br>
> **FruityviceSuccessResponse** & **FruityviceErrorResponse**: Representam o JSON retornado pela API em seus respectivos cenários: sucesso e falha. Ajudam a facilitar o entendimento da response da API pela análise do código. <br> <br>
> **FruityviceServiceHttpCalloutMock** & **FruityviceServiceTest**: A classe de mock que simula as respostas da API e a classe de teste do FruityviceService, cobrindo 100% do código desenvolvido até o momento e cenários de erro. <br> <br>
> **Permission set `Grant Fruityvice Integration Access`**: Permission Set responsável por conceder acesso às classes Apex codificadas, assim como ao NamedCredential utilizado para estabelecer comunicação Apex ↔ API. <br> <br>
> **Named Credential `Fruityvice NC`**: Criação de NamedCredential que aponta para a URL base do endpoint (https://fruityvice.com/), permitindo migração de ambientes sem realizar alterações no código. 

<br>

**Lightning Web Components**

> **c-load-fruits**: Estabelece comunicação com o decorator `@wire` com o método Apex `getAllFruits` do Controller, exibindo o resultado em um lightning-combobox. Caso uma fruta tenha sido selecionada pelo layout, dispara um CustomEvent do tipo `selectfruit`. <br> <br>
> **c-detailed-fruit**: Integra-se com o `getFruitById`, também do Controller, para listar as informações detalhadas de uma determinada fruta. Utiliza-se do decorator `@api` para receber o Id a ser repassado para o Apex. <br> <br>
> **c-modal**: Modal reutilizável que implementa a [blueprint do SLDS](https://v1.lightningdesignsystem.com/components/modals/). É utilizada no componente **c-fruityvice**. <br> <br>
> **c-fruityvice**: Componente orquestrador responsável pelo encadeamento dos componentes `c-load-fruits` e `c-detailed-fruit`. Captura o evento lançado pelo primeiro componente para saber quando seguir para a próxima etapa, que é ocultar o **c-load-fruits** e exibir o **c-detailed-fruit**.

#### Vídeo demonstrativo

https://github.com/user-attachments/assets/22d6c0b6-6c90-4d93-b0ce-60152c3a10a9

<hr>

### Fluxo automatizado para solicitação de demandas

Desenvolvimento baseado em Flow para a criação de um formulário que permite que usuários comuns comuniquem-se com administradores para atendimento de chamado, centralizado para a implementação de novas funcionalidades na org.

>💡 **Dica**: O arquivo `./form-xml/package.xml` contém todos os metadados necessários para realizar o deploy dessa feature em seu ambiente.
    É necessário atribuir o permission set `Default_Access` nos usuários finais para que o Screen Flow consiga visualizar os campos do Project__c.

**Screen Flow**

> **[Project__c] Create Project Form**: Coleta as informações básicas para criação de uma solicitação. Utiliza-se de uma `Screen` para preenchimento de **Título**, **Prioridade** e **Descrição**, realizando validações, tratamento de exceções em tela e, em casos de sucesso, cria um registro do tipo Project__c com os dados fornecidos. <br>

<br>

**Record-Triggered Flow**
> **[Project__c] Assign Admin to Project**: Roda após criação ou update em um Project__c, e executa os seguintes passos:
> 1. Obtenção de um administrador válido (está ativo, possui profile = System Administrator e role = Admin)
> 2. Atribuição do administrador no registro Project__c que ativou o Flow
> 3. Coleta do email padrão da org, definido pelo standard object `OrgWideEmailAddress`
> 4. Envio de email para o usuário administrador obtido, com um body que apresenta informações da solicitação em aberto como prioridade, nome, solicitante, data de criação e data estimada de finalização, além de um link para acessar tal registro na org.

<br>

**Configurações**

> **Objeto personalizado Project__c**: Possui a seguinte estrutura de campos a seguir:
> | Campo    | Tipo de dado | Propósito |
> | -------- | ------------ | --------- |
> | Name     | Auto Number  | Número auto-increment no padrão `P-{YYYY}/{0000}` |
> | Title    | Text (255)   | Resumo do que se trata a solicitação |
> | Description | Long Text Area (32768)| Descrição detalhada sobre a solicitação, o que se espera, motivos, etc. |
> | Status    | Picklist         | O status da solicitação, podendo ser: Not Started, In Progress, On Hold, Completed ou Canceled |
> | Requested By | Lookup (User) | O usuário que demandou a solicitação |
> | Requested User Role | Formula (Text) | Campo formulá preenchido automaticamente com base na role do usuário solicitante |
> | Priority | Picklist | A prioridade da solicitação, podendo ser: Low, Medium, High ou Critical |
> | Estimated Finish Date | Formula (Date) | Com base na prioridade, recebe respectivamente D+7 (Low), D+5 (Medium), D+3 (High) ou D+1 (Critical) |
> | Admin Agent | Lookup (User) | O usuário administrador que dará andamento com a solicitação |

<br>

> **Organization-Wide Addresses**: Ferramenta do setup que configura o endereço padrão utilizado para estabelecer o envio de email. Precisa incluir um registro com o Display Name igual a `Email Padrão` (utilizado no Record-Triggered Flow) e verificar o email inserido.

#### Vídeo demonstrativo

https://github.com/user-attachments/assets/da08bb05-6a8c-4922-a5c9-2ab6d658e1e1
