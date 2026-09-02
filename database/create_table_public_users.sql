create table public.users (
  line_user_id text not null,
  display_name text null,
  group_id text null,
  updated_at timestamp with time zone null default now(),
  constraint users_pkey primary key (line_user_id)
) TABLESPACE pg_default;