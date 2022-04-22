// Ruta para el home
//req - Petición al servidor
// res - Lo que me devuelve el servidor

const Docentes = require('../models/Docentes')

exports.PruebaHome = async (req, res) => {
    const docentes = await Docentes.findAll();
    res.render('index', {
        nombrePagina: 'Home',
        docentes,
        nombreBoton: 'Registrar Docente'
    });
}

exports.docentes = async (req, res) => {
    const docentes = await Docentes.findAll();
    res.render('docentes', {
        nombrePagina: 'Docentes',
        docentes: docentes,
        nombreBoton: 'Registrar Docente'
    })
}

exports.nuevoDocente =  async(req, res) =>{

    // Enviar a la consola lo que el usuario escriba
    //console.log(req.body);

    //Validar que tengamos algo en los inputs
    let { nombres, apellidos,  identificacion, correo} = req.body;
    nombres = nombres.toUpperCase()
    apellidos = apellidos.toUpperCase()
    identificacion = identificacion.toUpperCase()
    correo = correo.toUpperCase()

    let errores = [];
    if(!nombres || !apellidos || !identificacion || !correo){
        errores.push({'texto': 'Todos los campos son obligatorios'})
    }

    //Si hay errores
    if(errores.length > 0){
        res.render('docentes', {
            nombrePagina: 'Docentes', errores
        })
    } else{
        // Si hay errores se procede a insertar datos en la bd
        console.log(nombres.toUpperCase())
        await Docentes.create({  Profe_Nombres:  nombres, Profe_Apellidos: apellidos, Profe_Identificacion: identificacion, Profe_Correo: correo})
        res.redirect('/')
    }

}