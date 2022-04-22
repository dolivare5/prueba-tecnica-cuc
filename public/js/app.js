const mysql = require('mysql');
const {parse} = require("nodemon/lib/cli");
var readline = require('readline');
const conexion = mysql.createConnection({
    host:'localhost' ,
    database: 'prueba-tecnica' ,
    user: 'root' ,
    password: 'Ingeniero2024@',
    port: 3306
});

conexion.connect(function (error){
    if(error){
        throw error;
    }
});
const rl = readline.createInterface(
    process.stdin, process.stdout);

console.log("¿Qué desea hacer?")
console.log("1. Ver Docentes registrados")

rl.question('>>> ', (age) => {
    const opcion = parseInt(age)
    if (opcion === 1){
        conexion.query(
            'CALL mostrarProfesores()',
            function(err, rows){
                if (err){
                    throw err;
                }  else{
                    const data_profesores = Object.values(JSON.parse(JSON.stringify(rows)));
                    let i = 0;
                    for (const profesores of data_profesores) {
                        for (const profesor of profesores) {
                            console.log(`Nombre del profesor: ${profesor.Profe_Nombres}, Apellido: ${profesor.Profe_Apellidos}, Identificación: ${profesor.Profe_Identificacion}, Correo: ${profesor.Profe_correo}`);
                            if (i === profesores.length){
                                break;
                            }
                            i += 1
                        }
                        if (i === profesores.length){
                            break;
                        }
                    }
                }
            }
        );
    }
    conexion.end();

})

