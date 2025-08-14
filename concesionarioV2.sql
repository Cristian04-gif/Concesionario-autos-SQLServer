
create database CONCENCIONARIOV2
use CONCENCIONARIOV2

create table Sede (
id_sede char(4) not null primary key,
nombre varchar(30) not null,
direccion varchar(50) not null,
telefono varchar(20)not null)

create table Proveedor (
id_proveedor char(4) not null primary key,
nombre varchar(30) not null,
direccion varchar(50) not null,
telefono varchar(20) not null,
correo_electronico varchar(50) not null)

create table DetalleProveedor(
id_sede char(4) not null references Sede,
id_proveedor char(4) not null references Proveedor,
cantidad_suministrada int not null,
tipo_producto varchar(30) not null)

create table Automovil (
id_automovil char(4) not null primary key,
modelo varchar(20) not null,
marca varchar(20) not null,
año_fabricacion int not null,
tipo_carroceria varchar(10) not null,
color varchar(10) not null,
motorizacion varchar(20) not null,
placa char(7) not null,
uso varchar(20) not null,
num_chasis varchar(30) not null,
linea varchar(50) not null,
cm3_motor int not null)

create table Inventario (
id_inventario char(4) not null primary key,
id_automovil char(4) not null references Automovil,
cantidad_disponible int not null,
precio_compra money not null,
fecha_entrada date not null,
estado varchar(20) not null,
id_sede char(4) not null references Sede)

create table Cargo (
id_cargo char(4) not null primary key,
Nombre_cargo varchar(20) not null)

create table Distrito(
id_distrito char(4) not null primary key,
Nombre_Distrito varchar(50) not null)

create table Empleados (
id_empleado char(4) not null primary key,
nombre varchar(20) not null,
apellido varchar(20) not null,
id_cargo char(4) not null references Cargo,
fecha_contratacion date not null,
salario money not null,
id_sede char(4)not null references Sede,
id_distrito char(4) not null references Distrito)

create table CatalogoAutos (
id_catalogo char(5)not null primary key,
id_automovil char(4)not null references Automovil,
descripcion varchar(255) not null,
caracteristicas varchar(max) not null);

create table Cliente (
id_cliente char(5) not null primary key,
nombre varchar(30) not null,
apellido varchar(30) not null,
direccion varchar(50) not null,
telefono varchar(20) not null,
correo_electronico varchar(100),
id_distrito char(4) not null references Distrito)

create table Cotizacion (
id_cotizacion char(5) not null primary key,
id_cliente char(5) not null references Cliente,
id_automovil char(4) not null references Automovil,
fecha_cotizacion date not null,
precio_cotizado money not null)

create table DocumentoVenta (
id_venta char(5)not null primary key,
fecha_venta date not null,
id_sede char(4) not null references Sede,
id_empleado char(4) not null references Empleados,
id_cliente char(5) not null references Cliente)

create table DetalleVenta (
id_venta char(5)not null references DocumentoVenta,
id_automovil char(4) not null references Automovil,
cantidad int not null,
precio_venta money not null,
tipo_pago varchar(50) not null,
CDP varchar(50) not null,
observacion varchar(50) not null)

create table PropiedadAutomovil (
id_propietario char(5) not null primary key,
id_cliente char(5) not null references Cliente,
id_automovil char(4) not null references automovil,
fecha_adquisicion date not null)

create table TarjetaCirculacion (
id_tarjeta char(5) not null primary key,
id_propietario char(5) not null references PropiedadAutomovil,
id_automovil char(4) not null references Automovil,
num_cirtificado_propiedad varchar(20) not null)

create table SituacionTarjeta (
id_tarjeta char(5) not null references TarjetaCirculacion,
estado varchar(15) not null,
motivo_inactividad varchar(50) not null,
multas int not null,
total money not null,
fecha_consulta date not null)

create table RevisionTecnica (
id_revision char(5) not null primary key,
id_propietario char(5) not null references PropiedadAutomovil,
id_automovil char(4) not null references Automovil,
fecha_revision date not null)

create table DetalleRevision (
id_revision char(5) not null references RevisionTecnica,
descripcion varchar(max) not null,
firma varchar(30) not null,
observacion varchar(50) not null)

/****************************************RESTRICCIONES*******************************************/
--Restricciones Sede
alter table Sede
add constraint ck_idSede
check(id_sede like 'S[0-9][0-9][0-9]')

--Restricciones Proveedor
alter table Proveedor
add constraint ck_idProveedor
check(id_proveedor like 'P[0-9][0-9][0-9]'),
constraint df_correo
default 'No registrado' for correo_electronico

--Restricciones DetalleProveedor
alter table DetalleProveedor
add constraint ck_cantidad
check (cantidad_suministrada > 0)

--Restricciones Automovil
alter table Automovil
add constraint ck_idAuto
check (id_automovil like 'A[0-9][0-9][0-9]'),
constraint uq_placa
unique (placa),
constraint ck_uso
check (uso = 'Particular' or uso = 'Comercial')

--Restricciones Inventario
alter table Inventario
add constraint ch_idInventario
check (id_inventario like 'I[0-9][0-9][0-9]'),
constraint ch_cantidadDisponible
check (cantidad_disponible > 0),
constraint ch_estado
check (estado = 'Disponible'),
constraint ck_precio_compra
check (precio_compra > 0)

--Restricciones Cargo
alter table Cargo
add constraint ck_idCargo
check (id_cargo like 'C[0-9][0-9][0-9]'),
constraint uq_nombreCargo
unique (Nombre_Cargo)

--Restricciones Distrito
alter table Distrito
add constraint ck_idDistrito
check (id_distrito like 'D[0-9][0-9][0-9]'),
constraint uq_nombreDistrito
unique (Nombre_Distrito)

--Restricciones Empleados
alter table Empleados
add constraint ck_idEmpleados
check (id_empleado like 'E[0-9][0-9][0-9]'),
constraint ck_salario
check (salario > 1000)

--Restricciones CatalogoAutos
alter table CatalogoAutos
add constraint ck_idCatalogo
check (id_catalogo like 'CA[0-9][0-9][0-9]')

--Restricciones Cliente
alter table Cliente
add constraint ck_idCliente
check (id-cliente like 'CL[0-9][0-9][0-9]'),
constraint uq_correo
unique (correo_electronico)

--Restricciones Cotizacion
alter table Cotizacion
add constraint ck_idCotizacion
check (id_cotizacion like 'CT[0-9][0-9][0-9]')

--Restricciones DocumentoVenta
alter table DocumentoVenta
add constraint ck_idVenta
check (id_venta like 'DV[0-9][0-9][0-9]')

--Restricciones DetalleVenta
alter table DetalleVenta
add constraint ck_cantidadVenta
check (cantidad > 0),
constraint df_observacion
DEFAULT 'Ninguna' for observacion,
constraint ck_cdp
check (CDP = 'Boleta' or CDP = 'Factura')

--Restricciones PropiedadAutomovil
alter table PropiedadAutomovil
add constraint ck_idPropietario
check (id_propietario like 'PA[0-9][0-9][0-9]')

--Restricciones TarjetaCirculacion
alter table TarjetaCirculacion
add constraint ck_idTarjeta
check (id_tarjeta like 'TC[0-9][0-9][0-9]'),
constraint uq_numCertificado
unique (num_cirtificado_propiedad)

--Restricciones SituacionTarjeta
alter table SituacionTarjeta
add constraint ck_estado
check (estado = 'Activo' or estado = 'En proceso'),
constraint df_motivoInac
default 'Ninguna' for motivo_inactividad

--Restricciones RevisionTecnica
alter table RevisionTecnica
add constraint ck_idRevision
check (id_revision like 'RV[0-9][0-9][0-9]')

/***********************************DATOS****************************************/
insert into Sede(id_sede, nombre, direccion,telefono)
Values('s001','AutolandNorte','Av.Pacifico','+51 974829121'),
	  ('s002','AutolandSur','Jr.Pizarro','+51 974829122'),
	  ('s003','AWutolandCentro','Av.Jorge Chavez','+51 974829123')

insert into Proveedor(id_proveedor,nombre,direccion,telefono)
Values('P001','Diego','Av. Parral','992131245'),
	  ('P002','Gabriela','Jr. Los Incas','986764785'),
	  ('P003','Javer','Jr.Micaela Bastidas','987412435'),
	  ('P004','Andrea','Av. Venezuela','957563546'),
	  ('P005','Leonardo','Av. Huayna Capac','998546741')

