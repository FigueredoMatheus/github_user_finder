# github_user_finder

## Como rodar a aplicação
1. Pré-requisitos
   - Flutter SDK 3.27.4 instalado
   - Emulador Android ou dispositivo físico configurado
2. Clonar o projeto
   - git clone https://github.com/FigueredoMatheus/github_user_finder
5. Instalar dependências
   - flutter pub get
6. Rodar a aplicação
   - flutter run
## Escolhas Técnicas e Trade-offs
### Retrofit + Dio
  - Escolhido para simplificar as chamadas HTTP com tipagem, geração automática de código e interceptação de requisições.
### BLoC + flutter_bloc
 - Utilizado para garantir uma separação clara entre lógica de negócios e interface.
 - Inicialmente o gerenciamento de estado seria feito com ChangeNotifier/ValueNotifier por simplicidade. No entanto, visando escalabilidade e clareza na separação de estados e eventos, optou-se pelo padrão BLoC.
 - BLoC permite rastrear facilmente mudanças de estado, testes mais robustos e maior previsibilidade. É mais verboso, mas garante maior robustez e organização conforme o projeto cresce.
### SQLite ao invés de SharedPreferences
 - Inicialmente o cache seria feito com SharedPreferences, mas foi substituído por SQLite para suportar buscar parcialmente por usernames no cache, ultimas pesquisar realizdas e aplicar paginação no histórico.
### Modularização por modules
 - Cada funcionalidade (Search, User Details, History, etc.) foi separada em modules com suas camadas (data, domain, presentation).
   1. data/ Contém implementações específicas: serviços HTTP, cache, modelos JSON
   2. domain/ Define contratos (interfaces), entidades e use cases
   3. presentation/ Contém widgets, bloc, eventos, estados e páginas da UI
 - Permite escalar com segurança e testar unidades isoladamente.
### Future.wait + countCommits
 - A função countCommits foi usada para descobrir o número de commits de um repositório via header Link.
 - Como são múltiplos repositórios, foi usada a função Future.wait para buscar todos em paralelo.
## Desafios enfrentados e como foram resolvidos
### Busca pelo número de commits de um repo
 - A GitHub REST API não retorna diretamente a contagem de commits.
 - Para contornar isso, foi usada a estratégia de:
 1. Buscar os últimos 5 repositórios atualizados do usuário.
 2. Fazer uma requisição paginada (per_page=1&page=1) para o endpoint de commits.
 3. Ler o header Link da resposta para extrair a última página (total de commits).
 4. Realizar uma busca paralela de tudo com Future.wait.
## Proposta para Escalabilidade Futura
1. Autenticação via OAuth GitHub para aumentar o rate limit e acessar dados privados
2. Favoritos: permitir ao usuário salvar perfis que deseja acompanhar
3. Notificações para usuários monitorados
