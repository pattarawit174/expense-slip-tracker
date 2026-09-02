create table public.expenses (
  id bigint generated always as identity not null,
  line_user_id text null,
  group_id text null,
  payer_name text null,
  recipient_name text null,
  invoice_date date null,
  total_amount numeric null,
  activity text null,
  created_at timestamp with time zone null default now(),
  transaction_type text null default 'expense'::text,
  constraint expenses_pkey primary key (id)
) TABLESPACE pg_default;

create index IF not exists idx_expenses_user_month on public.expenses using btree (line_user_id, month_start (invoice_date)) TABLESPACE pg_default;