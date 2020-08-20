import {Nodo} from './Nodo'
export class Resta implements Nodo{

    public hijo1:Nodo;
    public hijo3:Nodo;
    
    public linea:Number;
    public columna:Number;
    constructor(hijo1:Nodo,hijo3:Nodo,linea:Number,columna:Number){
           this.hijo1=hijo1
           this.hijo3=hijo3
           this.linea=linea
           this.columna=columna 
    }   
 
    ejecutar(){
        return Number(this.hijo1.ejecutar())-Number(this.hijo3.ejecutar());
    }
 

}