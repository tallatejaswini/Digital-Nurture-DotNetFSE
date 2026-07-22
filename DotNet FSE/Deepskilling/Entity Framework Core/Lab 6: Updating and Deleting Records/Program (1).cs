using Microsoft.EntityFrameworkCore;
using RetailInventory.Data;

using var context = new InventoryContext();

// Update Product
var product = await context.Products
    .FirstOrDefaultAsync(p => p.ProductName == "Laptop");

if (product != null)
{
    product.Price = 70000;

    await context.SaveChangesAsync();

    Console.WriteLine("Product price updated.");
}
else
{
    Console.WriteLine("Laptop not found.");
}

// Delete Product
var toDelete = await context.Products
    .FirstOrDefaultAsync(p => p.ProductName == "Rice Bag");

if (toDelete != null)
{
    context.Products.Remove(toDelete);

    await context.SaveChangesAsync();

    Console.WriteLine("Product deleted.");
}
else
{
    Console.WriteLine("Rice Bag not found.");
}