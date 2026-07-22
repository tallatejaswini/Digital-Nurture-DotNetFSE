using Microsoft.EntityFrameworkCore;
using RetailInventory.Data;

using var context = new InventoryContext();

Console.WriteLine("----- ALL PRODUCTS -----");

var products = await context.Products.ToListAsync();

foreach (var p in products)
{
    Console.WriteLine($"{p.ProductName} - ₹{p.Price}");
}

Console.WriteLine();

Console.WriteLine("----- FIND BY ID -----");

var product = await context.Products.FindAsync(1);

if (product != null)
{
    Console.WriteLine($"Found: {product.ProductName}");
}
else
{
    Console.WriteLine("Product not found.");
}

Console.WriteLine();

Console.WriteLine("----- FIRST PRODUCT PRICE > 50000 -----");

var expensive = await context.Products
    .FirstOrDefaultAsync(p => p.Price > 50000);

if (expensive != null)
{
    Console.WriteLine($"Expensive Product: {expensive.ProductName}");
}
else
{
    Console.WriteLine("No expensive product found.");
}