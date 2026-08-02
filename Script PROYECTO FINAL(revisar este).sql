DROP DATABASE IF EXISTS db_universidad;
GO

CREATE DATABASE db_universidad;
go

USE db_universidad;
go


---CREACION TABLA ESTUDIANTE---
CREATE TABLE estudiante (
  id_estudiante INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  cedula VARCHAR(20) NOT NULL UNIQUE,
  sexo CHAR(1) NOT NULL,
  fecha_nac DATE NOT NULL,
  direccion VARCHAR(200) NULL,
  telefono VARCHAR(20) NOT NULL,
  correo VARCHAR(100) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  id_carrera INT NOT NULL,
  PRIMARY KEY (id_estudiante)
  );
GO


---CREACION DE LA TABLA CARRERA---
CREATE TABLE carrera (
  id_carrera INT IDENTITY (1,1) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  duracion_semestre INT NOT NULL,
  titulo VARCHAR(50) NULL,
  PRIMARY KEY (id_carrera)
  );
GO

---CREACION TABLA PROFESOR--
CREATE TABLE profesor (
  id_profesor INT IDENTITY (1,1) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  cedula VARCHAR(20) NOT NULL UNIQUE,
  telefono VARCHAR(20) NOT NULL,
  correo  VARCHAR (100) NULL,
  especialidad VARCHAR(100) NOT NULL
  );
GO
  
   ---CREACION TABLA ASIGNATURA---
 CREATE TABLE asignatura (
  id_asignatura INT IDENTITY (1,1)NOT NULL,
  id_carrera INT NOT NULL,
  id_profesor INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  horas INT NOT NULL,
  credito INT NOT NULL,
  PRIMARY KEY (id_asignatura)
  );
GO

  ------CREACION TABLA PAGO---
  CREATE TABLE pago (
    id_pago INT IDENTITY (1,1) NOT NULL , 
    id_matricula INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    tipo_pago VARCHAR(30) NOT NULL,
      CHECK (tipo_pago IN ('Transferencia','Efectivo','Tarjeta','Sinpe')), -- solo se registran metodos de pagos validos 
    estado VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_pago)
     );
 GO
 ------CREACION TABLA HORARIO---

  CREATE TABLE horario (
    id_horario INT IDENTITY (1,1) NOT NULL,
    id_asignatura INT NOT NULL,
    dia_semana VARCHAR (15) NOT NULL,
      CHECK (dia_semana IN ('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo')), ---evita errores a la hora de entrar los nombres de la semana
    hora_inicio TIME NOT NULL,
    hora_fin TIME  NOT NULL,
    PRIMARY KEY (id_horario)
    );
 GO
   
   ---CREACION TABLA MATRICULA
   CREATE TABLE matricula (
    id_matricula INT IDENTITY (1,1) NOT NULL,
    id_estudiante INT NOT NULL,
    periodo VARCHAR (20) NOT NULL,
    fecha_matricula DATE NOT NULL,
    estado VARCHAR (20) NOT NULL 
        CONSTRAINT DF_Matricula_Estado DEFAULT 'Activo', ---- Se le asigna un nombre a la restriccion
    PRIMARY KEY (id_matricula)
    );
 GO
 
    ---CREACION TABLA DETALLE_MATRICULA
CREATE TABLE detalle_matricula (
  id_detalle INT IDENTITY (1,1) NOT NULL,
  id_matricula INT NOT NULL,
  id_asignatura  INT NOT NULL,
  nota DECIMAL (5,2) NULL,
  estado VARCHAR (20) NOT NULL DEFAULT 'Matriculada',
  PRIMARY KEY (id_detalle)
  );
GO

---INSERT INTO TABLA---

