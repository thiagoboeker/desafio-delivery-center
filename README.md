# DesafioDc

Para o Desafio Delivery Center, proposto em
[Desafio Delivery Center](https://bitbucket.org/delivery_center/test-dev-backend-elixir/src/master/). Eu decidi trabalhar primariamente com embeddeds schemas para validacao de dados.

O escopo do desafio é relativamente simples entao existem alguns pontos que gostaria de destacar.

## Integracao com API Externa

No desafio esta pedindo para fazer chamadas constantes para uma API externa. Quando preciso integrar API's externas em meus projetos eu geralmente gosto de trabalhar com pooling. Como por exemplo a [Poolboy](https://hex.pm/packages/poolboy). O motivo é bem simples, eu como cliente nao quero sobrecarregar o meu serviço. E atraves do pooling eu tenho um maior controle sobre a _*Responsividade*_ do meu serviço, pois alem de poder limitar a carga simultanea para o meu serviço externo, eu posso agir mais raspido em falhas generalizadas, ou até mesmo parar o serviço totalmente para evitar quaisquer efeitos colaterais adicionais que poderiam ser causados. Como descrito no [Manifesto Reativo](https://www.reactivemanifesto.org/pt-BR).

>   O sistema responde em um tempo razoável, se possível. Responsividade é a pedra fundamental da usabilidade e da utilidade, mas, mais do que isso, responsividade significa que problemas podem ser detectados rapidamente e tratados com a máxima eficácia. Sistemas responsivos têm como objetivo prover tempos de resposta curtos e consistentes, estabelecendo margens de tolerância confiáveis que garantem uma qualidade de serviço consistente

Eu tento seguir sempre esse principio, nós descendentes do Erlang e utilizadores da BEAM, o nosso problema nao se trata de startar processos de forma concorrente pois isso nós fazemos muito facilmente. Nosso desafio maior é saber limitar esse fator de forma eficiente para gerar um sistema responsivo e resiliente.

## Testes

Bom, eu escrevi poucas unidades de testes pois estava sem criatividade para casos de testes nesse escopo de projeto. Eu desenvolvo 100% orientado a testes de forma iterativa. Em escopos maiores ou mais complexos gosto muito de implementar se possivel Property-Based Testing.

## Validade do Schema

Eu segui a documentacao descrita no comando, entao apesar de haver coisas que eu nao
concorde quanto ao formato do schema de dados da ordem. Resolvi seguir 100% pois ja fui
prejudicado em outros processos por sair do comando do desafio.

## Organizacao do Codigo

Eu organizo um pouco diferente em relacao a o que o Phoenix propoe. A razao é bem simples,
o Phoenix atraves do proprios geradores propoe uma organizacao generalista com DDD, o que para
projetos maiores pode ajudar bastante... para outros projetos na minha opinião pode vir a atraplhar.
Mas ainda sim mantenho a organizcao bem simples em relacao a diretorios e arquivos.

## Conclusao

É isso, aguardo o feedback do pessoal da Delivery Center! :)