insert into DetalleProveedor(id_sede,id_proveedor,cantidad_suministrada,tipo_producto)
values('s001','P001',20,'sedan'),
	  ('s001','P001',12,'bus'),
	  ('s001','P001',10,'deportivo'),
	  ('s001','P001',15,'todo terreno'),
	  ('s001','P001',30,'SUV'),
	  ('s002','P002',25,'hatchback'),
	  ('s002','P002',16,'coupe'),
	  ('s002','P002',9,'SedanEv'),
	  ('s002','P002',13,'SUVEV'),
	  ('s002','P002',6,'Deportivo'),
	  ('s003','P003',18,'MiniVan'),
	  ('s003','P003',12,'Van'),
	  ('s003','P003',14,'sedan'),
	  ('s003','P003',6,'deportivo'),
	  ('s003','P003',5,'Camion')

insert into  Automovil(id_automovil,modelo,marca,año_fabricacion,tipo_carroceria,color,motorizacion,placa,uso,num_chasis,linea,cm3_motor)
values('A001', 'Model S', 'Tesla', 2020, 'Sedan', 'Rojo', 'Eléctrico', 'ABC1234', 'particular', '1HGCM82633A123456', 'Performance', 75),
	  ('A002', 'Civic', 'Honda', 2018, 'Sedan', 'Negro', 'Gasolina', 'XYZ5678', 'particular', '2HGES25725H612345', 'EX', 1800),
	  ('A003', 'Corolla', 'Toyota', 2019, 'Sedan', 'Blanco', 'Gasolina', 'LMN2345', 'particular', '4T1BE32K45U123456', 'LE', 1800),
	  ('A004', 'Mustang', 'Ford', 2021, 'Coupé', 'Azul', 'Gasolina', 'JKL7890', 'particular', '1ZVBP8AM4E5256789', 'GT', 5000),
	  ('A005', 'Model 3', 'Tesla', 2022, 'Sedan', 'Gris', 'Eléctrico', 'DEF4567', 'particular', '5YJ3E1EA5JF123456', 'Long Range', 75),
	  ('A006', 'Accord', 'Honda', 2020, 'Sedan', 'Plateado', 'Gasolina', 'GHJ1234', 'particular', '1HGCR2F3XFA012345', 'Sport', 2000),
	  ('A007', 'Camry', 'Toyota', 2018, 'Sedan', 'Negro', 'Gasolina', 'QWE5678', 'particular', '4T1BF1FK9GU123456', 'SE', 2500),
	  ('A008', 'F-150', 'Ford', 2019, 'Pickup', 'Rojo', 'Gasolina', 'RTY2345', 'comercial', '1FTFW1E52JKE12345', 'XLT', 3500),
	  ('A009', 'Altima', 'Nissan', 2021, 'Sedan', 'Blanco', 'Gasolina', 'UIO7890', 'particular', '1N4AL3AP2GC123456', 'SV', 2500),
	  ('A010', 'Rav4', 'Toyota', 2022, 'SUV', 'Azul', 'Gasolina', 'PAS4567', 'particular', '2T3RFREV3JW123456', 'XLE', 2500),
	  ('A011', 'CX-5', 'Mazda', 2019, 'SUV', 'Negro', 'Gasolina', 'ZXC1234', 'particular', 'JM3KFBDM2J1201234', 'Grand Touring', 2500),
	  ('A012', 'Cherokee', 'Jeep', 2020, 'SUV', 'Gris', 'Gasolina', 'VBN5678', 'comercial', '1C4PJMDX1KD123456', 'Limited', 3200),
	  ('A013', 'Impreza', 'Subaru', 2018, 'Sedan', 'Azul', 'Gasolina', 'ASD2345', 'particular', 'JF1GJAA67JH123456', 'Base', 2000),
	  ('A014', 'Sentra', 'Nissan', 2021, 'Sedan', 'Blanco', 'Gasolina', 'FGH7890', 'particular', '3N1AB7AP4KY123456', 'SR', 1800),
	  ('A015', 'Explorer', 'Ford', 2019, 'SUV', 'Rojo', 'Gasolina', 'HJK4567', 'particular', '1FM5K7D85HGA12345', 'XLT', 3500),
	  ('A016', 'Highlander', 'Toyota', 2022, 'SUV', 'Negro', 'Gasolina', 'BNM1234', 'particular', '5TDYZRFH8KS123456', 'LE', 3500),
	  ('A017', 'Outback', 'Subaru', 2020, 'SUV', 'Verde', 'Gasolina', 'QAZ5678', 'particular', '4S4BRCAC9L3231234', 'Premium', 2500),
	  ('A018', 'Tucson', 'Hyundai', 2018, 'SUV', 'Azul', 'Gasolina', 'WSX2345', 'comercial', 'KM8J33A48JU123456', 'SEL', 2000),
	  ('A019', 'Santa Fe', 'Hyundai', 2021, 'SUV', 'Blanco', 'Gasolina', 'EDC7890', 'particular', '5NMZTDLB8LH123456', 'Limited', 2500),
	  ('A020', 'Soul', 'Kia', 2019, 'Crossover', 'Rojo', 'Gasolina', 'RFV4567', 'particular', 'KNDJP3A5XK7123456', 'Plus', 2000)

insert into Inventario(id_inventario,id_automovil,cantidad_disponible,precio_compra,fecha_entrada,estado,id_sede)
values('I001', 'A001', 5, 75000, '2023-01-15', 'Disponible', 's001'),
	  ('I002', 'A002', 10, 22000, '2023-02-10', 'Disponible', 's002'),
	  ('I003', 'A003', 8, 21000, '2023-03-05', 'Disponible', 's003'),
	  ('I004', 'A004', 2, 50000, '2023-01-20', 'Disponible', 's001'),
	  ('I005', 'A005', 7, 70000, '2023-04-15', 'Disponible', 's002'),
	  ('I006', 'A006', 9, 25000, '2023-05-12', 'Disponible', 's003'),
	  ('I007', 'A007', 11, 24000, '2023-06-01', 'Disponible', 's001'),
	  ('I008', 'A008', 3, 35000, '2023-02-25', 'Disponible', 's002'),
	  ('I009', 'A009', 6, 23000, '2023-07-10', 'Disponible', 's003'),
	  ('I010', 'A010', 5, 30000, '2023-08-15', 'Disponible', 's001'),
	  ('I011', 'A011', 4, 28000, '2023-09-05', 'Disponible', 's002'),
	  ('I012', 'A012', 2, 32000, '2023-10-12', 'Disponible', 's003'),
	  ('I013', 'A013', 8, 21000, '2023-11-01', 'Disponible', 's001'),
	  ('I014', 'A014', 10, 20000, '2023-12-10', 'Disponible', 's002'),
	  ('I015', 'A015', 7, 35000, '2023-01-10', 'Disponible', 's003'),
	  ('I016', 'A016', 6, 34000, '2023-03-15', 'Disponible', 's001'),
	  ('I017', 'A017', 5, 32000, '2023-04-20', 'Disponible', 's002'),
	  ('I018', 'A018', 4, 22000, '2023-05-25', 'Disponible', 's003'),
	  ('I019', 'A019', 3, 33000, '2023-06-15', 'Disponible', 's001'),
	  ('I020', 'A020', 2, 21000, '2023-07-25', 'Disponible', 's002')


insert into Cargo(id_cargo,Nombre_cargo)
values('C001', 'Gerente General'),
	  ('C002', 'Gerente de Ventas'),
	  ('C003', 'Gerente de Compras'),
	  ('C004', 'Contador'),
	  ('C005', 'Jefe de Taller'),
	  ('C006', 'Asistente'),
	  ('C007', 'Vendedor'),
	  ('C008', 'Comprador'),
	  ('C009', 'Técnico de Taller'),
	  ('C010', 'Gerente RRHH')

insert into Distrito(id_distrito,Nombre_Distrito)
values('D001', 'Miraflores'),
	  ('D002', 'San Isidro'),
	  ('D003', 'Barranco'),
	  ('D004', 'Surco'),
	  ('D005', 'San Borja'),
	  ('D006', 'La Molina'),
	  ('D007', 'San Miguel'),
	  ('D008', 'Pueblo Libre'),
	  ('D009', 'Lince'),
	  ('D010', 'Jesús María')