-- ESTUDIANTE
INSERT INTO estudiante (id_estudiante, nombre, apellido, cedula, sexo, fecha_nac, direccion, telefono, correo, fecha_ingreso, id_carrera) VALUES
(1, 'Carlos', 'Gómez', '001-150398-1001A', 'M', '1998-03-15', 'Calle Central 123, Sector Norte', '88881101', 'carlos.gomez@email.com', '2021-01-15', 1),
(2, 'María', 'López', '001-220799-1002B', 'F', '1999-07-22', 'Av. Bolivar, Frente al parque', '88881102', 'maria.lopez@email.com', '2021-01-15', 2),
(3, 'Juan', 'Martínez', '001-101100-1003C', 'M', '2000-11-10', 'Barrio San José, Casa 45', '88881103', 'juan.martinez@email.com', '2021-08-20', 1),
(4, 'Ana', 'Hernández', '001-050401-1004D', 'F', '2001-04-05', 'Colonia Las Mercedes #12', '88881104', 'ana.hernandez@email.com', '2021-08-20', 3),
(5, 'Luis', 'Rodríguez', '001-180902-1005E', 'M', '2002-09-18', 'Reparto Schick, Contiguo a farmacia', '88881105', 'luis.rodriguez@email.com', '2022-01-10', 2),
(6, 'Sofia', 'Pérez', '001-301297-1006F', 'F', '1997-12-30', 'Calle Los Robles #88', '88881106', 'sofia.perez@email.com', '2022-01-10', 4),
(7, 'Diego', 'Sánchez', '001-140200-1007G', 'M', '2000-02-14', 'Residencial El Dorado, Casa A-5', '88881107', 'diego.sanchez@email.com', '2022-08-15', 1),
(8, 'Laura', 'Ramírez', '001-250601-1008H', 'F', '2001-06-25', 'Barrio Linda Vista, De la iglesia 2c E', '88881108', 'laura.ramirez@email.com', '2022-08-15', 3),
(9, 'Javier', 'Flores', '001-080899-1009I', 'M', '1999-08-08', 'Villa Progreso, Bloque E-12', '88881109', 'javier.flores@email.com', '2023-01-16', 5),
(10, 'Elena', 'Torres', '001-170102-1010J', 'F', '2002-01-17', 'Urbanización Bello Horizonte', '88881110', 'elena.torres@email.com', '2023-01-16', 2),
(11, 'Gabriel', 'Díaz', '001-030500-1011K', 'M', '2000-05-03', 'Calle San Juan, Edificio 3 Apt 2B', '88881111', 'gabriel.diaz@email.com', '2023-01-16', 4),
(12, 'Camila', 'Vásquez', '001-191001-1012L', 'F', '2001-10-19', 'Barrio Larreynaga', '88881112', 'camila.vasquez@email.com', '2023-08-21', 1),
(13, 'Alejandro', 'Castro', '001-110303-1013M', 'M', '2003-03-11', 'Colonia Máximo Jerez', '88881113', 'alejandro.castro@email.com', '2023-08-21', 3),
(14, 'Valeria', 'Morales', '001-280798-1014N', 'F', '1998-07-28', 'Barrio La Fuente', '88881114', 'valeria.morales@email.com', '2024-01-15', 2),
(15, 'Mateo', 'Ortiz', '001-090902-1015O', 'M', '2002-09-09', 'Reparto San Juan, Calle 4', '88881115', 'mateo.ortiz@email.com', '2024-01-15', 5),
(16, 'Isabella', 'Gutiérrez', '001-210401-1016P', 'F', '2001-04-21', 'Residencial Veracruz, Casa 99', '88881116', 'isabella.gutierrez@email.com', '2024-01-15', 4),
(17, 'Lucas', 'Chávez', '001-131100-1017Q', 'M', '2000-11-13', 'Barrio Altagracia, Del cine 3c S', '88881117', 'lucas.chavez@email.com', '2024-08-19', 1),
(18, 'Daniela', 'Ruiz', '001-020203-1018R', 'F', '2003-02-02', 'Colonia del Periodista', '88881118', 'daniela.ruiz@email.com', '2024-08-19', 3),
(19, 'Santiago', 'Mendoza', '001-070699-1019S', 'M', '1999-06-07', 'Barrio Monseñor Lezcano', '88881119', 'santiago.mendoza@email.com', '2025-01-20', 2),
(20, 'Victoria', 'Aguilar', '001-160802-1020T', 'F', '2002-08-16', 'Villa Fontana, Casa 45-B', '88881120', 'victoria.aguilar@email.com', '2025-01-20', 5),
(21, 'Benjamín', 'Castillo', '001-240101-1021U', 'M', '2001-01-24', 'Barrio Santa Rosa', '88881121', 'benjamin.castillo@email.com', '2025-01-20', 4),
(22, 'Martina', 'Jiménez', '001-120500-1022V', 'F', '2000-05-12', 'Reparto Universitario', '88881122', 'martina.jimenez@email.com', '2025-08-18', 1),
(23, 'Emanuel', 'Moreno', '001-290903-1023W', 'M', '2003-09-29', 'Colonia Centroamérica', '88881123', 'emanuel.moreno@email.com', '2025-08-18', 3),
(24, 'Lucía', 'Ríos', '001-040398-1024X', 'F', '1998-03-04', 'Barrio San Judas', '88881124', 'lucia.rios@email.com', '2026-01-19', 2),
(25, 'Samuel', 'Navarro', '001-150702-1025Y', 'M', '2002-07-15', 'Residencial Lomas de Montserrat', '88881125', 'samuel.navarro@email.com', '2026-01-19', 5),
(26, 'Paula', 'Vargas', '001-201001-1026Z', 'F', '2001-10-20', 'Barrio Batahola Norte', '88881126', 'paula.vargas@email.com', '2026-01-19', 4),
(27, 'Joaquín', 'Peralta', '001-061200-1027A', 'M', '2000-12-06', 'Colonia Nicarao', '88881127', 'joaquin.peralta@email.com', '2026-01-19', 1),
(28, 'Renata', 'Silva', '001-230203-1028B', 'F', '2003-02-23', 'Barrio Ducualí', '88881128', 'renata.silva@email.com', '2026-01-19', 3),
(29, 'Tomás', 'Molina', '001-010899-1029C', 'M', '1999-08-01', 'Reparto San Patricio', '88881129', 'tomas.molina@email.com', '2021-01-15', 2),
(30, 'Adriana', 'Delgado', '001-180402-1030D', 'F', '2002-04-18', 'Villa San Jacinto', '88881130', 'adriana.delgado@email.com', '2021-08-20', 5),
(31, 'Nicolás', 'Campos', '001-270901-1031E', 'M', '2001-09-27', 'Barrio Los Ángeles', '88881131', 'nicolas.campos@email.com', '2022-01-10', 4),
(32, 'Antonia', 'Vega', '001-110100-1032F', 'F', '2000-01-11', 'Colonia 14 de Septiembre', '88881132', 'antonia.vega@email.com', '2022-08-15', 1),
(33, 'Felipe', 'Arias', '001-310503-1033G', 'M', '2003-05-31', 'Barrio Jorge Dimitrov', '88881133', 'felipe.arias@email.com', '2023-01-16', 3),
(34, 'Sara', 'Fuentes', '001-140798-1034H', 'F', '1998-07-14', 'Residencial Los Robles', '88881134', 'sara.fuentes@email.com', '2023-08-21', 2),
(35, 'Agustín', 'Cárdenas', '001-221102-1035I', 'M', '2002-11-22', 'Barrio Cuba', '88881135', 'agustin.cardenas@email.com', '2024-01-15', 5),
(36, 'Mía', 'Pineda', '001-030301-1036J', 'F', '2001-03-03', 'Colonia Primero de Mayo', '88881136', 'mia.pineda@email.com', '2024-08-19', 4),
(37, 'Gonzalo', 'Reyes', '001-190600-1037K', 'M', '2000-06-19', 'Barrio Boer', '88881137', 'gonzalo.reyes@email.com', '2025-01-20', 1),
(38, 'Emilia', 'Soto', '001-081003-1038L', 'F', '2003-10-08', 'Reparto Los Bautistas', '88881138', 'emilia.soto@email.com', '2025-08-18', 3),
(39, 'Maximiliano', 'Guerrero', '001-261299-1039M', 'M', '1999-12-26', 'Villa Libertad', '88881139', 'maximiliano.guerrero@email.com', '2026-01-19', 2),
(40, 'Julieta', 'Cortés', '001-100202-1040N', 'F', '2002-02-10', 'Barrio Waspan Norte', '88881140', 'julieta.cortes@email.com', '2026-01-19', 5);


