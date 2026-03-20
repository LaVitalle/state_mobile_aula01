# Atividade 05 - Respostas

## 1. O que significa gerenciamento de estado em uma aplicação Flutter?

É a forma como a gente controla e organiza os dados que podem mudar ao longo do uso do app. No Flutter, o estado é basicamente qualquer informação que influencia o que aparece na tela. Gerenciar estado significa decidir onde esses dados ficam armazenados, como eles são alterados e como a interface fica sabendo que precisa se redesenhar quando algo muda.

## 2. Por que manter o estado diretamente dentro dos widgets pode gerar problemas em aplicações maiores?

Porque conforme o app cresce, vários widgets diferentes precisam acessar ou modificar os mesmos dados. Se o estado fica preso dentro de um widget específico, a gente acaba tendo que ficar passando dados de pai pra filho por vários níveis da árvore de widgets (o famoso "prop drilling"), o que deixa o código confuso e difícil de manter. Além disso, fica complicado reaproveitar widgets e testar as coisas separadamente, já que a lógica de negócio fica misturada com a interface.

## 3. Qual é o papel do método notifyListeners() na abordagem Provider?

O `notifyListeners()` é o que avisa os widgets que estão "escutando" aquele Provider que o estado mudou. Quando a gente chama esse método dentro do `ChangeNotifier`, todos os widgets que dependem daquele dado são reconstruídos automaticamente com o valor atualizado. Sem ele, a gente poderia alterar a variável mas a tela não ia atualizar.

## 4. Qual é a principal diferença conceitual entre Provider e Riverpod?

O Provider depende da árvore de widgets e do `BuildContext` pra funcionar — os providers ficam atrelados à hierarquia de widgets. Já o Riverpod é independente da árvore de widgets, os providers são declarados como variáveis globais e podem ser acessados de qualquer lugar sem precisar do context. Isso torna o Riverpod mais flexível, com melhor suporte a compile-time safety e sem os problemas de `ProviderNotFoundException` que podem acontecer no Provider.

## 5. No padrão BLoC, por que a interface não altera diretamente o estado da aplicação?

Porque no BLoC a ideia é separar completamente a lógica de negócio da interface. A UI apenas dispara eventos dizendo "o usuário fez tal ação", e o Bloc é quem decide como processar aquilo e qual novo estado gerar. Isso garante que toda a lógica fique centralizada num lugar só, facilitando testes e manutenção, já que a interface não precisa saber como o estado é calculado.

## 6. Evento → Bloc → Novo estado → Interface. Qual é a vantagem de organizar o fluxo dessa forma?

A vantagem é ter um fluxo unidirecional e previsível. Cada ação do usuário vira um evento bem definido, o Bloc processa esse evento e emite um novo estado, e a interface só reage a esse estado. Isso facilita muito o debug porque dá pra rastrear exatamente qual evento causou qual mudança de estado. Também facilita escrever testes unitários, já que basta simular eventos e verificar se os estados emitidos estão corretos.

## 7. Qual estratégia de gerenciamento de estado foi utilizada em sua implementação?

Foi utilizado o **Riverpod**, com `StateNotifier` e `StateNotifierProvider`. Criei um `ProductNotifier` que extends `StateNotifier<ProductState>` pra gerenciar a lista de produtos e o estado dos favoritos. A página usa `ConsumerWidget` e acessa o estado com `ref.watch()` para escutar mudanças e `ref.read()` para disparar ações.

## 8. Durante a implementação, quais foram as principais dificuldades encontradas?

A principal dificuldade foi entender como o Riverpod lida com a imutabilidade do estado. No começo tentei alterar o produto diretamente e a tela não atualizava, porque o `StateNotifier` só notifica mudanças quando o `state` recebe uma nova referência. Tive que usar o `copyWith` no estado e criar uma nova lista pra que o Riverpod detectasse a mudança. Fora isso, foi um pouco confuso no início diferenciar quando usar `ref.watch()` e `ref.read()`, mas depois de entender que o `watch` é pra escutar e o `read` pra ações pontuais, ficou tranquilo.
