import {Nodo} from './Nodo'
export class Modulo implements Nodo{

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
        
         if(Number(this.hijo3.ejecutar())==0){
                throw {error:"No se puede division entre cero" ,linea:this.linea, Columna:this.columna  
                   };
         }
     return Number(this.hijo1.ejecutar())%Number(this.hijo3.ejecutar());
    }

}