---CARRERA
INSERT INTO carrera (nombre, duracion_semestre, titulo) VALUES
('Ingeniería en Sistemas de Información', 10, 'Ingeniero de Sistemas'),
('Licenciatura en Administración de Empresas', 8, 'Licenciado en Administración'),
('Licenciatura en Contaduría Pública', 8, 'Contador Público'),
('Medicina Humana', 12, 'Médico Cirujano'),
('Derecho', 10, 'Abogado'),
('Arquitectura', 10, 'Arquitecto'),
('Ingeniería Civil', 10, 'Ingeniero Civil'),
('Ingeniería Industrial', 10, 'Ingeniero Industrial'),
('Psicología', 9, 'Licenciado en Psicología'),
('Licenciatura en Mercadotecnia', 8, 'Licenciado en Mercadotecnia'),
('Enfermería', 8, 'Licenciado en Enfermería'),
('Odontología', 10, 'Cirujano Dentista'),
('Licenciatura en Periodismo', 8, 'Licenciado en Periodismo'),
('Diseño Gráfico', 8, 'Licenciado en Diseño Gráfico'),
('Ingeniería Electrónica', 10, 'Ingeniero Electrónico'),
('Ingeniería Mecánica', 10, 'Ingeniero Mecánico'),
('Agronomía', 10, 'Ingeniero Agrónomo'),
('Licenciatura en Turismo y Hotelería', 8, 'Licenciado en Turismo'),
('Relaciones Internacionales', 8, 'Licenciado en Relaciones Int.'),
('Licenciatura en Pedagogía', 8, 'Licenciado en Pedagogía'),
('Licenciatura en Economía', 8, 'Licenciado en Economía'),
('Ingeniería Química', 10, 'Ingeniero Químico'),
('Medicina Veterinaria', 10, 'Médico Veterinario'),
('Licenciatura en Biología', 8, 'Licenciado en Biología'),
('Trabajo Social', 8, 'Licenciado en Trabajo Social'),
('Licenciatura en Lenguas Extranjeras', 8, 'Licenciado en Idiomas'),
('Ingeniería Ambiental', 10, 'Ingeniero Ambiental'),
('Ingeniería Mecatrónica', 10, 'Ingeniero Mecatrónico'),
('Licenciatura en Filosofía', 8, 'Licenciado en Filosofía'),
('Licenciatura en Historia', 8, 'Licenciado en Historia'),
('Ingeniería Biomédica', 10, 'Ingeniero Biomédico'),
('Licenciatura en Sociología', 8, 'Licenciado en Sociología'),
('Farmacia y Bioquímica', 10, 'Licenciado en Farmacia'),
('Licenciatura en Gastronomía', 8, 'Licenciado en Gastronomía'),
('Ingeniería Mecánica Eléctrica', 10, 'Ingeniero Electromecánico'),
('Licenciatura en Ciencias de la Computación', 8, 'Licenciado en Computación'),
('Licenciatura en Nutrición', 8, 'Licenciado en Nutrición'),
('Ingeniería Agroindustrial', 10, 'Ingeniero Agroindustrial'),
('Licenciatura en Diseño de Interiores', 8, 'Diseñador de Interiores'),
('Licenciatura en Criminología', 8, 'Licenciado en Criminología');


