-- Tabela dos abastecimentos. Rode no Supabase: SQL Editor → New query → cole tudo → Run.
create table if not exists public.abastecimentos (
  user_id     uuid not null default auth.uid() references auth.users (id) on delete cascade,
  id          text not null,
  data        date not null,
  combustivel text not null default 'gasolina' check (combustivel in ('gasolina', 'alcool')),
  valor       numeric not null check (valor > 0),
  litros      numeric not null check (litros > 0),
  km          numeric not null check (km > 0),
  criado_em   timestamptz not null default now(),
  primary key (user_id, id)
);

-- Segurança: cada usuário só enxerga e altera os próprios registros
alter table public.abastecimentos enable row level security;

drop policy if exists "ver os próprios" on public.abastecimentos;
drop policy if exists "inserir os próprios" on public.abastecimentos;
drop policy if exists "alterar os próprios" on public.abastecimentos;
drop policy if exists "excluir os próprios" on public.abastecimentos;

create policy "ver os próprios" on public.abastecimentos
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "inserir os próprios" on public.abastecimentos
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "alterar os próprios" on public.abastecimentos
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "excluir os próprios" on public.abastecimentos
  for delete to authenticated using ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.abastecimentos to authenticated;
revoke all on public.abastecimentos from anon;
