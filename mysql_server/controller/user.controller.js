// controller/userController.js

const { json } = require('body-parser');
const UserService = require('../services/user.service');
const e = require('express');
const { end } = require('../config/db');
const bodyParser = require('body-parser');

exports.registerUser = async (req, res, next) => {
    try {
        const { name, lastname, phonenumber, email, password, gender, usertype} = req.body;
        await UserService.registerUser(name, lastname, phonenumber, email, password, gender, usertype);
        res.json({ status: true, success: "The user registered successfully", type: usertype });
    } catch (err) {
        next(err);
    }
}
exports.registerAdmin = async (req, res, next)=>{
    try {
        const { name, lastname, phonenumber, email, password, gender, admintype} = req.body;
        await UserService.registerAdmin(name, lastname, phonenumber, email, password, gender, admintype);
        res.json({ status: true, success: "The admin was registered successfully", type: admintype });
    } catch (err) {
        next(err);
    }
}
exports.registerdriver = async (req,res,next) =>{

    try{
        const {drivername,picture,phonenumber,email,password} = req.body;
        await UserService.registerdriver(drivername,picture,phonenumber,email,password);
        res.json({success : true, message : "the driver has successfully registered the driver"});
        return true;
    }
    catch(e){
        next(e);
    }

}

exports.getAllUsers = async (req,res,next) =>{

    try{
        var data = await UserService.getAllUsers();
        res.json({success : true, message : "all users were successfully retrieved" , info: data});
       }
       catch(e){
        next(e);
       }
}

exports.getAllPassengers = async (req,res,next)=>{

    try{
        var data = await UserService.getAllPassengers();
        res.json({success : true, message : "All users passengers were succesfully retrieved" , info: data});
    }catch (e){
        next(e);
    }
}
exports.getAllDrivers = async (req,res,next)=>{

    try{
        var data = await UserService.getAllDrivers();
        res.json({success : true, message : "All users Drivers were succesfully retrieved" , info: data});
    }catch (e){
        next(e);
    }
}

exports.getUsername = async (req,res,next)=>{
    try{
        const {email} = req.body;
        var data = await UserService.getUsername(email);
        res.json({success : true , info: data});
     }
     catch(e){
         next(e);
     }
}

exports.getDriverTableDetails = async (req,res,next) =>{
    try{
       var data = await UserService.getDriverTableDetails();
       res.json({success : true, message : "All driver table details were succesfully retrieved" , info: data });
    }catch(e){
        next(e);
    }
}
exports.searchdriver = async (req,res,next) =>{
   try{
    const {email,password} = req.body;
    var data = await UserService.searchdriver(email,password);
    res.json({success : true, message : "the driver was successfully retrieved" , info: data});
   }
   catch(e){
    next(e);
   }
}



exports.addTrip = async (req,res,next) =>{
    try{
        const {Origin,Destination,Time,Date,FareAmount,Discount,Seats} = req.body;
        await UserService.addTrip(Origin,Destination,Time,Date,FareAmount,Discount,Seats);
        res.json({status:true,success: "The trip was added succefully"});
    }
    catch(err)
    {
        next(err);
    }
}

exports.getCompletedTrips = async (req,res,next) =>{

    try{
       const {passenger_id} = req.body;
       var data = await UserService.getCompletedTrip(passenger_id);
      if(data != null){
        res.json({success: true, message : "the completed trips were successfully retrieved", info : data});
      }
      else {
        res.json({success: true , message : "no completed trips were retrieved", info : data});
      }
    }
    catch(e){
        next(e);
    }
}

exports.getBookedPassengers = async (req,res,next) =>{

   try{
    const {driver_id, trip_id} = req.body;
    var data = await UserService.getBookedPassengers(driver_id,trip_id);
    if(data != null){
        res.json({successs : true , message : "the passengers were successfully retrieved", info : data});
    }
    else{
        res.json({success : false, message : "the passsengers were unsuccessfully retrieved"});
    }
   }
   catch(e){
    throw next(e);
   }

}


