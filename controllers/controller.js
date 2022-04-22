// Ruta para el home
//req - Petición al servidor
// res - Lo que me devuelve el servidor

const Docentes = require('../models/Docentes')

exports.PruebaHome = (req, res) => {
    res.render('index', {
        nombrePagina: 'Home'
    });
}

exports.docentes = (req, res) => {
    res.render('docentes', {
        nombrePagina: 'Docentes'
    })
}

exports.nuevoDocente =  async(req, res) =>{
    // Enviar a la consola lo que el usuario escriba
    //console.log(req.body);

    //Validar que tengamos algo en los inputs
    const { nombres, apellidos,  identificacion, correo} = req.body;
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
        const docente = await Docentes.create({  Profe_Nombres: nombres, Profe_Apellidos: apellidos, Profe_Identificacion: identificacion, Profe_Correo: correo})
        res.redirect('/////')
    }

}