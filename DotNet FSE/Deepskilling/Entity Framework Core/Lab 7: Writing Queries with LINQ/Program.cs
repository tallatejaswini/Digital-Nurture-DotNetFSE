using Microsoft.EntityFrameworkCore;
using RetailInventory.Data;

using var context = new InventoryContext();

Console.WriteLine("----- PRODUCTS PRICE > 1000 -----");

var filtered = await context.Products
    .Where(p => p.Price > 1000)
    .OrderByDescending(p => p.Price)
    .ToListAsync();

foreach (var p in filtered)
{
    Console.WriteLine($"{p.ProductName} - ₹{p.Price}");
}

Console.WriteLine();

Console.WriteLine("----- PRODUCT DTO -----");

var productDTOs = await context.Products
    .Select(p => new
    {
        p.ProductName,
        p.Price
    })
    .ToListAsync();

foreach (var p in productDTOs)
{
    Console.WriteLine($"{p.ProductName} - ₹{p.Price}");
}