create table public.documents2 (
  id bigserial not null,
  content text null,
  metadata jsonb null,
  embedding public.vector null,
  constraint documents2_pkey primary key (id)
) TABLESPACE pg_default;