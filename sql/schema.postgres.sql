-- Users, Orders, Products schema for Postgres
CREATE TABLE users (
  id integer PRIMARY KEY,
  name text NOT NULL,
  country text
);

CREATE TABLE orders (
  id integer PRIMARY KEY,
  user_id integer NOT NULL REFERENCES users(id),
  total_cents integer NOT NULL,
  created_at timestamp NOT NULL
);

CREATE TABLE products (
  id integer PRIMARY KEY,
  name text NOT NULL,
  price_cents integer NOT NULL
);

CREATE TABLE order_items (
  id integer PRIMARY KEY,
  order_id integer NOT NULL REFERENCES orders(id),
  product_id integer NOT NULL REFERENCES products(id),
  qty integer NOT NULL CHECK (qty > 0)
);

