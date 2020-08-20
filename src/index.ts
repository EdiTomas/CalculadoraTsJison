import express,{Application} from  'express';
import  { Router } from 'express';
import morgan from 'morgan';
import cors from 'cors'; 

const parser = require('./Gramatic').parser;
// const st = require('./ms'); 

class Server{
    public app:Application;
    
    constructor(){
       this.app= express();
       this.config();
       this.routes();
    }
     
    config():void {
       this.app.set('port',process.env.PORT ||3000)
       this.app.use(morgan('dev')); 
       this.app.use(cors());
       this.app.use(express.json());   
       this.app.use(express.urlencoded({extended:false}));
    }
    
    routes():void{
        
        this.app.post('/Sintactico', async function(req,res){
                    let entrada = req.body.entrada;  // esto es la respuesta de cliente o requerimiento del cliente
                    let resultado = analisis(entrada); 
                    return res.json(resultado);
          }); 
    }

    start():void{
        this.app.listen(this.app.get('port'),()=>{
           console.log('Server on port',this.app.get('port'))
        });
    }

}


function analisis(entrada:String) {
    try{
        let analizador = parser.parse(entrada);
        console.log(analizador.ejecutar());
        let resp={
            status : "ANALISIS CORRECTO",
            json: analizador
        };
        console.log(resp);
        return resp;
    }catch(e){
       // console.error(e);
        let error = {
            json : "analisis incorrecto"
        }
        console.log(e);
        return error;
    }
}

analisis("(4.5+2)*20");
const server= new Server();
server.start(); 