insert into Empleados(id_empleado,nombre,apellido,id_cargo,fecha_contratacion,salario,id_sede,id_distrito)
values('E001', 'Juan', 'Perez', 'C001', '2024-01-01', 2500, 's001', 'D003'),
      ('E002', 'Maria', 'Lopez', 'C002', '2023-05-15', 2800, 's001', 'D007'),
	  ('E003', 'Carlos', 'Garcia', 'C003', '2024-02-20', 3000, 's002', 'D006'),
      ('E004', 'Ana', 'Martinez', 'C004', '2024-03-10', 2700, 's002', 'D009'),
      ('E005', 'Luis', 'Rodriguez', 'C005', '2022-12-01', 3200, 's003', 'D004'),
      ('E006', 'Laura', 'Sanchez', 'C006', '2023-10-18', 2900, 's003', 'D008'),
      ('E007', 'Pedro', 'Gomez', 'C007', '2024-04-05', 2600, 's001', 'D005'),
      ('E008', 'Sofia', 'Diaz', 'C008', '2024-01-15', 2700, 's002', 'D002'),
      ('E009', 'Diego', 'Hernandez', 'C009', '2023-08-20', 3100, 's003', 'D010'),
      ('E010', 'Elena', 'Fernandez', 'C010', '2024-05-10', 2900, 's001', 'D001')

insert into CatalogoAutos(id_catalogo,id_automovil,descripcion,caracteristicas)
values('CA001', 'A008', 'Sedan Compacto', 'Motor 1.5L, 4 cilindros, 5 asientos'),
      ('CA002', 'A012', 'SUV Familiar', 'Motor 2.0L, 6 cilindros, 7 asientos'),
      ('CA003', 'A010', 'Camioneta Pickup', 'Motor 3.5L, 8 cilindros, capacidad de carga 1000kg'),
      ('CA004', 'A009', 'Coupe Deportivo', 'Motor 2.5L turbo, 4 cilindros, 2 asientos'),
      ('CA005', 'A005', 'Hatchback Económico', 'Motor 1.0L, 3 cilindros, bajo consumo de combustible'),
      ('CA006', 'A020', 'Minivan Espaciosa', 'Motor 2.2L, 4 cilindros, 8 asientos'),
      ('CA007', 'A011', 'Convertible de Lujo', 'Motor 3.0L, 6 cilindros, techo retráctil eléctrico'),
      ('CA008', 'A007', 'Todo Terreno Resistente', 'Motor 4.0L, 8 cilindros, tracción en las cuatro ruedas'),
      ('CA009', 'A013', 'Sedan de Lujo', 'Motor 2.0L, 6 cilindros, acabados en piel y madera'),
      ('CA010', 'A015', 'Deportivo Compacto', 'Motor 1.8L turbo, 4 cilindros, suspensión deportiva'),
      ('CA011', 'A002', 'SUV de Lujo', 'Motor 3.6L, 6 cilindros, sistema de entretenimiento avanzado'),
      ('CA012', 'A014', 'Camioneta de Aventura', 'Motor 2.8L turbo, 4 cilindros, capacidad todoterreno'),
      ('CA013', 'A006', 'Descapotable Clásico', 'Motor 5.0L, 8 cilindros, diseño retro'),
      ('CA014', 'A016', 'Furgoneta de Carga', 'Motor eléctrico, espacio de carga amplio'),
      ('CA015', 'A003', 'Coupe Deportivo', 'Motor 3.0L turbo, 6 cilindros, tracción trasera'),
      ('CA016', 'A005', 'Hatchback Deportivo', 'Motor 2.0L turbo, 4 cilindros, aerodinámica mejorada'),
      ('CA017', 'A019', 'Sedan Híbrido', 'Motor híbrido, consumo eficiente de combustible'),
      ('CA018', 'A004', 'SUV de Gran Tamaño', 'Motor 4.5L, 8 cilindros, capacidad para 8 pasajeros'),
      ('CA019', 'A018', 'Pickup de Trabajo Pesado', 'Motor diésel, chasis reforzado, remolque de hasta 5000kg'),
      ('CA020', 'A001', 'Compacto Eléctrico', 'Motor eléctrico, autonomía de 300km por carga')

insert into Cliente(id_cliente,nombre,apellido,direccion,telefono,correo_electronico,id_distrito)
values('CL001', 'Luis', 'Gomez', 'Av. Javier Prado 123', '987654321', 'luis@gmail.com', 'D007'),
      ('CL002', 'Maria', 'Diaz', 'Calle Los Pinos 456', '912345678', 'maria@hotmail.com', 'D005'),
      ('CL003', 'Carlos', 'Perez', 'Jr. Arequipa 789', '923456789', 'carlos@yahoo.com', 'D003'),
      ('CL004', 'Ana', 'Flores', 'Av. Brasil 234', '934567890', 'ana@outlook.com', 'D001'),
      ('CL005', 'Juan', 'Lopez', 'Calle Lima 567', '945678901', 'juan@gmail.com', 'D010'),
      ('CL006', 'Sofia', 'Garcia', 'Jr. Tacna 890', '956789012', 'sofia@hotmail.com', 'D008'),
      ('CL007', 'Pedro', 'Martinez', 'Av. Huancayo 123', '967890123', 'pedro@yahoo.com', 'D006'),
      ('CL008', 'Laura', 'Sanchez', 'Calle Junin 456', '978901234', 'laura@outlook.com', 'D002'),
      ('CL009', 'Diego', 'Hernandez', 'Jr. Ayacucho 789', '989012345', 'diego@gmail.com', 'D009'),
      ('CL010', 'Elena', 'Fernandez', 'Av. Cuzco 234', '990123456', 'elena@hotmail.com', 'D004'),
      ('CL011', 'Alejandro', 'Gonzalez', 'Av. Arequipa 567', '991234567', 'alejandro@yahoo.com', 'D007'),
      ('CL012', 'Valeria', 'Ramirez', 'Calle Lima 890', '992345678', 'valeria@gmail.com', 'D005'),
      ('CL013', 'Gabriel', 'Torres', 'Jr. Huanuco 123', '993456789', 'gabriel@hotmail.com', 'D003'),
      ('CL014', 'Camila', 'Lopez', 'Av. San Martin 456', '994567890', 'camila@yahoo.com', 'D001'),
      ('CL015', 'Lucas', 'Martinez', 'Calle Ayacucho 789', '995678901', 'lucas@outlook.com', 'D010'),
      ('CL016', 'Isabella', 'Sanchez', 'Jr. Puno 234', '996789012', 'isabella@gmail.com', 'D008'),
      ('CL017', 'Mateo', 'Gomez', 'Av. La Marina 567', '997890123', 'mateo@hotmail.com', 'D006'),
      ('CL018', 'Mia', 'Diaz', 'Calle Cuzco 890', '998901234', 'mia@yahoo.com', 'D002'),
      ('CL019', 'Daniel', 'Hernandez', 'Av. Los Incas 123', '999012345', 'daniel@gmail.com', 'D009'),
      ('CL020', 'Valentina', 'Fernandez', 'Jr. Huaraz 456', '900123456', 'valentina@hotmail.com', 'D004')

insert into Cotizacion(id_cotizacion,id_cliente,id_automovil,fecha_cotizacion,precio_cotizado)
values('CT001', 'CL005', 'A014', '2024-06-10', 24000),
      ('CT002', 'CL009', 'A018', '2024-06-10', 41000),
      ('CT003', 'CL003', 'A008', '2024-06-10', 37000),
      ('CT004', 'CL001', 'A003', '2024-06-10', 28000),
      ('CT005', 'CL008', 'A020', '2024-06-10', 27000),
      ('CT006', 'CL010', 'A005', '2024-06-10', 19000),
      ('CT007', 'CL006', 'A013', '2024-06-10', 34000),
      ('CT008', 'CL004', 'A011', '2024-06-10', 33000),
      ('CT009', 'CL007', 'A017', '2024-06-10', 29000),
      ('CT010', 'CL002', 'A002', '2024-06-10', 36000),
      ('CT011', 'CL011', 'A019', '2024-06-10', 25000),
      ('CT012', 'CL012', 'A006', '2024-06-10', 48000),
      ('CT013', 'CL013', 'A015', '2024-06-10', 39000),
      ('CT014', 'CL014', 'A004', '2024-06-10', 32000),
      ('CT015', 'CL015', 'A016', '2024-06-10', 43000),
      ('CT016', 'CL016', 'A007', '2024-06-10', 22000),
      ('CT017', 'CL017', 'A010', '2024-06-10', 30000),
      ('CT018', 'CL018', 'A001', '2024-06-10', 26000),
      ('CT019', 'CL019', 'A012', '2024-06-10', 37000),
      ('CT020', 'CL020', 'A009', '2024-06-10', 31000)

