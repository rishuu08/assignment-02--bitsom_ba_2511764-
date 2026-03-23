use("ecommerceDB");

// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: 1,
    name: "Samsung 55 inch Smart TV",
    category: "Electronics",
    brand: "Samsung",
    price: 45999,
    stock: 12,
    warranty_years: 2,
    voltage: "220V",
    specifications: {
      screen_size: "55 inch",
      resolution: "4K UHD",
      smart_tv: true
    },
    features: ["WiFi", "Bluetooth", "HDMI", "Voice Control"]
  },
  {
    _id: 2,
    name: "Men's Denim Jacket",
    category: "Clothing",
    brand: "Levis",
    price: 2999,
    stock: 30,
    size_options: ["S", "M", "L", "XL"],
    color: "Blue",
    material: "Denim",
    care_instructions: {
      wash: "Machine wash",
      iron: "Low heat"
    },
    tags: ["casual", "winter", "fashion"]
  },
  {
    _id: 3,
    name: "Organic Milk 1L",
    category: "Groceries",
    brand: "Amul",
    price: 65,
    stock: 100,
    expiry_date: "2024-12-20",
    nutritional_info: {
      calories: 150,
      protein_g: 8,
      fat_g: 7
    },
    ingredients: ["Cow Milk"],
    storage: {
      temperature: "Keep Refrigerated",
      shelf_life_days: 7
    }
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: "2025-01-01" }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { name: "Samsung 55 inch Smart TV" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });

// Reason:
// This index improves query performance when searching products by category,
// such as Electronics, Clothing, or Groceries. It reduces scan time and makes
// filtering faster, especially when the collection becomes large.