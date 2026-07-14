using RetailInventory.Data;
using RetailInventory.Models;

using var context = new InventoryContext();

// Create Categories
var electronics = new Category
{
    CategoryName = "Electronics"
};

var groceries = new Category
{
    CategoryName = "Groceries"
};

// Add Categories
await context.Categories.AddRangeAsync(electronics, groceries);

// Create Products
var product1 = new Product
{
    ProductName = "Laptop",
    Price = 75000,
    Stock = 10,
    Category = electronics
};

var product2 = new Product
{
    ProductName = "Rice Bag",
    Price = 1200,
    Stock = 50,
    Category = groceries
};

// Add Products
await context.Products.AddRangeAsync(product1, product2);

// Save
await context.SaveChangesAsync();

Console.WriteLine("Data inserted successfully!");