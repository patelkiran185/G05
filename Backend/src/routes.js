// routes/cart.js
const express = require('express');
const mongoose = require('mongoose');
const Product = require('./models/Product');
const Cart = require('./models/Cart');

const router = express.Router();


// 1. Add item to cart
router.post('/cart', async (req, res) => {
  const { rollNumber, productId, quantity } = req.body;

  try {
    // Find the product using the ProductId
    const product = await Product.findOne({ ProductId: productId });
    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }

    // Check if user already has a cart
    let cart = await Cart.findOne({ roll_number: rollNumber });

    if (cart) {
      // Cart exists, update it
      const existingItem = cart.items.find(item => item.product_id.ProductId === productId);

      if (existingItem) {
        // If item already exists, update quantity
        existingItem.quantity += quantity;
      } else {
        // If item doesn't exist, add new item
        cart.items.push({ 
          product_id: product._id, // Store the ObjectId of the product
          quantity, 
          price: product.Price 
        });
      }

      // Recalculate total price
      cart.total_price = cart.items.reduce((total, item) => total + (item.price * item.quantity), 0);

      await cart.save();
      return res.status(200).json(cart);
    } else {
      // If cart doesn't exist, create a new one
      const newCart = new Cart({
        roll_number: rollNumber,
        items: [{ product_id: product._id, quantity, price: product.Price }],
        total_price: product.Price * quantity
      });

      await newCart.save();
      return res.status(200).json(newCart);
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Server error' });
  }
});

// 2. Fetch cart items for a user by roll number
router.get('/cart/:rollNumber', async (req, res) => {
  const { rollNumber } = req.params;

  try {
    const cart = await Cart.findOne({ roll_number: rollNumber }).populate('items.product_id');
    
    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    // Send back populated cart
    return res.status(200).json(cart);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Server error' });
  }
});

// 3
router.delete('/cart/:rollNumber/:productId', async (req, res) => {
  const { rollNumber, productId } = req.params;

  try {
    // 1. Find the product in the products collection by ProductId
    const product = await Product.findOne({ ProductId: productId });

    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }

    // 2. Find the user's cart based on roll_number
    let cart = await Cart.findOne({ roll_number: rollNumber });

    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    // 3. Find the product in the cart using the ObjectId of the product
    const productIndex = cart.items.findIndex(item => item.product_id.toString() === product._id.toString());

    if (productIndex === -1) {
      return res.status(404).json({ message: 'Product not found in cart' });
    }

    // 4. Remove the item from the cart
    cart.items.splice(productIndex, 1);

    // 5. Recalculate total price
    cart.total_price = cart.items.reduce((total, item) => total + (item.price * item.quantity), 0);

    // 6. Save the updated cart
    await cart.save();

    // 7. Return the updated cart
    return res.status(200).json(cart);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Server error' });
  }
});



// 4. Checkout - Move cart to orders
router.post('/checkout', async (req, res) => {
  const { rollNumber } = req.body;

  let cart = await Cart.findOne({ roll_number: rollNumber });

  if (!cart) {
    return res.status(404).json({ message: 'Cart not found' });
  }

  // Move cart to order (For simplicity, assume "Order" is just a copy of cart data)
  const newOrder = {
    roll_number: rollNumber,
    items: cart.items,
    total_price: cart.total_price,
    status: 'pending',
    created_at: new Date()
  };

  // Save the order (you can also implement an Order model here)
  // Orders.push(newOrder); // Or save it in another MongoDB collection

  // Clear the cart
  await Cart.deleteOne({ roll_number: rollNumber });

  return res.status(200).json({ message: 'Order placed successfully' });
});

module.exports = router;
