const Sequelize = require('sequelize');

const db = require('../config/db');

const  Docentes = db.define('profesores',{
    Profe_ID: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    Profe_Nombres: {
        type: Sequelize.STRING,
        notNull: true
    },
    Profe_Apellidos: {
        type: Sequelize.STRING,
        notNull: true
    },
    Profe_Identificacion: {
        type: Sequelize.STRING,
        notNull: true
    },
    Profe_Correo: {
        type: Sequelize.STRING,
        notNull: true
    }
});

module.exports = Docentes