-- PROFESOR
INSERT INTO profesor (nombre, apellido, cedula, telefono, correo, especialidad) VALUES
('Roberto', 'Mendoza', '001-100575-2001A', '87654321', 'roberto.mendoza@email.com', 'Sistemas Operativos'),
('Elena', 'Ríos', '001-120880-2002B', '87654322', 'elena.rios@email.com', 'Bases de Datos'),
('Fernando', 'Alvarez', '001-250378-2003C', '87654323', 'fernando.alvarez@email.com', 'Derecho Penal'),
('Patricia', 'Soto', '001-140782-2004D', '87654324', 'patricia.soto@email.com', 'Anatomía Humana'),
('Javier', 'Morales', '001-030979-2005E', '87654325', 'javier.morales@email.com', 'Cálculo Multivariable'),
('Claudia', 'Guzmán', '001-181185-2006F', '87654326', 'claudia.guzman@email.com', 'Contabilidad Financiera'),
('Ricardo', 'Paredes', '001-090181-2007G', '87654327', 'ricardo.paredes@email.com', 'Estructuras de Hormigón'),
('Gabriela', 'Navarro', '001-220483-2008H', '87654328', 'gabriela.navarro@email.com', 'Marketing Digital'),
('Hugo', 'Cordero', '001-070677-2009I', '87654329', 'hugo.cordero@email.com', 'Física Cuántica'),
('Monica', 'Espinoza', '001-151084-2010J', '87654330', 'monica.espinoza@email.com', 'Psicología Clínica'),
('Esteban', 'Salazar', '001-300286-2011K', '87654331', 'esteban.salazar@email.com', 'Redes de Computadoras'),
('Valeria', 'Miranda', '001-040588-2012L', '87654332', 'valeria.miranda@email.com', 'Derecho Mercantil'),
('Gonzalo', 'Aguilar', '001-190976-2013M', '87654333', 'gonzalo.aguilar@email.com', 'Química Orgánica'),
('Beatriz', 'Pineda', '001-111282-2014N', '87654334', 'beatriz.pineda@email.com', 'Enfermería Quirúrgica'),
('Andrés', 'Campos', '001-280380-2015O', '87654335', 'andres.campos@email.com', 'Econometría'),
('Rosa', 'Fuentes', '001-060879-2016P', '87654336', 'rosa.fuentes@email.com', 'Periodismo Investigativo'),
('Mauricio', 'Cárdenas', '001-130184-2017Q', '87654337', 'mauricio.cardenas@email.com', 'Arquitectura Bioclimática'),
('Silvia', 'Santamaría', '001-210787-2018R', '87654338', 'silvia.santamaria@email.com', 'Diseño UX/UI'),
('Héctor', 'Villalobos', '001-020478-2019S', '87654339', 'hector.villalobos@email.com', 'Robótica Industrial'),
('Verónica', 'Paredes', '001-171083-2020T', '87654340', 'veronica.paredes@email.com', 'Finanzas Corporativas'),
('Sergio', 'Pena', '001-230581-2021U', '87654341', 'sergio.pena@email.com', 'Inteligencia Artificial'),
('Lidia', 'Benítez', '001-100285-2022V', '87654342', 'lidia.benitez@email.com', 'Microbiología'),
('Mario', 'Garrido', '001-270979-2023W', '87654343', 'mario.garrido@email.com', 'Mecánica de Fluidos'),
('Natalia', 'Cabrera', '001-051186-2024X', '87654344', 'natalia.cabrera@email.com', 'Sociología Política'),
('Óscar', 'Maldonado', '001-160382-2025Y', '87654345', 'oscar.maldonado@email.com', 'Gestión de Proyectos'),
('Lorena', 'Ibarra', '001-010884-2026Z', '87654346', 'lorena.ibarra@email.com', 'Pedagogía Infantil'),
('Felipe', 'Bustos', '001-200180-2027A', '87654347', 'felipe.bustos@email.com', 'Sistemas Embebidos'),
('Carolina', 'Roldán', '001-120683-2028B', '87654348', 'carolina.roldan@email.com', 'Derecho Internacional'),
('César', 'Mejía', '001-290877-2029C', '87654349', 'cesar.mejia@email.com', 'Topografía'),
('Adriana', 'Castañeda', '001-080485-2030D', '87654350', 'adriana.castaneda@email.com', 'Farmacología'),
('Ignacio', 'Lara', '001-141181-2031E', '87654351', 'ignacio.lara@email.com', 'Álgebra Lineal'),
('Daniela', 'Orozco', '001-260288-2032F', '87654352', 'daniela.orozco@email.com', 'Psicología Educativa'),
('Manuel', 'Pacheco', '001-030779-2033G', '87654353', 'manuel.pacheco@email.com', 'Termodinámica'),
('Teresa', 'Vargas', '001-180982-2034H', '87654354', 'teresa.vargas@email.com', 'Biología Celular'),
('Raúl', 'Solares', '001-091280-2035I', '87654355', 'raul.solares@email.com', 'Ciberseguridad'),
('Alicia', 'Crespo', '001-240386-2036J', '87654356', 'alicia.crespo@email.com', 'Administración Pública'),
('Guillermo', 'Soria', '001-110583-2037K', '87654357', 'guillermo.soria@email.com', 'Geotecnia'),
('Yolanda', 'Beltrán', '001-281084-2038L', '87654358', 'yolanda.beltran@email.com', 'Historia Contemporánea'),
('Francisco', 'Rios', '001-070182-2039M', '87654359', 'francisco.rios@email.com', 'Ingeniería de Software'),
('Gloria', 'Valenzuela', '001-150685-2040N', '87654360', 'gloria.valenzuela@email.com', 'Nutrición Clínica');

