Use master
go

if exists (select * from SysDataBases where name = 'MyRestaurantBD')
Begin
	Drop DataBase MyRestaurantBD
end
go

Create DataBase MyRestaurantBD On
(
	name = ProyectoFinalDB,
	filename = 'C:\ProyectoLucas\MyRestaurantBD.mdf'
)
go

use MyRestaurantBD
go 

Create Table Product 
(
	id int primary key not null,
	productName varchar(50) not null,
	price int not null
)
go

Create Table Tickets
(
	idTicket int primary key identity not null,
	idProducto int foreign key References Product(id),
	tip int not null,
	subTotal int not null,
	total int not null,
)
go

Create Table TicketProduct 
(
	idTicket int foreign key references Product(id),
	idProduct int foreign key references Tickets(idTicket)
)
go

Create Procedure AddTicket @idProducto int, @tip int, @subTotal int, @total int as
begin
	if not exists (select * from Product where id = @idProducto)
		return -1

	insert into Tickets(idProducto, tip, subTotal, total) values (@idProducto, @tip, @subTotal, @total)

	if @@ERROR <> 0
		return -3

	return ident_current ('Ticket')
end
go

Create Procedure AddTicketProduct @idTicket int, @idProduct int as
begin 
	if not exists (select * from Tickets where idTicket = @idTicket)
		return -1

	if not exists (select * from Product where id = @idProduct)
		return -2

	insert into TicketProduct(idTicket, idProduct) values (@idTicket, @idProduct)

	if @@ERROR <> 0
		return -3

	return 1
end
go



--Datos Pruebas -----------
insert into Product(id, productName, price) values (1, 'Pizza a la leña chica', 30)
insert into Product(id, productName, price) values (2, 'Pizza a la Leña Mediana', 30)
insert into Product(id, productName, price) values (3, 'Rebanada de Pay de Limón', 30)
insert into Product(id, productName, price) values (4, 'Rebanada de Pastel de Chocolate', 30)
insert into Product(id, productName, price) values (5, 'Jugo de Naranja', 30)
insert into Product(id, productName, price) values (6, 'Pizza a la Leña Grande', 30)
insert into Product(id, productName, price) values (7, 'Rib Eye 800g', 30)
insert into Product(id, productName, price) values (8, 'Jugo de Naranja', 30)
insert into Product(id, productName, price) values (9, 'Tequila', 30)
insert into Product(id, productName, price) values (10, 'Rebanada de Pay de Queso', 30)
insert into Product(id, productName, price) values (11, 'Café Americano', 30)
insert into Product(id, productName, price) values (12, 'Café Capuchino', 30)