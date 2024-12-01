// models/Product.js
const mongoose = require('mongoose');

// Define the product schema
const productSchema = new mongoose.Schema({
  ProductId: { type: String, required: true }, // Custom product ID
  Name: { type: String, required: true }, // Product name
  Price: { type: Number, required: true }, // Price of the product
  Category: { type: String, required: true }, // Product category name (e.g., "Breakfast")
  CategoryId: { type: String, required: true }, // Reference to category ID
  Rating: { type: Number, required: true, min: 0, max: 5 }, // Product rating
  Image: { type: String, required: true }, // Image filename
  Description: { type: String, required: true }, // Product description
}, { timestamps: true }); // Automatically include createdAt and updatedAt

const Product = mongoose.model('Product', productSchema);

module.exports = Product;