-- ASIGNATURA
INSERT INTO asignatura (id_carrera, id_profesor, nombre, horas, credito) VALUES
(1, 1, 'Sistemas Operativos I', 64, 4),
(1, 2, 'Bases de Datos Relacionales', 80, 5),
(1, 11, 'Redes de Computadoras I', 64, 4),
(1, 21, 'Inteligencia Artificial', 80, 5),
(1, 35, 'Fundamentos de Ciberseguridad', 64, 4),
(1, 39, 'Ingeniería de Software I', 80, 5),
(2, 6, 'Contabilidad General', 64, 4),
(2, 8, 'Principios de Marketing', 48, 3),
(2, 20, 'Finanzas Corporativas', 64, 4),
(2, 25, 'Gestión de Proyectos', 64, 4),
(2, 36, 'Administración Estratégica', 48, 3),
(3, 6, 'Contabilidad de Costos', 80, 5),
(3, 15, 'Econometría Básica', 64, 4),
(3, 20, 'Análisis de Estados Financieros', 64, 4),
(4, 4, 'Anatomía Humana I', 96, 6),
(4, 14, 'Enfermería Quirúrgica Avanzada', 80, 5),
(4, 22, 'Microbiología Médica', 80, 5),
(4, 30, 'Farmacología Clínica', 96, 6),
(4, 40, 'Nutrición y Salud', 48, 3),
(5, 3, 'Derecho Penal I', 64, 4),
(5, 12, 'Derecho Mercantil y Comercial', 64, 4),
(5, 28, 'Derecho Internacional Público', 64, 4),
(6, 17, 'Arquitectura Bioclimática', 80, 5),
(6, 18, 'Diseño Digital y UX', 64, 4),
(7, 7, 'Estructuras de Hormigón Armado', 80, 5),
(7, 23, 'Mecánica de Fluidos', 64, 4),
(7, 29, 'Topografía General', 80, 5),
(7, 37, 'Geotecnia Aplicada', 64, 4),
(8, 25, 'Gestión de la Calidad Industrial', 64, 4),
(8, 33, 'Termodinámica Técnica', 80, 5),
(9, 10, 'Psicología Clínica I', 64, 4),
(9, 32, 'Psicología Educativa', 64, 4),
(10, 8, 'Estrategias de Marketing Digital', 48, 3),
(13, 16, 'Periodismo de Investigación', 64, 4),
(15, 19, 'Robótica e Automatización', 80, 5),
(15, 27, 'Sistemas Embebidos', 64, 4),
(20, 26, 'Pedagogía y Métodos de Enseñanza', 48, 3),
(22, 13, 'Química Orgánica I', 80, 5),
(29, 38, 'Historia Contemporánea Mundial', 48, 3),
(36, 31, 'Álgebra Lineal y Geometría', 64, 4);