insert into DocumentoVenta(id_venta,fecha_venta,id_sede,id_empleado,id_cliente)
values('DV001', '2024-06-10', 's002', 'E007', 'CL003'),
      ('DV002', '2024-06-10', 's001', 'E007', 'CL005'),
      ('DV003', '2024-06-10', 's003', 'E007', 'CL008'),
      ('DV004', '2024-06-10', 's001', 'E007', 'CL002'),
      ('DV005', '2024-06-10', 's003', 'E007', 'CL006'),
      ('DV006', '2024-06-10', 's002', 'E007', 'CL001'),
      ('DV007', '2024-06-10', 's003', 'E007', 'CL004'),
      ('DV008', '2024-06-10', 's002', 'E007', 'CL009'),
      ('DV009', '2024-06-10', 's001', 'E007', 'CL007'),
      ('DV010', '2024-06-10', 's002', 'E007', 'CL010'),
	  ('DV011', '2024-06-10', 's001', 'E007', 'CL011'),
      ('DV012', '2024-06-10', 's003', 'E007', 'CL018'),
      ('DV013', '2024-06-10', 's002', 'E007', 'CL014'),
      ('DV014', '2024-06-10', 's003', 'E007', 'CL013'),
      ('DV015', '2024-06-10', 's001', 'E007', 'CL017'),
      ('DV016', '2024-06-10', 's003', 'E007', 'CL012'),
      ('DV017', '2024-06-10', 's002', 'E007', 'CL019'),
      ('DV018', '2024-06-10', 's001', 'E007', 'CL016'),
      ('DV019', '2024-06-10', 's002', 'E007', 'CL020'),
      ('DV020', '2024-06-10', 's003', 'E007', 'CL015')


insert into DetalleVenta(id_venta,id_automovil,cantidad,precio_venta,tipo_pago,CDP)
values('DV001', 'A005', 1, 20000, 'Tarjeta', 'Boleta'),
      ('DV002', 'A008', 2, 35000, 'Efectivo', 'Factura'),
      ('DV003', 'A003', 1, 30000, 'Transferencia', 'Boleta'),
      ('DV004', 'A012', 1, 28000, 'Tarjeta', 'Factura'),
      ('DV005', 'A007', 3, 18000, 'Efectivo', 'Boleta'),
      ('DV006', 'A019', 1, 27000, 'Tarjeta', 'Factura'),
      ('DV007', 'A013', 1, 40000, 'Transferencia', 'Boleta'),
      ('DV008', 'A010', 2, 45000, 'Efectivo', 'Factura'),
      ('DV009', 'A006', 1, 32000, 'Tarjeta', 'Boleta'),
      ('DV010', 'A020', 1, 25000, 'Transferencia', 'Factura'),
	  ('DV011', 'A009', 1, 38000, 'Efectivo', 'Boleta'),
      ('DV012', 'A015', 2, 29000, 'Tarjeta', 'Factura'),
      ('DV013', 'A004', 1, 33000, 'Transferencia', 'Boleta'),
      ('DV014', 'A018', 1, 24000, 'Efectivo', 'Factura'),
      ('DV015', 'A002', 3, 41000, 'Tarjeta', 'Boleta'),
      ('DV016', 'A017', 1, 37000, 'Transferencia', 'Factura'),
      ('DV017', 'A016', 1, 29000, 'Efectivo', 'Boleta'),
      ('DV018', 'A011', 2, 36000, 'Tarjeta', 'Factura'),
      ('DV019', 'A014', 1, 28000, 'Transferencia', 'Boleta'),
      ('DV020', 'A001', 1, 27000, 'Efectivo', 'Factura')

insert into PropiedadAutomovil(id_propietario,id_cliente,id_automovil,fecha_adquisicion)
values('PA001', 'CL005', 'A018', '2024-06-10'),
      ('PA002', 'CL019', 'A006', '2024-06-10'),
      ('PA003', 'CL013', 'A011', '2024-06-10'),
      ('PA004', 'CL001', 'A005', '2024-06-10'),
      ('PA005', 'CL016', 'A002', '2024-06-10'),
      ('PA006', 'CL007', 'A020', '2024-06-10'),
      ('PA007', 'CL012', 'A013', '2024-06-10'),
      ('PA008', 'CL008', 'A015', '2024-06-10'),
      ('PA009', 'CL020', 'A007', '2024-06-10'),
      ('PA010', 'CL010', 'A012', '2024-06-10'),
      ('PA011', 'CL018', 'A010', '2024-06-10'),
      ('PA012', 'CL006', 'A019', '2024-06-10'),
      ('PA013', 'CL014', 'A003', '2024-06-10'),
      ('PA014', 'CL002', 'A016', '2024-06-10'),
      ('PA015', 'CL011', 'A009', '2024-06-10'),
      ('PA016', 'CL004', 'A017', '2024-06-10'),
      ('PA017', 'CL015', 'A004', '2024-06-10'),
      ('PA018', 'CL017', 'A001', '2024-06-10'),
      ('PA019', 'CL003', 'A014', '2024-06-10'),
      ('PA020', 'CL009', 'A008', '2024-06-10')


insert into TarjetaCirculacion(id_tarjeta,id_propietario,id_automovil,num_cirtificado_propiedad)
values('TC001', 'PA005', 'A018', '789012345678'),
      ('TC002', 'PA011', 'A006', '987654321012'),
      ('TC003', 'PA017', 'A011', '876543210987'),
      ('TC004', 'PA007', 'A005', '765432109876'),
      ('TC005', 'PA012', 'A002', '654321098765'),
      ('TC006', 'PA019', 'A020', '543210987654'),
      ('TC007', 'PA001', 'A013', '432109876543'),
      ('TC008', 'PA013', 'A015', '321098765437'),
      ('TC009', 'PA015', 'A007', '210987654321'),
      ('TC010', 'PA020', 'A012', '109876543214'),
      ('TC011', 'PA002', 'A010', '098765432109'),
      ('TC012', 'PA010', 'A019', '987654321098'),
      ('TC013', 'PA016', 'A003', '876543210988'),
      ('TC014', 'PA009', 'A016', '765432109874'),
      ('TC015', 'PA003', 'A009', '654321098760'),
      ('TC016', 'PA014', 'A017', '543210987657'),
      ('TC017', 'PA008', 'A004', '432109876541'),
      ('TC018', 'PA018', 'A001', '321098765432'),
      ('TC019', 'PA004', 'A014', '210987654326'),
      ('TC020', 'PA006', 'A008', '109876543210')

