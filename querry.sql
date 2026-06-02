INSERT INTO appointments (
  professional_id,
  customer_id,
  service_id,
  start_at,
  end_at,
  price,
  status,
  customer_name,
  customer_phone,
  notes
)
VALUES (
  1,
  1,
  2,
  NOW(),
  NOW() + INTERVAL '1 hour',
  50,
  'confirmed',
  'Edeval',
  '(11)99999-9999',
  'Primeiro agendamento'
);