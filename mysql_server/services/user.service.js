// services/userService.js
const db = require('../config/db');

class UserService {
    static async registerUser(name, lastname, phonenumber, email, password, gender, usertype) {
        try {
            const query = 'INSERT INTO users (name, lastname, phonenumber, email, password, gender, usertype) VALUES (?, ?, ?, ?, ?, ?, ?)';
            await db.query(query, [name, lastname, phonenumber, email, password, gender, usertype]);
            return true;
        } catch (err) {
            throw err;
        }
    }
    static async registerAdmin(name, lastname, phonenumber, email, password, gender, admintype){
        try {
            const query = 'INSERT INTO admin (name, lastname, phonenumber, email, password, gender, admintype) VALUES (?, ?, ?, ?, ?, ?, ?)';
            await db.query(query, [name, lastname, phonenumber, email, password, gender, admintype]);
            return true;
        } catch (err) {
            throw err;
        }
    }
    static async registerdriver(drivername,picture,phonenumber,email,password){
      try{
         var query = ' ';
         query = ' INSERT INTO drivers(drivername,picture,phonenumber,email,password) ';
         query += ' VALUES(?,?,?,?,?) ';
         await db.query(query,[drivername,picture,phonenumber,email,password]);
         return true;
      }
      catch(e){
        throw e;
      }
    }
    static async addComplain(TimeStamp,UserID,TripID,message){
        var query='';
        try {
             query = 'INSERT INTO complaint (TimeStamp, UserID, TripID,message) VALUES (?,?,?,?)';
            await db.query(query, [TimeStamp, UserID, TripID,message]);
            return true;
        } catch (err) {
            throw err;
        }
    }
    static async searchdriver(email, password) {
        try {
            const query = 'SELECT * FROM drivers WHERE email = ? AND password = ?';
            const [rows, _fields] = await db.query(query, [email, password]);
            return rows[0];
        } catch (err) {
            throw err;
        }
    }


    static async registerCar(Reg_Number, Manufacturer,Model,Year, Pic1, Pic2, Pic3,Pic4) {
        try {
            const query = 'INSERT INTO vehicle (Reg_Number, Manufacturer, Model,Year,Pic1, Pic2,Pic3,Pic4) VALUES (?,?, ?, ?, ?, ?, ?, ?)';
            await db.query(query, [Reg_Number, Manufacturer, Model,Year, Pic1, Pic2, Pic3, Pic4]);
            return true;
        } catch (err) {
            throw err;
        }
    }


  
    static async searchUser(email, password) {
        try {
            const query = 'SELECT * FROM users WHERE email = ? AND password = ?';
            const [rows, _fields] = await db.query(query, [email, password]);
            return rows[0];
        } catch (err) {
            throw err;
        }
    }
    static async searchAdmin(email,password){
        try {
            const query = 'SELECT * FROM admin WHERE email = ? AND password = ?';
            const [rows, _fields] = await db.query(query, [email, password]);
            return rows[0];
        } catch (err) {
            throw err;
        }
    }
    static async getAllUsers() {
        try {
            const query = 'SELECT * FROM users ';
            const [rows, _fields] = await db.query(query);
            return rows;
        } catch (err) {
            throw err;
        }
    }
   static async getAllPassengers(){
    try{
        const query ='SELECT * FROM users WHERE usertype = ? '
        var usertype = 'Passenger';
        const [rows,_fields] = await db.query(query,[usertype])
        return rows;
    }catch (err){
        throw err;
    }
   }
   static async getAllDrivers(){
    try{
        const query ='SELECT * FROM users WHERE usertype = ? '
        var usertype = 'Driver';
        const [rows,_fields] = await db.query(query,[usertype])
        return rows;
    }catch (err){
        throw err;
    }
   }
   static async getUsername(email){
    var query = "";
    try{
        query='SELECT name FROM admin ';
        query += 'WHERE email= ? ';
        const [rows,_fields] = await db.query(query,[email])
        return rows[0];
    }catch (err){
        throw err;
    }
   }
   static async getDriverTableDetails(){
    var query="";
    try{
        query = 'SELECT v.name, v.registration, d.drivername, d.lastname, d.activestatus ';
        query += 'FROM vehicles v ';
        query += 'INNER JOIN drivers d ON v.driver_id = d.driver_id ';
        
        const [rows,_fields] = await db.query(query)
        return rows;
    }catch(err){
        throw err;
    }
   }
    static async postTrip(start_location, end_location,driver_id,outbound_time,return_time,start_latitude,start_longtude,destination_latitude,destination_longtude){

        try{
           var query = ' ';
           query = ' SELECT * FROM vehicles ';
           query += ' WHERE driver_id = ? ';
           const [vehicles, _fields] = await db.query(query,[driver_id]);
           var vehicle_id = vehicles[0].vehicle_id;
           if(driver_id != null){
            query = ' INSERT INTO trips(start_location,end_location,time,driver_id,vehicle_id,outbound_time,return_time,start_latitude,start_longtude,destination_latitude,destination_longtude) ';
            query += ' VALUES(?,?,?,?,?,?,?,?,?,?,?) ';
            await db.query(query,[start_location, end_location,"08:00",driver_id,vehicle_id,outbound_time,return_time,start_latitude,start_longtude,destination_latitude,destination_longtude]);
           }
           return true;
        }
        catch(e){
            throw e;
        }
    }
    
