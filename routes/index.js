const express = require('express');
const router  = express.Router();

// Importar express validators
const { body } = require('express-validator/check');

//Importando controlador
const controller = require('../controllers/controller')
module.exports = function () {

    router.get('/', controller.docentes);
    router.get('/docentes', controller.docentes)
    router.post('/docentes',
        body('nombres').not().isEmpty().trim().escape(),
        body('apellidos').not().isEmpty().trim().escape(),
        body('identificacion').not().isEmpty().trim().escape(),
        body('correo').not().isEmpty().trim().isEmail(),
        controller.nuevoDocente);
    return router;
}