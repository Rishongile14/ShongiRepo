const app = require('./app');
const db = require('./config/db');
const port = 5001;

app.get('/',(_req,rep) => {
    rep.send('API RUNNING');
});

app.listen(port ,'0.0.0.0', ()=>{
    console.log('api running on port http://localhost:%d',port);
});