-- HORARIO
INSERT INTO horario (id_asignatura, dia_semana, hora_inicio, hora_fin) VALUES
(1, 'Lunes', '08:00:00', '10:00:00'),
(1, 'Miércoles', '08:00:00', '10:00:00'),
(2, 'Martes', '10:00:00', '12:00:00'),
(2, 'Jueves', '10:00:00', '12:00:00'),
(3, 'Lunes', '13:00:00', '15:00:00'),
(3, 'Viernes', '13:00:00', '15:00:00'),
(4, 'Martes', '08:00:00', '11:00:00'),
(4, 'Jueves', '08:00:00', '11:00:00'),
(5, 'Miércoles', '10:00:00', '12:00:00'),
(5, 'Viernes', '10:00:00', '12:00:00'),
(6, 'Lunes', '15:00:00', '18:00:00'),
(6, 'Miércoles', '15:00:00', '18:00:00'),
(7, 'Martes', '07:00:00', '09:00:00'),
(7, 'Jueves', '07:00:00', '09:00:00'),
(8, 'Sábado', '08:00:00', '12:00:00'),
(9, 'Lunes', '10:00:00', '12:00:00'),
(9, 'Miércoles', '10:00:00', '12:00:00'),
(10, 'Martes', '14:00:00', '16:00:00'),
(10, 'Jueves', '14:00:00', '16:00:00'),
(11, 'Viernes', '14:00:00', '17:00:00'),
(12, 'Lunes', '07:00:00', '09:00:00'),
(12, 'Miércoles', '07:00:00', '09:00:00'),
(13, 'Martes', '09:00:00', '12:00:00'),
(14, 'Jueves', '09:00:00', '12:00:00'),
(15, 'Lunes', '08:00:00', '11:00:00'),
(15, 'Viernes', '08:00:00', '11:00:00'),
(16, 'Martes', '13:00:00', '16:00:00'),
(17, 'Miércoles', '13:00:00', '16:00:00'),
(18, 'Jueves', '15:00:00', '18:00:00'),
(19, 'Viernes', '07:00:00', '10:00:00'),
(20, 'Sábado', '13:00:00', '17:00:00'),
(21, 'Lunes', '11:00:00', '13:00:00'),
(21, 'Miércoles', '11:00:00', '13:00:00'),
(22, 'Martes', '16:00:00', '18:00:00'),
(22, 'Jueves', '16:00:00', '18:00:00'),
(23, 'Viernes', '09:00:00', '12:00:00'),
(24, 'Lunes', '16:00:00', '19:00:00'),
(25, 'Martes', '10:00:00', '13:00:00'),
(26, 'Miércoles', '16:00:00', '19:00:00'),
(27, 'Jueves', '11:00:00', '13:00:00');

