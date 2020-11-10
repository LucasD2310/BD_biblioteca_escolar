================================================================================================================================================================================
# BD_biblioteca_escolar
Contiene BBDD diseñada para una biblioteca escolar, con procedimientos almacenados para realizar inserciones, actualizaciones y eliminaciones de registros.
================================================================================================================================================================================

# PROCEDIMIENTOS DE INSERCIÓN / ACTUALIZACIÓN
  Estos procedimientos sirven para ingresar un nuevo registro a la base, en caso de que su identificador ya exista, el procedimiento actualizará la información de dicho registro
  (las actualizaciones se realizan en base a las restricciones de la base, es decir, al actualizar un campo correspondiente a llave foránea, se actualizarán en cascada el resto
  de registros que de ella dependan)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

- Especialidad:
  CALL agregarEspecialidad (Id, Nombre_especialidad); 

  * Ejemplo:
   CALL agregarEspecialidad (4, 'CUENTO INFANTIL'); 
   
   
- Editorial:
  CALL agregarEditorial (Id, Nombre_editorial);

  * Ejemplo:
  CALL agregarEditorial (9, 'ALFAGUARA INF');
  

- Autor:
  CALL agregarAutor (Id, Nombre_autor);
  
  * Ejemplo:
  CALL agregarAutor (10, 'Roald');


- Libro:  (en este caso el identificador corresponde al código ISBN)
  CALL agregarLibro (Nombre_libro, ISBN, Id_especialidad, Id_editorial, Id_autor);
  
  * Ejemplo:
  CALL agregarLibro ('Este Alce Es Mio', '9786071611406', 4, 8, 8);


- Usuario:
  CALL agregarUsuario (Id, Nombre_usuario, Email, Dirección, Teléfono);
  
  * Ejemplo:
  CALL agregarUsuario (7, 'RENATO DIAZ', 'RENATO.DIAZ@COLEGIO.CL', 'PJE ARICA 323', 223231243);
  

- Préstamo:
  CALL agregarPrestamo (Id, Id_libro, Id_usuario, Fecha_prestamo, Fecha_devolución);
  
  * Ejemplo:
  CALL agregarPrestamo (19, 5, 4, '2020-11-07', '2020-12-22');
  
  
- Marcar Devolución: (en este caso, para el Id correspondiente se modifica la fecha de devolución a la ingresada, si el libro ha sido devuelto)
  CALL marcaDevolucion (Id, Fecha_devolución);
  
  * Ejemplo:
  CALL marcaDevolucion (1, '2020-11-09');
  
  
================================================================================================================================================================================


# PROCEDIMIENTOS DE ELIMINACIÓN
  Estos procedimientos sirven para eliminar un registro de la tabla deseada en base a su Id (se permitirán las eliminaciones en base a sus restricciones, 
  si una llave foránea está en uso y desea ser eliminada, la restricción no lo permitirá)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  
- Préstamo:
  CALL eliminaPrestamos(Id);
  
  * Ejemplo:
  CALL eliminaPrestamos(20);
  

- Usuario:
  CALL eliminaUsuario(Id);
  
  * Ejemplo:
  CALL eliminaUsuario(7);
  

- Libro:
  CALL eliminaLibro(Id);
  
  * Ejemplo:
  CALL eliminaLibro(9);
  
  
- Especialidad:
  CALL eliminaEspecialidad(Id);
  
  * Ejemplo:
  CALL eliminaEspecialidad(4);
  

- Autor:
  CALL eliminaAutor(Id);
  
  * Ejemplo:
  CALL eliminaAutor(10);


- Editorial:
  CALL eliminaEditorial(Id);
  
  * Ejemplo:
  CALL eliminaEditorial(9);
