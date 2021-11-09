-- 1. Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer klienta
-- dla wszystkich niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy jest Argentyna
SELECT OrderID, OrderDate, CustomerID
FROM Orders
WHERE (ShippedDate IS NULL OR ShippedDate > GETDATE())
  AND ShipCountry = 'Argentina'