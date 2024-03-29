DROP TABLE IF EXISTS toppings;
DROP TABLE IF EXISTS pizzas;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_number VARCHAR(8) NOT NULL,
    revenue NUMERIC(10, 2) NOT NULL,
    notes TEXT,
    order_received BOOLEAN DEFAULT true,
    order_received_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    order_pickedup BOOLEAN DEFAULT false,
    order_pickedup_timestamp TIMESTAMP WITH TIME ZONE,
    order_delivered BOOLEAN DEFAULT false,
    order_delivered_timestamp TIMESTAMP WITH TIME ZONE,
    order_claimed BOOLEAN DEFAULT false,
    order_claimed_timestamp TIMESTAMP WITH TIME ZONE
);

CREATE TABLE pizzas (
    pizza_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    size VARCHAR(10) NOT NULL
);

CREATE TABLE toppings (
    topping_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pizza_id INT REFERENCES pizzas(pizza_id),
    order_id INT REFERENCES orders(order_id),
    topping_name VARCHAR(50) NOT NULL
);

-- Create a trigger function for order_delivered
CREATE OR REPLACE FUNCTION update_order_delivered_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.order_delivered = true THEN
    NEW.order_delivered_timestamp = NOW();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger that calls the trigger function for order_delivered
CREATE TRIGGER update_order_delivered_timestamp_trigger
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION update_order_delivered_timestamp();

INSERT INTO orders (order_number, revenue, notes) VALUES
    ('12345678', 25.99, 'Leave order at the lobby'),
    ('98765432', 19.99, 'Extra cheese please! Thank you!');

INSERT INTO pizzas (order_id, size) VALUES
    (1, 'Medium'),
    (1, 'Large');

INSERT INTO pizzas (order_id, size) VALUES
    (2, 'Small'),
    (2, 'Medium'),
    (2, 'Large');

INSERT INTO toppings (pizza_id, order_id, topping_name) VALUES
    (1, 1, 'Pepperoni'),
    (2, 1, 'Mushrooms'),
    (2, 1, 'Peppers'); 

INSERT INTO toppings (pizza_id, order_id, topping_name) VALUES
    (3, 2, 'Sausage'),
    (4, 2, 'Olives'),
    (5, 2, 'Onions');