exports.addCompletedTrip = async (req,res,next) =>{
    try{
      const {bookedtrips_id,datetime,status,passenger_id} = req.body;
      await UserService.addCompletedTrip(bookedtrips_id,datetime,status,passenger_id);
      res.json({success: true, message: 'the trip was added successfully'});
    }
    catch(e){
        next(e);
    }
}
exports.registerCar = async (req,res,next) =>
{
    try
    {
        const { Reg_Number, Manufacturer,Model,Year, Pic1, Pic2, Pic3,Pic4} = req.body;
        await UserService.registerCar(Reg_Number,Manufacturer,Model,Year,Pic1,Pic2,Pic3,Pic4);
        res.json({status:true, success: "The car registered successfully"});
    }
    catch(err)
    {
        next(err);
    }
}
exports.addComplain = async (req, res, next)=>{
    try{
        const {TimeStamp,UserID,TripID,message}= req.body;
        await UserService.addComplain(TimeStamp,UserID,TripID,message);
        res.json({success : true, message : "Complaint sent successfully"});
    } catch(err){
        next(err);
     }
}
exports.searchUser = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await UserService.searchUser(email, password);
        if (user) {
            res.json({ status: true, message: "The user successfully logged in", info: user });
        } else {
            res.status(401).json({ status: false, message: "Invalid email, password, or user type"});
        }
    } catch (err) {
        next(err);
    }
}
exports.searchAdmin = async (req, res, next)=> {
    try {
        const { email, password } = req.body;
        const admin = await UserService.searchAdmin(email, password);
        if (admin) {
            res.json({ status: true, message: "The admin successfully logged in", info: admin });
        } else {
            res.status(401).json({ status: false, message: "Invalid email, password, or user type"});
        }
    } catch (err) {
        next(err);
    }

}

exports.searchTrip = async (req, res, next) => {
    try {
        const { start_location, end_location, seats } = req.body;
        var data = await UserService.searchTrip(start_location, end_location, seats);
        if (data == null) {
            res.json({ success: true, message: 'Trip was not found', info: data });
        } else {
            res.json({ success: true, message: 'Trips were found', info: data });
        }
    } catch (err) {
        next(err);
    }
}

exports.addBookedTrip = async (req,res,next) =>{

    try{
        const {driver_id,trip_id,passenger_id,vehicle_id, price, bookedseats} = req.body;
        await UserService.addBookedTrip(driver_id,trip_id,passenger_id,vehicle_id, price, bookedseats);
        res.json({success : true, message : "Trip was booked successfully"});
    }
    catch(err){
       next(err);
    }
}

exports.getBookedTrips = async (req,res,next) =>{
    try{
       const {passenger_id} = req.body;
       var data = await UserService.getBookedTrips(passenger_id);
       res.json({success : true , info: data});
    }
    catch(err){{
        next(err);
    }}
}

exports.deleteBookedTrip = async (req,res,next) =>{
    try{
      const {passenger_id,bookedtrips_id} = req.body;
      await UserService.deleteBookedTrip(passenger_id,bookedtrips_id);
       res.json({success : true, message : 'the trip was successfully deleted '});
    }
    catch(e){
        next(e);
    }
}

exports.postTrip = async (req,res,next)  =>{
    try{
        const {start_location, end_location,driver_id,outbound_time,return_time,start_latitude,start_longtude,destination_latitude,destination_longtude} = req.body;
        await UserService.postTrip(start_location, end_location,driver_id,outbound_time,return_time,start_latitude,start_longtude,destination_latitude,destination_longtude);
        res.json({success: true, message : "the trip was successfully posted"});
    }
    catch(e){;
        next(e)
    }
}

exports.getPostedTrips = async (req,res,next) =>{
    try{
      const {driver_id} = req.body;
      var data = await UserService.getPostedTrips(driver_id);
      if(data != null){
        res.json({success : true, message: "posted trips were successfully retrived", info : data});
      }
      else{
        res.json({success : false, message : "posted trips were not successfully retrieved "});
      }
    }
    catch(e){
        next(e);
    }
}

exports.addSubscription  = async (req,res,next) =>{

    try{
        const {user_id, trip_id,start_date,end_date,seats,discount,price,active} = req.body;
        await UserService.addSubscription(start_date,end_date,price,discount,seats,user_id,trip_id);
        res.json({success : true, message: 'subscription was successfully added' })
    }
    catch(err){
        next(err)
    }
}

exports.getPassengerTripHistory = async (req, res) => {
    try {
        const { passenger_id } = req.body;
        if (!passenger_id) {
            return res.status(400).json({ success: false, message: "passenger_id is required" });
        }
        const trips = await UserService.getPassengerTripHistory(passenger_id);
        res.json({ success: true, message: "Trip history retrieved successfully", info: trips });
    } catch (err) {
        console.error('Error retrieving trip history:', err);
        res.status(500).json({ success: false, message: "Error retrieving trip history", error: err.message });
    }
}





