create view public.monthly_summary as
select
  to_char(
    e.invoice_date::timestamp with time zone,
    'YYYY-MM'::text
  ) as month,
  e.line_user_id,
  e.group_id,
  u.display_name,
  COALESCE(
    sum(e.total_amount) filter (
      where
        e.transaction_type = 'income'::text
    ),
    0::numeric
  ) as income,
  COALESCE(
    sum(e.total_amount) filter (
      where
        e.transaction_type = 'expense'::text
    ),
    0::numeric
  ) as expense,
  COALESCE(
    sum(e.total_amount) filter (
      where
        e.transaction_type = 'income'::text
    ),
    0::numeric
  ) - COALESCE(
    sum(e.total_amount) filter (
      where
        e.transaction_type = 'expense'::text
    ),
    0::numeric
  ) as net
from
  expenses e
  left join users u on u.line_user_id = e.line_user_id
group by
  (
    to_char(
      e.invoice_date::timestamp with time zone,
      'YYYY-MM'::text
    )
  ),
  e.line_user_id,
  e.group_id,
  u.display_name
order by
  (
    to_char(
      e.invoice_date::timestamp with time zone,
      'YYYY-MM'::text
    )
  ) desc;