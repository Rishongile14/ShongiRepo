const router = require('express').Router();
const userController = require('../controller/user.controller');
const UserService = require('../services/user.service');

router.post('/registration',userController.registerUser);
router.post('/adminregistration',userController.registerAdmin);
router.post('/posttrip',userController.postTrip);
router.get('/getallusers',userController.getAllUsers);
router.get('/getalldriverdetails',userController.getDriverTableDetails);
router.post('/login',userController.searchUser);
router.post('/getusername',userController.getUsername);
router.post('/loginadmin',userController.searchAdmin);
router.post('/searchtrip',userController.searchTrip);
router.post('/addtrip',userController.addTrip);
router.post('/getbooktrips', userController.getBookedTrips);
router.post('/addbookedtrip',userController.addBookedTrip);
router.post('/registercar',userController.registerCar);
router.post('/getcompletedtrips', userController.getCompletedTrips);
router.post('/addcompletedtrip',userController.addCompletedTrip);
router.post('/deletebookedtrip',userController.deleteBookedTrip);
router.post('/getpostedtrips', userController.getPostedTrips);
router.post('/getbookedpassengers',userController.getBookedPassengers);
router.post('/registerdriver',userController.registerdriver);
router.post('/searchdriver',userController.searchdriver);
router.get('/getallpassengers',userController.getAllPassengers);
router.get('/getalldrivers',userController.getAllDrivers);
router.post('/addcomplain',userController.addComplain);
router.get('/getallpassengers',userController.getAllPassengers)
router.post('/getpassengertriphistory', userController.getPassengerTripHistory);

module.exports = router;