# Supabase: como está configurado

- **Site:** https://biduzimr0x.github.io/abastecimento/ (GitHub Pages, repositório `biduzimr0x/abastecimento`)
- **Projeto Supabase:** `abastecimento` (ref `jfrcjkxlmeqmhvxgyfzj`), organização `projeto-chapinha`
- **Tabela:** `abastecimentos`, criada por `supabase.sql`. Cada usuário só lê e grava os próprios registros (RLS).
- **Login:** link mágico por e-mail. O cadastro de novos usuários está **desligado**: só entram e-mails
  cadastrados em **Authentication → Users**.
- **Redirect URLs:** o endereço do site e `http://localhost:8000/**` (para testar no PC).

A URL e a chave pública (publishable) ficam em `window.SUPABASE_CONFIG`, no topo do `abastecimento.html`.
A chave pública pode ficar no código. Quem protege os dados são as regras da tabela.

## Liberar outra pessoa

1. Supabase → **Authentication → Users → Add user → Create new user**: digite o e-mail e marque
   **Auto Confirm User** (a senha pode ficar em branco ou ser qualquer uma, não é usada).
2. O envio de e-mail gratuito do Supabase só manda para e-mails de **membros da organização**. Convide a
   pessoa em **Organization → Team → Invite** (papel *Read-only* basta). Ela precisa aceitar o convite.
   A alternativa é configurar um SMTP próprio em **Authentication → Emails → SMTP Settings** (ex.: Resend);
   aí qualquer e-mail cadastrado recebe o link.

## Limites do plano gratuito

- Poucos e-mails de login por hora. Como o login fica salvo no aparelho, quase nunca precisa de outro.
- O modelo do e-mail é o padrão, em inglês ("Your sign-in link"). Para mudar o texto, é preciso SMTP próprio.
- Projetos gratuitos sem uso por 7 dias são **pausados**. Para reativar, abra o painel do Supabase e clique em
  **Restore project**. Os dados não se perdem.

## Testar no PC sem publicar

O login não funciona abrindo o arquivo direto (`file://`). Na pasta do projeto, rode:

```sh
python -m http.server 8000
```

E abra `http://localhost:8000/abastecimento.html`.
