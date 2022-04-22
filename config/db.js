const Sequelize  = require('sequelize');

const db = new Sequelize('prueba-tecnica', 'root', 'Ingeniero2024@',{
    host: 'localhost',
    dialect: 'mysql',
    port: 3306,
    operatorsAliases: false,
    define: {
        timestamps: false
    }
});

module.exports = db;