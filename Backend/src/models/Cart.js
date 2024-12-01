// models/Cart.js
const mongoose = require('mongoose');
const Product = require('./Product'); // Import Product model to use its data

// Define the cart item schema
const cartItemSchema = new mongoose.Schema({
  product_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Product', required: true }, // Link to Product
  quantity: { type: Number, required: true },
  price: { type: Number, required: true } // Price at the time of adding to cart
});

// Define the cart schema
const cartSchema = new mongoose.Schema({
  roll_number: { type: String, required: true }, // Reference to roll number (unique)
  items: [cartItemSchema], // Array of cart items
  total_price: { type: Number, default: 0 } // Total price for all items in the cart
});

const Cart = mongoose.model('Cart', cartSchema);

module.exports = Cart;
