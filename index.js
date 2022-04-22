const express = require('express');
const routes = require('./routes');
const path = require('path')
const bodyParser = require('body-parser');

// Helpers con algunas funciones
const helpers = require('./helpers');

// Crear la conexión a la BD
const db = require('./config/db');

// Importar el modelo
require('./models/Docentes');
db.authenticate()
    .then(() => console.log('Conectando al servidor'))
    .catch(error => console.log(error) )

// Crear una app de express
const app = express();

// Donde cargar los archivos estaticos
app.use(express.static('public'));

// Habilitar Pug
app.set('view engine', 'pug');


// Agregar la carpeta de las vistas
app.set('views', path.join(__dirname, './views'))

// Pasar vardump a la aplicación
app.use( (req, res, next) => {
    res.locals.vardump = helpers.vardump;
    next();
})

// Habilitar bodyPrser para leer datos del formulario
app.use(bodyParser.urlencoded({extended: true}));

app.use('/', routes())

app.listen(4000);