-- MATRICULA
INSERT INTO matricula (id_estudiante, periodo, fecha_matricula, estado) VALUES
(1, '2024-1', '2024-01-10', 'Activo'),
(2, '2024-1', '2024-01-10', 'Activo'),
(3, '2024-1', '2024-01-11', 'Activo'),
(4, '2024-1', '2024-01-11', 'Inactivo'),
(5, '2024-1', '2024-01-12', 'Activo'),
(6, '2024-1', '2024-01-12', 'Activo'),
(7, '2024-1', '2024-01-13', 'Retirado'),
(8, '2024-1', '2024-01-13', 'Activo'),
(9, '2024-1', '2024-01-14', 'Activo'),
(10, '2024-1', '2024-01-14', 'Activo'),
(11, '2024-1', '2024-01-15', 'Activo'),
(12, '2024-1', '2024-01-15', 'Inactivo'),
(13, '2024-1', '2024-01-16', 'Activo'),
(14, '2024-1', '2024-01-16', 'Activo'),
(15, '2024-1', '2024-01-17', 'Activo'),
(16, '2024-2', '2024-06-10', 'Activo'),
(17, '2024-2', '2024-06-10', 'Activo'),
(18, '2024-2', '2024-06-11', 'Activo'),
(19, '2024-2', '2024-06-11', 'Retirado'),
(20, '2024-2', '2024-06-12', 'Activo'),
(21, '2024-2', '2024-06-12', 'Activo'),
(22, '2024-2', '2024-06-13', 'Activo'),
(23, '2024-2', '2024-06-13', 'Inactivo'),
(24, '2024-2', '2024-06-14', 'Activo'),
(25, '2024-2', '2024-06-14', 'Activo'),
(26, '2025-1', '2025-01-08', 'Activo'),
(27, '2025-1', '2025-01-08', 'Activo'),
(28, '2025-1', '2025-01-09', 'Activo'),
(29, '2025-1', '2025-01-09', 'Activo'),
(30, '2025-1', '2025-01-10', 'Retirado'),
(31, '2025-1', '2025-01-10', 'Activo'),
(32, '2025-1', '2025-01-11', 'Activo'),
(33, '2025-1', '2025-01-11', 'Activo'),
(34, '2025-1', '2025-01-12', 'Inactivo'),
(35, '2025-1', '2025-01-12', 'Activo'),
(36, '2025-2', '2025-06-15', 'Activo'),
(37, '2025-2', '2025-06-15', 'Activo'),
(38, '2025-2', '2025-06-16', 'Activo'),
(39, '2025-2', '2025-06-16', 'Activo'),
(40, '2025-2', '2025-06-17', 'Activo');

-- DETALLE_MATRICULA

INSERT INTO detalle_matricula (id_matricula, id_asignatura, nota, estado) VALUES
(1, 1, 85.50, 'Aprobada'),
(1, 2, 90.00, 'Aprobada'),
(2, 7, 78.25, 'Aprobada'),
(2, 8, 88.00, 'Aprobada'),
(3, 1, 55.00, 'Reprobada'),
(3, 3, 92.50, 'Aprobada'),
(4, 15, NULL, 'Matriculada'),
(5, 7, 81.00, 'Aprobada'),
(5, 9, 74.50, 'Aprobada'),
(6, 23, 60.00, 'Reprobada'),
(7, 1, NULL, 'Retirada'),
(8, 15, 95.00, 'Aprobada'),
(9, 12, 87.75, 'Aprobada'),
(10, 7, 70.00, 'Aprobada'),
(11, 25, 83.00, 'Aprobada'),
(12, 1, NULL, 'Matriculada'),
(13, 15, 68.50, 'Aprobada'),
(14, 7, 91.00, 'Aprobada'),
(15, 12, 84.00, 'Aprobada'),
(16, 4, 88.50, 'Aprobada'),
(17, 5, 76.00, 'Aprobada'),
(18, 16, 90.50, 'Aprobada'),
(19, 7, NULL, 'Retirada'),
(20, 12, 62.00, 'Reprobada'),
(21, 25, 89.00, 'Aprobada'),
(22, 1, 94.25, 'Aprobada'),
(23, 15, NULL, 'Matriculada'),
(24, 7, 82.00, 'Aprobada'),
(25, 12, 79.50, 'Aprobada'),
(26, 2, 86.00, 'Aprobada'),
(27, 6, 93.00, 'Aprobada'),
(28, 17, 71.50, 'Aprobada'),
(29, 8, 85.00, 'Aprobada'),
(30, 12, NULL, 'Retirada'),
(31, 26, 88.75, 'Aprobada'),
(32, 1, 64.00, 'Reprobada'),
(33, 15, 96.00, 'Aprobada'),
(34, 7, NULL, 'Matriculada'),
(35, 12, 77.00, 'Aprobada'),
(36, 21, 89.50, 'Aprobada');

