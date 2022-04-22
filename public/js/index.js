let editar = document.querySelector(".btn-editar");
editar.onclick = muestraAlerta;

function muestraAlerta(evento) {
    alert("Evento onclick ejecutado!");
}