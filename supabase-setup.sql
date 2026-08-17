-- WonderPlan — configuración inicial de Supabase.
-- Pegar entero en: panel de Supabase → SQL Editor → New query → Run.

-- Perfil público de cada usuario (además de auth.users, que Supabase ya maneja)
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  pais text not null,
  color text not null default '#38bdf8',
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "profiles_select_all" on public.profiles
  for select using (true);

create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id);

-- Al confirmar el email, auth.users recibe la fila y este trigger crea
-- automáticamente el perfil (username/país quedan en el signUp inicial).
-- Si el username ya existe, esto falla y el registro completo se revierte.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, username, pais, color)
  values (
    new.id,
    new.raw_user_meta_data->>'username',
    new.raw_user_meta_data->>'pais',
    coalesce(new.raw_user_meta_data->>'color', '#38bdf8')
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Permite iniciar sesión con nombre de usuario (además de email):
-- busca el email asociado sin exponer la tabla auth.users al cliente.
create or replace function public.get_email_for_username(p_username text)
returns text
language sql
security definer set search_path = public
as $$
  select u.email::text
  from auth.users u
  join public.profiles p on p.id = u.id
  where lower(p.username) = lower(p_username)
  limit 1;
$$;

grant execute on function public.get_email_for_username(text) to anon, authenticated;
