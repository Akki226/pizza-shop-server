const Order = require("../models/Order")
const { sendPushNotification } = require('../services/notification.js');

async function index (req, res) {
    try {
        const orders = await Order.getAll()
        res.status(200).json(orders)
    } catch (err) {
        res.status(500).json({ error: err.message})
    }
}

async function updateOrderDelivered(req, res) {
    try {
        const order_id = req.params.id;
        const data = req.body;
        const orderToUpdate = await Order.findById(order_id);
        const result = await orderToUpdate.updateOrderDelivered(data);
        res.status(200).json(result);
    } catch (err) {
        res.status(404).json({ error: err.message });
    }
}

async function create (req, res) {
    try {
        const data = req.body;
        const subscription = req.body.subscription;

        const newOrder = await Order.create(data);

        const payload = { title: 'Your order has been received!' };
        await sendPushNotification(subscription, payload);

        res.status(201).json(newOrder);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
}

module.exports = {
    index, create, updateOrderDelivered
}