    static async bookTrip(trip_id, passenger_id,price,active){
        var query;
        try{
            query = 'INSERT INTO bookedtrips VALUES(?,?,?)';
            await db.query(query,[trip_id,passenger_id,price,active]);
            return true;
        }
        catch(err){
            throw err;
        }
        
    }
   
    static async addBookedTrip(driver_id,trip_id,passenger_id,vehicle_id, price, bookedseats){
       var query = '';
       try{
         query = 'INSERT INTO bookedtrips(trip_id, driver_id, passenger_id,vehicle_id, price, bookedseats) VALUES(?, ?, ?, ?,?,?)';
         await db.query(query,[trip_id, driver_id, passenger_id,vehicle_id, price, bookedseats]);
         return true;

       } catch(err){
        throw err;
       }

    }
    static async searchTrip(start_location, end_location,seats)
    {
        var query;
        try{
             query = 'SELECT  d.driver_id, d.drivername ,d.picture, v.vehicle_id, v.name, v.seats,t.trip_id, t.start_location, t.end_location, t.time ';
             query += 'FROM trips t ';
             query += 'JOIN drivers d ON t.driver_id = d.driver_id ';
             query += 'JOIN vehicles v ON  t.vehicle_id = v.vehicle_id ' ;
             query += 'WHERE start_location = ? AND end_location = ? AND seats >= ? ';
             const [rows, _fields] = await db.query(query,[start_location,end_location,seats]);
             return rows;
        }
        catch(err)
        {
            throw err;
        }
    }

    static async getBookedTrips(passenger_id) {
        var query;
        try{
          query = 'SELECT b.bookedtrips_id, b.price, b.bookedseats , d.drivername ,d.picture, v.name, v.seats, t.start_location, t.end_location, t.time ';
          query += 'FROM bookedtrips b ';
          query += 'JOIN drivers d ON  b.driver_id = d.driver_id ';
          query += 'JOIN vehicles v ON b.vehicle_id = v.vehicle_id ';
          query += 'JOIN trips t ON b.trip_id = t.trip_id ';
          query += 'WHERE passenger_id = ? '
          const [rows, _fields] = await db.query(query,[passenger_id]);
          return rows;
          
        }
        catch(err){
        throw err;
        }
    }

   static async getCompletedTrip(passenger_id) 
    {
        try{
        var query = '';
            query = ' SELECT c.status , c.datetime ,d.drivername ,d.picture, v.name, v.seats, t.start_location, t.end_location, t.time ';
            query += ' FROM completedtrips c ';
            query += ' JOIN drivers d ON c.driver_id = d.driver_id ';
            query += ' JOIN vehicles v ON c.vehicle_id = v.vehicle_id ';
            query += ' JOIN trips t ON c.trip_id = t.trip_id ';
            query += ' WHERE  passanger_id = ? ';
            const [rows,_fields] = await db.query(query,[passenger_id]);
            return rows;

        }
        catch(e){
            throw e;
        }
    }

    static async addCompletedTrip(bookedtrips_id,datetime,status,passanger_id){

        try{
            var query = ' ';
            var result;
            query = ' SELECT * FROM bookedtrips ';
            query += ' WHERE passenger_id = ? AND bookedtrips_id = ? ';
            result = await db.query(query,[passanger_id,bookedtrips_id]);
            var deleted_trip = result[0][0];
            var driver_id = deleted_trip.driver_id;
            var vehicle_id = deleted_trip.vehicle_id;
            var trip_id = deleted_trip.trip_id;
            query = ' INSERT INTO completedtrips(bookedtrips_id,datetime,status,passanger_id,trip_id,driver_id,vehicle_id) ';
            query += ' VALUES(?,?,?,?,?,?,?) ';
            await db.query(query,[bookedtrips_id,datetime,status,passanger_id,trip_id,driver_id,vehicle_id]);
            return true;
        }
        catch(e){
            throw e;
        }
    }

    static async deleteBookedTrip(passenger_id, bookedtrips_id){
      try{

        var query = ' ';
        query = ' SET FOREIGN_KEY_CHECKS=0 ';
        await db.query(query);
        query = ' DELETE FROM bookedtrips ';
        query += ' WHERE passenger_id = ? AND bookedtrips_id = ? ';
        await db.query(query,[passenger_id,bookedtrips_id]);
        query = ' SET FOREIGN_KEY_CHECKS=1 ';
        await db.query(query);
        return true;
      }
      catch(e){
        throw e;
      }
    }