insert into SituacionTarjeta(id_tarjeta,estado,motivo_inactividad,multas,total,fecha_consulta)
values('TC001', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC002', 'En proceso', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC003', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC004', 'En proceso', 'Ninguna', 25, 25, '2024-06-10'),
      ('TC005', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC006', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC007', 'En proceso', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC008', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC009', 'Activo', 'Ninguna', 15, 15, '2024-06-10'), 
      ('TC010', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC011', 'En proceso', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC012', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC013', 'En proceso', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC014', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC015', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC016', 'En proceso', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC017', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC018', 'Activo', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC019', 'En proceso', 'Ninguna', 0, 0, '2024-06-10'),
      ('TC020', 'Activo', 'Ninguna', 0, 0, '2024-06-10')

insert into RevisionTecnica(id_revision,id_propietario,id_automovil,fecha_revision)
values('RV001', 'PA005', 'A018', '2024-06-10'),
      ('RV002', 'PA011', 'A006', '2024-06-11'),
      ('RV003', 'PA017', 'A011', '2024-06-12'),
      ('RV004', 'PA007', 'A005', '2024-06-13'),
      ('RV005', 'PA012', 'A002', '2024-06-14'),
      ('RV006', 'PA019', 'A020', '2024-06-15'),
      ('RV007', 'PA001', 'A013', '2024-06-16'),
      ('RV008', 'PA013', 'A015', '2024-06-17'),
      ('RV009', 'PA015', 'A007', '2024-06-18'),
      ('RV010', 'PA020', 'A012', '2024-06-19'),
      ('RV011', 'PA002', 'A009', '2024-06-20'),
      ('RV012', 'PA006', 'A003', '2024-06-21'),
      ('RV013', 'PA014', 'A014', '2024-06-22'),
      ('RV014', 'PA009', 'A016', '2024-06-23'),
      ('RV015', 'PA018', 'A001', '2024-06-24'),
      ('RV016', 'PA004', 'A010', '2024-06-25'),
      ('RV017', 'PA008', 'A004', '2024-06-26'),
      ('RV018', 'PA016', 'A008', '2024-06-27'),
      ('RV019', 'PA010', 'A019', '2024-06-28'),
      ('RV020', 'PA003', 'A017', '2024-06-29')

insert into DetalleRevision  (id_revision, descripcion, firma, observacion)
values('RV001', 'Neumáticos en buen estado', 'Firmado por: Luis Gomez', 'Sin observaciones'),
      ('RV002', 'Luces delanteras funcionando correctamente', 'Firmado por: Maria Diaz', 'Sin observaciones'),
      ('RV003', 'Freno de mano operativo', 'Firmado por: Carlos Perez', 'Sin observaciones'),
      ('RV004', 'Aceite del motor en nivel adecuado', 'Firmado por: Ana Flores', 'Sin observaciones'),
      ('RV005', 'Sistema de frenos sin fugas', 'Firmado por: Juan Lopez', 'Sin observaciones'),
      ('RV006', 'Nivel de líquido refrigerante correcto', 'Firmado por: Sofia Garcia', 'Sin observaciones'),
      ('RV007', 'Sistema de suspensión en buen estado', 'Firmado por: Pedro Martinez', 'Sin observaciones'),
      ('RV008', 'Batería con carga suficiente', 'Firmado por: Laura Sanchez', 'Sin observaciones'),
      ('RV009', 'Sistema de dirección sin holguras', 'Firmado por: Diego Hernandez', 'Sin observaciones'),
      ('RV010', 'Aire acondicionado funcionando correctamente', 'Firmado por: Elena Fernandez', 'Sin observaciones'),
      --('RV011', 'Sistema de escape sin fugas', 'Firmado por: Alejandro Gonzalez', 'Sin observaciones'),
      ('RV012', 'Emisión de gases dentro de los límites permitidos', 'Firmado por: Valeria Ramirez', 'Sin observaciones'),
      ('RV013', 'Sistema de enfriamiento sin fugas', 'Firmado por: Gabriel Torres', 'Sin observaciones'),
      ('RV014', 'Sistema eléctrico en buen funcionamiento', 'Firmado por: Camila Lopez', 'Sin observaciones'),
      ('RV015', 'Sistema de transmisión sin ruidos anormales', 'Firmado por: Lucas Martinez', 'Sin observaciones'),
      ('RV016', 'Sistema de combustible sin fugas', 'Firmado por: Isabella Sanchez', 'Sin observaciones'),
      ('RV017', 'Niveles de líquidos dentro de los rangos adecuados', 'Firmado por: Mateo Gomez', 'Sin observaciones'),
      ('RV018', 'Estado general del vehículo en buen estado', 'Firmado por: Mia Diaz', 'Sin observaciones'),
      ('RV019', 'Inspección visual del motor sin anomalías', 'Firmado por: Daniel Hernandez', 'Sin observaciones'),
      ('RV020', 'Prueba de frenado satisfactoria', 'Firmado por: Valentina', 'Sin observacion')


/*****************************VISTAS*******************************************/
/*Promedio de salarios por cargo*/
create view PromedioSalarios
as
	select c.nombre_cargo [Cargo], s.nombre [Sede], avg(e.salario)[Salario Promedio] from empleados as e
	join cargo as c
	on e.id_cargo = c.id_cargo
	join sede as s
	on e.id_sede = s.id_sede group by c.nombre_cargo, s.nombre

select * from PromedioSalarios

/*Cantidad de autos recibidos por proveedor*/
create view AutosSede
as
	select s.nombre [Sede], p.nombre [Proveedor], sum(dp.cantidad_suministrada) [Cantidad Total] from detalleproveedor as dp
	join sede as s
	on dp.id_sede = s.id_sede
	join proveedor p
	on dp.id_proveedor = p.id_proveedor group by s.nombre, p.nombre

select *from AutosSede

/*Venta total por clientes*/
create view VentaTotalXCliente 
as
	select c.nombre [Nombre del Cliente], 
		c.apellido [Apellido del Cliente], 
		sum(detv.precio_venta * detv.cantidad) [Venta Total] from cliente as c
	join documentoventa dv
	on c.id_cliente = dv.id_cliente
	join detalleventa detv 
	on dv.id_venta = detv.id_venta group by c.nombre, c.apellido

	select *from VentaTotalXCliente


/***************************************************PROCEDIMIENTOS**********************************************************/
/**************PROVEEDOR***********/
create proc sp_NuevoProveedor 
(@idProve char(4), @nombre varchar(30), @direccion varchar(50), @telefono varchar(20), @correo varchar(50), @idsede char(4), 
@cantidad int, @tipo varchar(30))
as
begin
    begin try
        begin tran NuevosProveedor
            insert into Proveedor (id_proveedor, nombre, direccion, telefono, correo_electronico) 
            values 
				(@idprove, @nombre, @direccion, @telefono, @correo)

            insert into DetalleProveedor (id_sede, id_proveedor, cantidad_suministrada, tipo_producto)
            values 
				(@idsede, @idprove, @cantidad, @tipo)
        commit tran NuevosProveedor
    end try
    begin catch
        rollback tran NuevosProveedor
        raiserror ('Proveedor ya existente o error en la transacción', 16, 1)
    end catch
end

create proc sp_ActualizarProveedor 
(@idProve char(4), @nombre varchar(30), @telefono varchar(20), @correo varchar(50), @idsede char(4),
@cantidad int, @tipo varchar(30))
as
begin
    begin try
        begin tran ActualizarProveedor
            update Proveedor
            set nombre = @nombre,
                telefono = @telefono,
                correo_electronico = @correo where id_proveedor = @idProve

            update DetalleProveedor
            set id_sede = @idsede,
                cantidad_suministrada = @cantidad,
                tipo_producto = @tipo where id_proveedor = @idProve
        commit tran ActualizarProveedor
    end try
    begin catch
        rollback tran ActualizarProveedor
        raiserror ('Actualización inválida o error en la transacción', 16, 1)
    end catch
end

create proc sp_EliminarProveedor 
(@idProve char(4))
as
begin
    begin try
        begin tran EliminarProveedor
            delete from DetalleProveedor where id_proveedor = @idProve
            delete from Proveedor where id_proveedor = @idProve
        commit tran EliminarProveedor
    end try
    begin catch
        rollback tran EliminarProveedor
        raiserror ('Eliminación fallida o error en la transacción', 16, 1)
    end catch
end

create proc sp_Proveedor 
(@op char(1), @idProve char(4), @nombre varchar(30), @direccion varchar(50), @telefono varchar(20), 
@correo varchar(50), @idsede char(4), @cantidad int, @tipo varchar(30))
as
begin
    begin try
        if @op = 'I'
        begin
            if not exists (select id_proveedor from Proveedor where id_proveedor = @idprove)
            begin
                exec sp_NuevoProveedor @idProve, @nombre, @direccion, @telefono, @correo, @idsede, @cantidad, @tipo
            end
        end
        else if @op = 'U'
        begin
            if exists (select id_proveedor from Proveedor where id_proveedor = @idprove)
            begin
                exec sp_actualizarproveedor @idprove, @nombre, @telefono, @correo, @idsede, @cantidad, @tipo
            end
        end
        else if @op = 'D'
        begin
            if exists (select id_proveedor from Proveedor where id_proveedor = @idprove)
            begin
                exec sp_eliminarproveedor @idprove
            end
        end
    end try
    begin catch
        raiserror('Modificación inválida o error en la transacción', 16, 1)
    end catch
end

exec sp_Proveedor 'I','P005','Jose','Av. Huayna Capac', '964123814', 'jose2@gmail.com', 's002', 66, 'Ferrari'
exec sp_Proveedor 'U','P005','Leonardo', null, '998546741', 'leo2@gmail.com', 's003', 6, 'Ferrari'
exec sp_Proveedor 'D','P005',null, null, null, null, null, null,null

/*CURSOR PROVEEDOR*/
declare @idProve char(6), @nombre varchar(30), @direccion varchar(50), @telefono varchar(20), @correo varchar(50),
@idsede char(4), @cantidad int, @tipo varchar(30)

declare cursor_proveedores cursor for
select p.*, dp.id_sede, dp.cantidad_suministrada, dp.tipo_producto from Proveedor as p
inner join DetalleProveedor as dp
on dp.id_proveedor = p.id_proveedor where p.id_proveedor = 'P005'

open cursor_proveedores

fetch next from cursor_proveedores into @idProve, @nombre, @direccion, @telefono, @correo, @idsede, @cantidad, @tipo

while @@fetch_status = 0
begin
    print 'Proveedor ID: ' + @idProve
    print 'Nombre: ' + @nombre
    print 'Dirección: ' + @direccion
    print 'Teléfono: ' + @telefono
    print 'Correo: ' + @correo
	print 'ID sede: '+ @idsede
	print 'Cantidad. '+ cast(@cantidad as varchar(10))
	print 'Tipo: '+ @tipo

    fetch next from cursor_proveedores into @idProve, @nombre, @direccion, @telefono, @correo, @idsede, @cantidad, @tipo
end

close cursor_proveedores
deallocate cursor_proveedores

---------------------------------------------------------------------------------------------------------------------
/**************EMPLEADOS****************/
create proc sp_NuevoEmpleado 
(@idempleado char(4), @nombre varchar(20), @apellido varchar(20), @idcargo char(4), @fechacontr date,
@salario money, @idsede char(4), @iddistrito char(4))
as
begin
    begin try
        begin tran NuevoEmpleado
            insert into empleados (id_empleado, nombre, apellido, id_cargo, fecha_contratacion, salario, id_sede, id_distrito)
            values
				(@idempleado, @nombre, @apellido, @idcargo, @fechacontr, @salario, @idsede, @iddistrito)
        commit tran NuevoEmpleado
    end try
    begin catch
        rollback tran NuevoEmpleado
        raiserror('El empleado ya existe o error en la transacción', 16, 1)
    end catch
end

create proc sp_ActualizarEmpleado
(@idempleado char(4), @idcargo char(4), @fechacontr date, @salario money, 
@idsede char(4), @iddistrito char(4))
as
begin
    begin try
        begin tran ActualizarEmpleado
            update Empleados
            set id_cargo = @idcargo,
                fecha_contratacion = @fechacontr,
                salario = @salario,
                id_sede = @idsede,
                id_distrito = @iddistrito where id_empleado = @idempleado
        commit tran ActualizarEmpleado
    end try
    begin catch
        rollback tran ActualizarEmpleado
        raiserror('Actualización fallida o error en la transacción', 16, 1)
    end catch
end

create proc sp_EliminarEmpleado
(@idempleado char(4))
as
begin
    begin try
        begin tran EliminarEmpleado
            delete from Empleados where id_empleado = @idempleado
        commit tran EliminarEmpleado
    end try
    begin catch
        rollback tran EliminarEmpleado
        raiserror('Eliminación fallida o error en la transacción', 16, 1)
    end catch
end

create proc sp_Empleado 
(@op char(1), @idempleado char(4), @nombre varchar(20), @apellido varchar(20), @idcargo char(4), 
@fechacontr date, @salario money, @idsede char(4), @iddistrito char(4))
as
begin
    begin try
        if @op = 'I'
        begin
            if not exists (select id_empleado from empleados where id_empleado = @idempleado)
            begin
                exec sp_nuevoempleado @idempleado, @nombre, @apellido, @idcargo, @fechacontr, @salario, @idsede, @iddistrito
            end
        end
        else if @op = 'U'
        begin
            if exists (select id_empleado from empleados where id_empleado = @idempleado)
            begin
                exec sp_actualizarempleado @idempleado, @idcargo, @fechacontr, @salario, @idsede, @iddistrito
            end
        end
        else if @op = 'D'
        begin
            if exists (select id_empleado from empleados where id_empleado = @idempleado)
            begin
                exec sp_eliminarempleado @idempleado
            end
        end
        else
        begin
            raiserror ('Operación inválida', 16, 1)
        end
    end try
    begin catch
        raiserror('Modificación inválida o error en la transacción', 16, 1)
    end catch
end

exec sp_Empleado 'I', 'E011', 'Carlos', 'Poma', 'C010', '2022/05/12', 10000.00, 'S001', 'D005'
exec sp_Empleado 'U', 'E011', null, null, 'C002', '2023/05/12', 20000.00, 'S002', 'D003'
exec sp_Empleado 'D', 'E011', null, null, null, null, null, null, null 

/*CURSOR EMPLEADO*/
declare @idEmpleado char(6), @nombre varchar(20), @apellido varchar(20), @idCargo char(6), @fechaContratacion date,
@salario money, @idSede char(6), @idDistrito char(6)

declare cursor_empleados cursor for
select *from Empleados where id_empleado = 'E011'

open cursor_empleados

fetch next from cursor_empleados into @idEmpleado, @nombre, @apellido, @idCargo, @fechaContratacion, @salario, @idSede, @idDistrito

while @@fetch_status = 0
begin
    print 'Empleado ID: ' + @idEmpleado
    print 'Nombre: ' + @nombre
    print 'Apellido: ' + @apellido
    print 'Cargo ID: ' + @idCargo
    print 'Fecha de Contratación: ' + cast(@fechaContratacion as varchar)
    print 'Salario: ' + cast(@salario as varchar)
    print 'Sede ID: ' + @idSede
    print 'Distrito ID: ' + @idDistrito

    fetch next from cursor_empleados into @idEmpleado, @nombre, @apellido, @idCargo, @fechaContratacion, @salario, @idSede, @idDistrito
end

close cursor_empleados
deallocate cursor_empleados

-------------------------------------------------------------------------------------------------------
/*************CLIENTE*****************/
create procedure sp_NuevoCliente 
(@idcliente char(5), @nombre varchar(30), @apellido varchar(30), @direccion varchar(50), @telefono varchar(20), 
@correo varchar(100), @iddistrito char(4))
as
begin
    begin try
        begin tran NuevoCliente
            insert into Cliente (id_cliente, nombre, apellido, direccion, telefono, correo_electronico, id_distrito)
            values 
				(@idcliente, @nombre, @apellido, @direccion, @telefono, @correo, @iddistrito)
        commit tran NuevoCliente
    end try
    begin catch
        rollback tran NuevoCliente
        raiserror('El cliente ya existe o error en la transacción', 16, 1)
    end catch
end

create procedure sp_ActualizarCliente 
(@idcliente char(5), @direccion varchar(50), @telefono varchar(20), @correo varchar(100), @iddistrito char(4))
as
begin
    begin try
        begin tran ActualizarCliente
            update Cliente
            set direccion = @direccion,
                telefono = @telefono,
                correo_electronico = @correo,
                id_distrito = @iddistrito where id_cliente = @idcliente
        commit tran ActualizarCliente
    end try
    begin catch
        rollback tran ActualizarCliente
        raiserror('Actualización fallida o error en la transacción', 16, 1)
    end catch
end

create procedure sp_EliminarCliente 
(@idcliente char(5))
as
begin
    begin try
        begin tran EliminarCliente
            delete from Cliente where id_cliente = @idcliente
        commit tran EliminarCliente
    end try
    begin catch
        rollback tran EliminarCliente
        raiserror('Eliminación fallida o error en la transacción', 16, 1)
    end catch
end

create procedure sp_Cliente 
(@op char(1), @idcliente char(5), @nombre varchar(30), @apellido varchar(30), @direccion varchar(50),
@telefono varchar(20), @correo varchar(100), @iddistrito char(4))
as
begin
    begin try
        if @op = 'I'
        begin
            if not exists (select id_cliente from Cliente where id_cliente = @idcliente)
            begin
                exec sp_NuevoCliente @idcliente, @nombre, @apellido, @direccion, @telefono, @correo, @iddistrito
            end
        end
        else if @op = 'U'
        begin
            if exists (select id_cliente from Cliente where id_cliente = @idcliente)
            begin
                exec sp_actualizarcliente @idcliente, @direccion, @telefono, @correo, @iddistrito
            end
        end
        else if @op = 'D'
        begin
            if exists (select id_cliente from Cliente where id_cliente = @idcliente)
            begin
                exec sp_eliminarcliente @idcliente
            end
        end
        else
        begin
            raiserror ('operación inválida', 16, 1)
        end
    end try
    begin catch
        raiserror('modificación inválida o error en la transacción', 16, 1)
    end catch
end

exec sp_Cliente 'I', 'CL021', 'Juan', 'Perez', 'Av. La Marina 567', '964812648', 'juan@hotmail.com', 'D006'
exec sp_Cliente 'U', 'CL021', null, null, 'Calle Cuzco 890', '964812354', 'juan.perez@gmail.com', 'D002'
exec sp_Cliente 'D', 'CL021', null, null, null, null, null, null

/*CURSOR CLIENTE*/
declare @idCliente char(6), @nombre varchar(30), @apellido varchar(30), @direccion varchar(50), @telefono varchar(20), @correo varchar(100), @idDistrito char(6)

declare cursor_clientes cursor for
select *from Cliente where id_cliente = 'CL021'

open cursor_clientes

fetch next from cursor_clientes into @idCliente, @nombre, @apellido, @direccion, @telefono, @correo, @idDistrito

while @@fetch_status = 0
begin
    print 'Cliente ID: ' + @idCliente
    print 'Nombre: ' + @nombre
    print 'Apellido: ' + @apellido
    print 'Dirección: ' + @direccion
    print 'Teléfono: ' + @telefono
    print 'Correo: ' + @correo
    print 'Distrito ID: ' + @idDistrito

    fetch next from cursor_clientes into @idCliente, @nombre, @apellido, @direccion, @telefono, @correo, @idDistrito
end

close cursor_clientes
deallocate cursor_clientes

-----------------------------------------------------------------------------------------
/*****************COTIZACION*************/
create proc sp_RegistrarCotizacion
(@id_cotizacion char(5), @id_cliente char(5), @id_automovil char(4), @fecha_cotizacion date, @precio_cotizado money)
as
	begin
		begin tran NuevaCotizacion
			begin try-- insertar en cotizacion
				insert into Cotizacion (id_cotizacion, id_cliente, id_automovil, fecha_cotizacion, precio_cotizado)
				values
					(@id_cotizacion, @id_cliente, @id_automovil, @fecha_cotizacion, @precio_cotizado)

				commit tran NuevaCotizacion
			end try
			begin catch
				rollback tran NuevaCotizacion
				raiserror('Error! No se puedo generar la nueva cotizacion',16 ,1 )
			end catch
	end

exec sp_RegistrarCotizacion 'CT021', 'Cl002', 'A010', '2024/07/09', 500000.00

/*CURSOR COTIZACION*/
declare @idcotizacion char(5), @idcliente char(5), @nomCliente varchar(30), @apellCliente varchar(30),
@idautomovil char(4), @modelo varchar(20), @marca varchar(20), @añoFabricacion int, @caroseria varchar(10),
@color varchar(10), @motor varchar(20), @placa char(7),@uso varchar(20), @chasis varchar(30), @linea varchar(50), @cm3 int,
@fechacotizacion date, @preciocotizado money

declare cursor_cotizacion cursor for
select ct.id_cotizacion, c.id_cliente, c.nombre, c.apellido, a.*, ct.fecha_cotizacion, ct.precio_cotizado from  Cotizacion as  ct
inner join Cliente as c
on ct.id_cliente = c.id_cliente
inner join Automovil as a
on a.id_automovil = ct.id_automovil where ct.id_cotizacion = 'CT021'

open cursor_cotizacion

fetch next from cursor_cotizacion into @idcotizacion, @idcliente, @nomCliente, @apellCliente, @idautomovil, @modelo,
@marca, @añoFabricacion, @caroseria, @color, @motor, @placa,@uso, @chasis, @linea, @cm3, @fechacotizacion, @preciocotizado

while @@fetch_status = 0
begin
    print 'ID Cotizacion: ' + @idcotizacion
    print 'ID Cliente: ' + @idcliente
    print 'Nombre del Cliente: ' + @nomCliente
    print 'Apellido del Cliente: ' + @apellCliente
    print 'ID Auto: ' + @idautomovil
    print 'Modelo: ' + @modelo
    print 'Marca: ' + @marca
	print 'Año de fabricacion: '+ cast(@añoFabricacion as varchar(15))
	print 'Tipo de carroseria: '+ @caroseria
	print 'Color: ' + @color
	print 'Motorizacion: '	+ @motor 
	print 'Placa: ' + @placa 
	print 'Uso: '+ @uso
	print 'Numero de chasis: ' + @chasis
	print 'Linea: ' + @linea
	print 'cm3 del motor: '+ cast(@cm3 as varchar(30))
	print 'Fecha de cotizacion: '+ cast(@fechacotizacion as varchar(10))
	print 'Precio cotizado: '+cast(@preciocotizado as varchar(100))

    fetch next from cursor_cotizacion into @idcotizacion, @idcliente, @nomCliente, @apellCliente, @idautomovil, @modelo,
@marca, @añoFabricacion, @caroseria, @color, @motor, @placa, @uso,@chasis, @linea, @cm3, @fechacotizacion, @preciocotizado

end

close cursor_cotizacion
deallocate cursor_cotizacion
-----------------------------------------------------------------------------------------------------
/*************VENTA*****************/
create proc sp_NuevaVenta (@idventa char(5), @fecha date, @idsede char(4), @idempleado char(4), @idcliente char(5),
@idauto char(5), @cantidad int, @precioVenta money, @tipoPago varchar(50), @cdp varchar(50), @obs varchar(50), @idpropietario char(5))
as
	begin try
		begin tran NuevaVenta
			-- Insertar en DocumentoVenta
			insert into DocumentoVenta (id_venta, fecha_venta, id_sede, id_empleado, id_cliente)
			values 
				(@idventa, @fecha, @idsede, @idempleado, @idcliente)

			-- Insertar en DetalleVenta
			insert into DetalleVenta (id_venta, id_automovil, cantidad, precio_venta, tipo_pago, cdp, observacion)
			values 
				(@idventa, @idauto, @cantidad, @precioventa, @tipopago, @cdp, @obs)

			-- Actualizar Inventario
			update Inventario 
			set cantidad_disponible = cantidad_disponible - @cantidad
			where id_automovil = @idauto

			-- Insertar en PropiedadAutomovil
			insert into PropiedadAutomovil (id_propietario, id_cliente, id_automovil, fecha_adquisicion)
			values
				(@idpropietario, @idcliente, @idauto, @fecha)

		commit tran NuevaVenta
    end try
    begin catch
		rollback tran NuevaVenta
        raiserror('Error! Venta no generada', 16, 1) 
    end catch

exec sp_NuevaVenta 'DV021', '2024/09/07', 'S002', 'E005', 'CL020', 'A002', 1, 24000.00, 'Tarjeta', 'Factura', 'Ninguna', 'PA021'

select *from DocumentoVenta where id_venta = 'DV021'
select *from DetalleVenta where id_venta = 'DV021'
select *from Inventario
select *from PropiedadAutomovil

/*CURSOR DE VENTA*/
declare @idventa char(5), @fecha date, @idsede char(4), @idempleado char(4), @idcliente char(5), @idauto char(5),
@cantidad int, @precioVenta money, @tipoPago varchar(50), @cdp varchar(50), @obs varchar(50), @idpropietario char(5)

declare cursor_venta cursor for
select v.*,dv.id_automovil, dv.cantidad, dv.precio_venta, dv.tipo_pago, dv.CDP, dv.observacion, pa.id_propietario from DocumentoVenta as v
inner join DetalleVenta as dv
on v.id_venta = dv.id_venta
inner join PropiedadAutomovil as pa
on pa.id_cliente = v.id_cliente where v.id_venta = 'DV021'

open cursor_venta

fetch next from cursor_venta into @idventa, @fecha, @idsede, @idempleado, @idcliente, @idauto,
@cantidad, @precioVenta, @tipoPago, @cdp, @obs, @idpropietario

while @@fetch_status = 0
begin
    print 'ID Venta: ' + @idventa
    print 'Fecha de venta: ' + cast(@fecha as varchar(10))
    print 'ID Sede: ' + @idsede
    print 'ID Empleado: ' + @idempleado
    print 'ID Cliente: ' + @idcliente
    print 'ID Auto: ' + @idauto
    print 'Cantidad: ' + cast(@cantidad as varchar(2))
	print 'Precio de venta: '+ cast(@precioVenta as varchar(15))
	print 'Tipo de pago: '+ @tipoPago
	print 'Comprobante de pago: ' + @cdp
	print 'Observaciones: '	+ @obs 
	print 'ID Propietario: ' + @idpropietario 
	
    fetch next from cursor_venta into @idventa, @fecha, @idsede, @idempleado, @idcliente, @idauto,
@cantidad, @precioVenta, @tipoPago, @cdp, @obs, @idpropietario

end

close cursor_venta
deallocate cursor_venta

--------------------------------------------------------------------------
/*********TARJETA DE CIRCULACION*****************/
create procedure sp_NuevaTarjeta
(@idtarjeta char(5), @idpropietario char(5), @idauto char(4), @numcertificado varchar(20), @estado varchar(15),
@motivoinac varchar(50), @multas int, @total money, @fecha date)
as
begin
    begin try
        begin tran NuevaTarjeta
            insert into TarjetaCirculacion (id_tarjeta, id_propietario, id_automovil, num_cirtificado_propiedad)
            values
				(@idtarjeta, @idpropietario, @idauto, @numcertificado)

            insert into SituacionTarjeta(id_tarjeta, estado, motivo_inactividad, multas, total, fecha_consulta)
            values 
				(@idtarjeta, @estado, @motivoinac, @multas, @total, @fecha)
        commit tran NuevaTarjeta
    end try
    begin catch
        rollback tran NuevaTarjeta
        raiserror('Tarjeta ya existente', 16, 1)
    end catch
end

create proc sp_ActualizacionTarjeta
(@idtarjeta char(5), @estado varchar(15), @motivoinac varchar(50), @multas int, @total money, @fecha date)
as
begin
    begin try
        begin tran ActualizarTarjeta
            update SituacionTarjeta
            set estado = @estado,
                motivo_inactividad = @motivoinac,
                multas = @multas,
                total = @total,
                fecha_consulta = @fecha where id_tarjeta = @idtarjeta
        commit tran ActualizarTarjeta
    end try
    begin catch
        rollback tran ActualizarTarjeta
        raiserror('Actualización inválida', 16, 1)
    end catch
end

create proc sp_EliminarTarjeta
(@idtarjeta char(5))
as
begin
    begin try
        begin tran EliminarTarjeta
            delete from SituacionTarjeta where id_tarjeta = @idtarjeta
            delete from TarjetaCirculacion where id_tarjeta = @idtarjeta
        commit tran EliminarTarjeta
    end try
    begin catch
        rollback tran EliminarTarjeta
        raiserror('Eliminación fallida', 16, 1)
    end catch
end

create proc sp_TarjetaCirculacion
(@op char(1), @idtarjeta char(5), @idpropietario char(5), @idauto char(4), @numcertificado varchar(20), @estado varchar(15),
@motivoinac varchar(50), @multas int, @total money, @fecha date)
as
begin
    begin try
        if @op = 'I'
        begin
            if not exists (select id_tarjeta from tarjetacirculacion where id_tarjeta = @idtarjeta)
            begin
                exec sp_nuevatarjeta @idtarjeta, @idpropietario, @idauto, @numcertificado, @estado, @motivoinac, @multas, @total, @fecha
            end
        end
        else if @op = 'U'
        begin
            if exists (select id_tarjeta from tarjetacirculacion where id_tarjeta = @idtarjeta)
            begin
                exec sp_actualizaciontarjeta @idtarjeta, @estado, @motivoinac, @multas, @total, @fecha
            end
        end
        else if @op = 'D'
        begin
            if exists (select id_tarjeta from tarjetacirculacion where id_tarjeta = @idtarjeta)
            begin
                exec sp_eliminartarjeta @idtarjeta
            end
        end
        else
        begin
            raiserror ('operación inválida', 16, 1)
        end
    end try
    begin catch
        raiserror('modificación inválida', 16, 1)
    end catch
end

exec sp_TarjetaCirculacion 'I', 'TC021', 'PA021', 'A001', '987654321123', 'En proceso', 'Ninguna', 0, 0.00, '2024/07/09'
exec sp_TarjetaCirculacion 'U', 'TC021', null, null, null, 'Activo', 'Ninguna', 0, 0.00, '2024/07/09'
exec sp_TarjetaCirculacion 'D', 'TC021', null, null, null, null, null, null, null, null

/*CURSOR TARJETA DE CIRCULACION*/
declare @idtarjeta char(5), @idpropietario char(5), @idauto char(4), @numcertificado varchar(20), @estado varchar(15),
@motivoinac varchar(50), @multas int, @total money, @fecha date

declare cursor_tarjetas cursor for
	select tc.*, st.estado, st.motivo_inactividad, st.multas, st.total, st.fecha_consulta from TarjetaCirculacion as tc
	inner join SituacionTarjeta as st
	on tc.id_tarjeta = st.id_tarjeta where  st.id_tarjeta = 'TC021'
open cursor_tarjetas

fetch next from cursor_tarjetas into @idtarjeta, @idpropietario, @idauto, @numcertificado, @estado, @motivoinac, @multas,
@total, @fecha

while @@fetch_status = 0
begin
    print 'ID Tarjeta: ' + @idtarjeta
    print 'ID Propietario: ' + @idpropietario
    print 'ID Auto: ' + @idauto
    print 'Número de Certificado: ' + @numcertificado
	print 'Estado: '+ @estado
	print 'Motivo de inactividad: ' + @motivoinac
	print 'Numeor de multas: '+ cast(@multas as varchar(3))
	print 'Total a pagar: '  + cast (@total as varchar(10))
	print 'Fecha de consulta' + cast(@fecha as varchar(20))

    fetch next from cursor_tarjetas into @idtarjeta, @idpropietario, @idauto, @numcertificado, @estado, @motivoinac, @multas,
@total, @fecha
end

close cursor_tarjetas
deallocate cursor_tarjetas

-----------------------------------------------------------------------------------------------------------------------
/*********NUEVA REVISION TECNICA*************/
create procedure sp_RegistrarRevisionTecnica 
(@id_revision char(5), @id_propietario char(5), @id_automovil char(4), @fecha_revision date,
@descripcion varchar(max), @firma varchar(30), @observacion varchar(50))
as
    begin tran Revision

    begin try
        insert into RevisionTecnica (id_revision, id_propietario, id_automovil, fecha_revision)
        values 
			(@id_revision, @id_propietario, @id_automovil, @fecha_revision)

        insert into DetalleRevision (id_revision, descripcion, firma, observacion)
        values
			(@id_revision, @descripcion, @firma, isnull(@observacion, 'ninguna'))

        commit tran Revision
    end try
    begin catch
        rollback tran Revision
        raiserror ('Revision no registrada', 16, 1)
    end catch

create procedure sp_EliminarRevisionTecnica 
(@id_revision char(5))
as
    begin tran EliminarRevision

    begin try
		delete from DetalleRevision where id_revision = @id_revision
        delete from RevisionTecnica where id_revision = @id_revision
        commit tran EliminarRevision
    end try
    begin catch
        rollback tran EliminarRevision
        raiserror ('Eliminacion fallida', 16, 1)
    end catch

create proc sp_RevisionTecnica
(@op char(1), @id_revision char(5), @id_propietario char(5), @id_automovil char(4), @fecha_revision date,
@descripcion varchar(max), @firma varchar(30), @observacion varchar(50))
as
begin
    begin try
        if @op = 'I'
        begin
            if not exists (select id_revision from RevisionTecnica where id_revision = @id_revision)
            begin
				exec sp_RegistrarRevisionTecnica @id_revision, @id_propietario, @id_automovil, @fecha_revision, @descripcion, @firma, @observacion
            end
        end
        else if @op = 'D'
        begin
            if exists (select id_revision from RevisionTecnica where id_revision = @id_revision)
            begin
				exec sp_EliminarRevisionTecnica @id_revision
            end
        end
        else
        begin
            raiserror ('operación inválida', 16, 1)
        end
    end try
    begin catch
        raiserror('modificación inválida', 16, 1)
    end catch
end

exec sp_RevisionTecnica 'I','RV011', 'PA021', 'A001', '2024/07/09', 'Sistema de escape sin fugas', 'Firmado por: Alejandro', 'Sin observaciones'
exec sp_RevisionTecnica 'D', 'RV011', null, null, null, null, null, null

	select *from RevisionTecnica
	select *from DetalleRevision

select rt.*from RevisionTecnica as rt
inner join DetalleRevision as dr
on rt.id_revision = dr.id_revision where rt.id_revision = 'RV011'

declare @id_revision char(5), @id_propietario char(5), @id_automovil char(4), @fecha_revision date,
@descripcion varchar(max), @firma varchar(30), @observacion varchar(50)

declare cursor_revision cursor for
	select rt.*, dr.descripcion, dr.firma, dr.observacion from RevisionTecnica as rt
	inner join DetalleRevision as dr
	on rt.id_revision = dr.id_revision where rt.id_revision = 'RV011'
open cursor_revision

fetch next from cursor_revision into @id_revision, @id_propietario, @id_automovil, @fecha_revision, @descripcion,
@firma, @observacion

while @@fetch_status = 0
begin
    print 'ID Revision: ' + @id_revision
    print 'ID Propietario: ' + @id_propietario
    print 'ID Auto: ' + @id_automovil
    print 'Fecha de revision: ' + cast (@fecha_revision as varchar(11))
	print 'Descripcion: '+ @descripcion
	print @firma
	print 'Observacion: '+ @observacion

    fetch next from cursor_revision into @id_revision, @id_propietario, @id_automovil, @fecha_revision, @descripcion,
@firma, @observacion
end

close cursor_revision
deallocate cursor_revision