--- PAGO
INSERT INTO pago (id_matricula, fecha_pago, monto, tipo_pago, estado) VALUES
(1, '2024-01-10', 150.00, 'Sinpe', 'Completado'),
(1, '2024-02-10', 100.00, 'Transferencia', 'Completado'),
(2, '2024-01-10', 250.00, 'Tarjeta', 'Completado'),
(3, '2024-01-11', 150.00, 'Efectivo', 'Completado'),
(4, '2024-01-11', 50.00, 'Sinpe', 'Rechazado'),
(5, '2024-01-12', 200.00, 'Transferencia', 'Completado'),
(6, '2024-01-12', 150.00, 'Tarjeta', 'Completado'),
(7, '2024-01-13', 100.00, 'Sinpe', 'Anulado'),
(8, '2024-01-13', 250.00, 'Efectivo', 'Completado'),
(9, '2024-01-14', 150.00, 'Transferencia', 'Completado'),
(10, '2024-01-14', 180.00, 'Tarjeta', 'Completado'),
(11, '2024-01-15', 200.00, 'Sinpe', 'Completado'),
(12, '2024-01-15', 150.00, 'Efectivo', 'Pendiente'),
(13, '2024-01-16', 220.00, 'Transferencia', 'Completado'),
(14, '2024-01-16', 150.00, 'Tarjeta', 'Completado'),
(15, '2024-01-17', 300.00, 'Sinpe', 'Completado'),
(16, '2024-06-10', 150.00, 'Transferencia', 'Completado'),
(17, '2024-06-10', 250.00, 'Efectivo', 'Completado'),
(18, '2024-06-11', 150.00, 'Tarjeta', 'Completado'),
(19, '2024-06-11', 100.00, 'Sinpe', 'Anulado'),
(20, '2024-06-12', 200.00, 'Transferencia', 'Completado'),
(21, '2024-06-12', 150.00, 'Efectivo', 'Completado'),
(22, '2024-06-13', 180.00, 'Tarjeta', 'Completado'),
(23, '2024-06-13', 150.00, 'Sinpe', 'Pendiente'),
(24, '2024-06-14', 220.00, 'Transferencia', 'Completado'),
(25, '2024-06-14', 150.00, 'Efectivo', 'Completado'),
(26, '2025-01-08', 250.00, 'Sinpe', 'Completado'),
(27, '2025-01-08', 150.00, 'Tarjeta', 'Completado'),
(28, '2025-01-09', 200.00, 'Transferencia', 'Completado'),
(29, '2025-01-09', 150.00, 'Efectivo', 'Completado'),
(30, '2025-01-10', 120.00, 'Sinpe', 'Anulado'),
(31, '2025-01-10', 180.00, 'Tarjeta', 'Completado'),
(32, '2025-01-11', 150.00, 'Transferencia', 'Completado'),
(33, '2025-01-11', 220.00, 'Efectivo', 'Completado'),
(34, '2025-01-12', 150.00, 'Sinpe', 'Rechazado'),
(35, '2025-01-12', 250.00, 'Tarjeta', 'Completado'),
(36, '2025-06-15', 150.00, 'Transferencia', 'Completado'),
(37, '2025-06-15', 200.00, 'Efectivo', 'Completado'),
(38, '2025-06-16', 150.00, 'Sinpe', 'Completado'),
(39, '2025-06-16', 180.00, 'Tarjeta', 'Completado');

use db_universidad;

go
select * from estudiante;
select * from asignatura;
select * from pago;
select * from carrera;
select * from estudiante;
select * from matricula;
select * from detalle_matricula;


