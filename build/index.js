"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const morgan_1 = __importDefault(require("morgan"));
const cors_1 = __importDefault(require("cors"));
const parser = require('./Gramatic').parser;
// const st = require('./ms'); 
class Server {
    constructor() {
        this.app = express_1.default();
        this.config();
        this.routes();
    }
    config() {
        this.app.set('port', process.env.PORT || 3000);
        this.app.use(morgan_1.default('dev'));
        this.app.use(cors_1.default());
        this.app.use(express_1.default.json());
        this.app.use(express_1.default.urlencoded({ extended: false }));
    }
    routes() {
        this.app.post('/Sintactico', function (req, res) {
            return __awaiter(this, void 0, void 0, function* () {
                let entrada = req.body.entrada; // esto es la respuesta de cliente o requerimiento del cliente
                let resultado = analisis(entrada);
                return res.json(resultado);
            });
        });
    }
    start() {
        this.app.listen(this.app.get('port'), () => {
            console.log('Server on port', this.app.get('port'));
        });
    }
}
function analisis(entrada) {
    try {
        let analizador = parser.parse(entrada);
        console.log(analizador.ejecutar());
        let resp = {
            status: "ANALISIS CORRECTO",
            json: analizador
        };
        console.log(resp);
        return resp;
    }
    catch (e) {
        // console.error(e);
        let error = {
            json: "analisis incorrecto"
        };
        console.log(e);
        return error;
    }
}
analisis("(4.5+2)*20");
const server = new Server();
server.start();