    static async getBookedPassengers (driver_id, trip_id){
        
       try{
        var query = ' ';
        query = ' SELECT bookedseats, u.name , u.lastname ';
        query += ' FROM bookedtrips b ';
        query += 'JOIN users u ON b.passenger_id = u.id ';
        query += 'WHERE driver_id = ? AND trip_id = ? ';
        const[passengers,_fields1] = await db.query(query,[driver_id,trip_id]);
        return passengers;
       }
       catch(e){
        throw e;
       }

    }

    static async getPostedTrips(driver_id){
        try{
           var query = ' ';
           var  query = ' SELECT  t.trip_id, t.start_location, t.end_location, t.time';
                query += ' FROM  trips t  ';
                query += ' WHERE t.driver_id = ? ';
            const[trips, _fields] = await db.query(query,[driver_id]);
            return trips;
        }
        catch(e){
            throw e;
        }
    }
   
    static async searchCar(Reg_Number)
    {
        try{
            const query = 'SELECT * FROM vehicle WHERE Reg_Number = ? ';
            const [rows,_fields] = await db.query(query,[Reg_Number]);
            return row[0];
        }
        catch(err)
        {
            throw err;
        }
    }

    

   

   

    static async addMessage(Content,TimeStamp)
    {
        try{
            const query = 'INSERT INTO message(Content,TimeStamp) VALUES(?,?)';
            await db.query(query,[Content,TimeStamp]);
            return true;
        }
        catch(err)
        {
            throw err;
        }
    }

    static async addComplain(TimeStamp,UserID,TripID,message)
    {
      try{
        const query = 'INSERT INTO complaint (TimeStamp,UserID,TripID,message) VALUES (?,?,?,?)';
      await db.query(query,[TimeStamp,UserID,TripID,message]);
      return true;
      }
      catch(err)
      {
        throw err;
      }
    }

    static async addInvoice(PaymentStatus,BookingFee)
    {
        try 
        {
            const query = 'INSERT INTO invoice (PaymentStatus,BookingFee)';
            await db.query(query,[PaymentStatus,BookingFee]);
        }
        catch(err)
        {
            throw err;
        }
    }

    static async addDriverPayment(BankName,AccountNumber,BranchCode)
    {
        try{
            const query = 'INSERT INTO driverpayment(BankName,AccountNumber,BranchCode)  VALUES(?,?,?)';
            await db.query(query,[BankName,AccountNumber,BranchCode]);
            return true;
        }
        catch(err)
        {
            return true;
        }
    }

   


static async addReview(RatingValue,Review)
{
    try{
        const query = 'INSERT INTO review (RatingValue,Review) VALUES(?,?)';
    await db.query(query,[RatingValue,Review]);
    return true;
    }
    catch(err)
    {
        throw err;
    }
}

static async addAdmin(AdminType)
{
    try{
        const query = 'INSERT INTO admin(AdminType) VALUES(?)';
        await db.query(query,[AdminType]);
        return true;
    }
    catch(err)
    {
        return true;
    }
}


static async addSubscription(start_date, end_date, price,discount,seats,passenger_id,trip_id)
{
      try{
        const query = 'INSERT INTO subscription(start_date, end_date, price,discount,active,seats,passenger_id,trip_id) VALUES (?,?,?,?,?,?,?,?)';
        await db.query(query,[start_date, end_date, price,discount,seats,passenger_id,trip_id]);
        return true;
      }
      catch(e){
        throw e;
      }
}

static async addPassengerPayment(PaymentMethod,Card_Number,ExpiryDate,CVV,NameOnCard,Email){
   try{
    const query = 'INSERT INTO passengerpayment(PaymentMethod,Card_Number,ExperyDate,CVV,NameOnCard,Email)';
    await db.query(query,[PaymentMethod,Card_Number,ExpiryDate,CVV,NameOnCard,Email]);
    return true;
   }
   catch(err)
   {
    return true;
   }
}


static async addTrip(Origin,Destination,Time,Date,FareAmount,Discount,Seats)
{
    try
    {
        const query = 'INSERT INTO trip(Origin,Destination,Time,Date,FareAmount,Discount,Seats) VALUES(?,?,?,?,?,?,?)';
        await db.query(query,[Origin,Destination,Time,Date,FareAmount,Discount,Seats]);
        return true;
    }
    catch(err)
    {
        throw err;
    }
}

static async getPassengerTripHistory(passenger_id) {
    try {
        const query = `
            SELECT 
                bt.bookedtrips_id,
                bt.trip_id,
                d.drivername,
                bt.price,
                t.start_location,
                t.end_location,
                t.outbound_time,
                bt.bookedseats
            FROM 
                bookedtrips bt
            JOIN 
                trips t ON bt.trip_id = t.trip_id
            JOIN 
                drivers d ON bt.driver_id = d.driver_id
            WHERE 
                bt.passenger_id = ?
            ORDER BY 
                t.outbound_time DESC
        `;
        
        const [rows, _fields] = await db.query(query, [passenger_id]);
        return rows;
    } catch (err) {
        throw err;
    }
}

}
module.exports = UserService;
